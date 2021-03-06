import requests
import requests.cookies
import httpx
import time
import trio
import json



#url = "http://shkola.vladap.com:7071/main"
url = 'https://www.tatamata.org'
#url = 'http://tatamata-test2.westeurope.cloudapp.azure.com/main'
#url = "http://shkola.vladap.com:8080/main"

number_of_runs_per_user = 1
number_of_users = 10


DEBUG = False


http_timeout_s = 10
number_of_question_in_test = 5


test_params = {
  "login_anon" : {"op" : "login_anon", "language" : "rs"},
  "logout" : {"op" : "logout", "language" : "rs"},
  "year" : {"op" : "menu_year", "language" : "rs"},
  "theme" : {"op" : "menu_theme", "year" : "2", "language" : "rs"},
  "intro" : {"op" : "intro", "year" : "2", "language" : "rs", \
    "l_id":"2_brojevi.rs", "theme":"Brojevi", "subtheme":"*", "period":"*", "difficulty":"*"},
  "question" : {"op" : "test", "year" : "2", "language" : "rs", "q_id":"numbers/q00157", \
    "l_id":"2_brojevi.rs", "theme":"Brojevi", "subtheme":"brojevi%20do%20100", "period":"*", "difficulty":"*",
    "q_num":"1", "q_diff":"1", "language":"rs", "design":"dev"}
  #"question" : {"op" : "test", "year" : "2", "language" : "rs", \
  #  "l_id":"2_brojevi.rs", "theme":"Brojevi", "subtheme":"*", "period":"*", "difficulty":"*"}
}






def print_stats(samples):
  for k,v in samples.items():
    v.sort()
    perc_10 = v[int(len(v)*0.1)]
    perc_50 = v[int(len(v)*0.5)]
    perc_90 = v[int(len(v)*0.9)]
    avg = sum(v) / len(v)
    print(f"  {k}: #samples={len(v)}, avg={avg}, percentiles(10/50/90)={perc_10}-{perc_50}-{perc_90}")




def add_stats(samples, key, start_time, end_time):
  if key not in samples.keys():
    samples[key] = []
  samples[key].append(end_time-start_time)




def get_page_name(page):
  # Page name is stored in a meta tag, for testing
  start_ind = 0
  while True:
    meta_ind = page.find("meta", start_ind)
    if meta_ind == -1:
      return None
    end_ind = page.find(">", meta_ind)
    if end_ind == -1:
      return None
    s = page[meta_ind + len("meta"):end_ind]
    start_ind = end_ind

    name_ind = s.find("name")
    if name_ind == -1:
      continue
    p1_ind = s.find('"', name_ind)
    if p1_ind == -1:
      continue
    p2_ind = s.find('"', p1_ind+1)
    if p2_ind == -1:
      continue
    if not s[p1_ind+1:p2_ind] == "page":
      continue

    content_ind = s.find("content")
    if content_ind == -1:
      continue
    p1_ind = s.find('"', content_ind)
    if p1_ind == -1:
      continue
    p2_ind = s.find('"', p1_ind+1)
    if p2_ind == -1:
      continue
    return s[p1_ind+1:p2_ind]
  return None




class WrongPageError(Exception):
  pass

class HTTPError(Exception):
  pass


async def session_op(id, samples, get_method, op, jar=None, page_name=None, iter=1):
  if (op == "final"):
    # Last page is also question, but generates final result instead
    # The caller needs to know when is the last question
    pop = "question"
  else:
    pop = op

  if not page_name:
    page_name = op

  params=test_params[pop]
  if pop == "question":
    params["q_num"] = iter

  # For tracking users in the server log for debugging 
  params["user_id"] = id

  if DEBUG:
    print(f"\n#{id} Requesting URL: {url}")
  start_time = time.time()
  r = await get_method(url, params=params, cookies=jar, timeout=http_timeout_s)
  end_time = time.time()

  if DEBUG:
    print(f"#{id} Requested url: {r.url}")
    print(f"#{id} Obtained page name: {get_page_name(r.text)}")
    #print(f"#{id} Received header: {r.headers}\n")
    #print(f"#{id} Received cookies: {r.cookies['shkola_session_id']}\n")

  if not r.status_code == 200:
    #print(f"Error code {r.status_code}")
    add_stats(samples, "http_error", start_time, end_time)
    raise HTTPError
    return False, r
  elif not page_name == get_page_name(r.text):
    print(f"#{id}/#{iter} Wrong page, expecting {page_name}, got {get_page_name(r.text)}")
    add_stats(samples, "wrong_page", start_time, end_time)
    raise WrongPageError
    return False, r
  else:
    add_stats(samples, op, start_time, end_time)
    return True, r




async def session_login(id, samples, get_method):
  resp, r = await session_op(id, samples, get_method, "login_anon", page_name="confirm_anon")
  if resp:
    session_id = r.cookies["shkola_session_id"]
    jar = requests.cookies.RequestsCookieJar()
    jar.set('shkola_session_id', session_id)
    if DEBUG:
      print(f"#{id} Logged in, session id: {session_id}")
    return resp, jar
  else:
    return resp, None




async def test_session(id, no, samples, get_method):
  if DEBUG:
    print(f"#{id} starting user task {no}")

  try:
    resp, jar = await session_login(id, samples, get_method)
    if not resp:
      return False
  except Exception as e:
    print(f"#{id} EXCEPTION during login: {e}")
    return False

  try:
    await session_op(id, samples, get_method, "year", jar)
    await session_op(id, samples, get_method, "theme", jar)
    await session_op(id, samples, get_method, "intro", jar)
    for i in range(0, number_of_question_in_test):
      await session_op(id, samples, get_method, "question", jar, iter=i+1)
    await session_op(id, samples, get_method, "final", jar, "summary")
  except Exception as e:
    print(f"#{id} EXCEPTION: {e}")
    try:
      await session_op(id, samples, get_method, "logout", jar, "user")
    except Exception as e:
      print(f"#{id} EXCEPTION during logout: {e}")
      pass
    return False

  try:
    await session_op(id, samples, get_method, "logout", jar, "user")
  except Exception as e:
    print(f"#{id} EXCEPTION during logout: {e}")
    return False

  if DEBUG:
    print(f"#{id} user task {no} done")
  return True




async def get_page(id, samples):
  async with httpx.AsyncClient() as client:
    for i in range(0,number_of_runs_per_user):
      if id == 0:
        print(".", end="", flush=True)
      await test_session(id, i, samples, client.get)




async def async_test():
  list_of_samples= []
  for i in range(0,number_of_users):
    list_of_samples.append({})
  async with trio.open_nursery() as nursery:
    for i in range(0,number_of_users):
      nursery.start_soon(get_page, i, list_of_samples[i])

  # Aggregage samples from all users
  list_of_all_samples = {}
  for i in range(0,number_of_users):
    for k, v in list_of_samples[i].items():
      if k in list_of_all_samples.keys():
        list_of_all_samples[k] += v
      else:
        list_of_all_samples[k] = v

  print("", flush=True)

  # No need to print per user
  # for i in range(0,number_of_users):
  #   print(f"Samples user {i+1}:")
  #   print_stats(list_of_samples[i])

  print(f"Aggregate samples:")
  print_stats(list_of_all_samples)
  #print(json.dumps(list_of_samples, indent=2))




if __name__ == "__main__":


  print("\nIMPORTANT: if you run this in windows, run from PowerShell, not WSL!\n")
  print(f"Target URL: {url}")

  # Async still doesn't work - needs fixing, if we decide we need it
  print(f"Running {number_of_runs_per_user} runs for each of {number_of_users} users:", end="", flush=True)
  trio.run(async_test)

  # samples = {}
  # print("\n\nSync:", end="", flush=True)

  # for i in range(0,number_of_runs_per_user):
  #   print(".", end="", flush=True)
  #   test_session(samples, requests.get)

  # print("")

  # print_stats(samples)

