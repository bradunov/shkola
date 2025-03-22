import argparse
import os
import openai
from openai import OpenAI

import json
import time
import logging



# Only match files <dir>/*.rs.json
def convert_src_to_dst(src_list, directory, src_short, dst_short):
  arr = src_list.split("/")
  arr = arr[-1].split(".")
  if len(arr) != 3 or arr[2] != "json" or arr[1] != src_short:
    return None, None
  arr[1] = dst_short
  dst_list = ".".join(arr)
  dst_path = directory + dst_list
  src_path = directory + src_list
  return src_path, dst_path




# Aggregate all terms to be translated into one dictionary
def accumulate_names(text, d, params):
  list = json.loads(text)
  d[list["name"].strip().lower()] = ""
  d[list["theme"].strip().lower()] = ""

  for q in list["questions"]:
    d[q["subtheme"].strip().lower()] = ""
    d[q["topic"].strip().lower()] = ""

  return d



# Aggregate all terms to be translated into one dictionary
def translate_list(text, d, short_lang):
  list = json.loads(text)
  list["name"] = d[list["name"].strip().lower()]
  list["theme"] = d[list["theme"].strip().lower()]
  list["language"] = short_lang

  for q in list["questions"]:
    q["subtheme"] = d[q["subtheme"].strip().lower()]
    q["topic"] = d[q["topic"].strip().lower()]

  return json.dumps(list, indent=2, ensure_ascii=False)



USE_CHATGPT_4 = False
DEBUG = """
["5 obdelava podatkov", "obdelava podatkov", "uporaba ulomkov", "odstotek", "razmerje", "aritmetično povprečje", "prikaz in obdelava podatkov", "tabela", "krožni diagram", "3 merjenje in mere", "merjenje in mere", "merjenje dolžine", "primerjava mer", "merjenje časa", "računske operacije", "pretvarjanje ene mere v drugo", "merjenje volumna tekočin", "merjenje mase", "7 algebra", "algebra", "algebrski izrazi", "pojem", "polinomi", "seštevanje in odštevanje polinomov", "množenje polinomov", "razcep na faktorje", "kvadrat binoma", "razlika kvadratov", "4 geometrija", "geometrija", "geometrijska telesa", "rogljasta, okrogla", "kvader in kocka", "mreža", "elementi, lastnosti", "3 geometrija", "pravokotnik, kvadrat", "pojem, elementi", "obseg geometrijskih figur", "trikotnik", "kvadrat", "pravokotnik", "površina figure", "merjenje površine z dano mero", "ravnina", "medsebojna lega premic", "kot", "vrste kotov", "krožnica in krog", "pojem, elementi, vrste", "1 geometrija", "položaj, velikost in oblika", "prostorski odnosi", "velikost predmetov in bitij", "geometrijske figure in telesa", "črta", "ravna, ukrivljena, lomljena črta", "odprta, zaprta črta", "zunanje, notranje območje", "2 geometrija", "ravna črta", "točka, premica, polpremica, daljica", "lomljena črta", "odprta, zaprta", "dolžina lomljene črte", "figure", "obseg", "podobnost", "simetrija", "4 števila", "števila", "ulomki", "besedilna naloga", "primerjava ulomkov", "decimalni zapis števila", "naravna števila", "zapis števila, številska prava", "številski niz", "primerjava števil", "seštevanje", "seštevanje in odštevanje", "rimski števili", "množenje", "odštevanje", "številski izraz", "vrstni red računskih operacij", "deljenje", "množenje in deljenje", "enačbe", "neenačbe", "vse računske operacije", "5 algebra", "6 obdelava podatkov", "uporaba racionalnih števil", "razmerje", "prikaz podatkov s diagrami", "stolpčni", "koordinatni sistem", "prikaz podatkov", "linijski", "podatkovno tolmačenje", "prikazano grafično", "prikazano z tabelo", "6 algebra", "z celimi števili", "z racionalnimi števili", "2 števili", "izračun dele dane količine", "števila do 100", "zapis števila, številski prav", "podatki", "tabela in stolpičasti diagram", "3 števili", "števila do 1000", "zapis števila, številski polprav", "8 geometrija", "podobnost", "talejeva izrek", "podobni trikotniki", "uporabe", "točka, premica, ravnina", "odnos točke, premice in ravnine", "ortogonalna projekcija", "polieder", "prizma", "površina", "volumen", "uporaba", "piramida", "valj", "površina, volumen", "kupa", "krogla", "krogla in sfera", "površina in volumen krogle", "8 algebra", "linearni enačbe z eno neznanko", "rešitev", "ekvivalentne enačbe", "ekvivalentne transformacije", "reševanje", "linearne neenačbe z eno neznanko", "ekvivalentne neenačbe", "linearna funkcija", "graf", "implicitna funkcija", "sistemi linearnih enačb z dvema neznankama", "reševanje sistemov", "6 geometrija", "četverokotnik", "paralelogram", "stranice i uglovi", "pojam, vrste, uglovi", "trapez", "podudarne figure", "paralelogram, trougao, trapez, deltoid", "vektor", "1 merenje i mere", "merenje nestandardnim jedinicama mere", "merenje dužine i težine", "4 merenje i mere", "površina kvadrata i pravougaonika", "površina pravougaonika", "površina kvadrata", "površina kocke i kvadra", "površina kocke", "površina kvadra", "merenje zapremine", "merenje površine", "zapremina kocke i kvadra", "zapremina kocke", "zapremina kvadra", "1 brojevi", "brojevi do 10", "brojanje", "brojevi do 20", "pisanje brojeva", "dinar, novčanice do 100 dinara", "izražavanje različitim apoenima", "brojevna prava", "5 prirodni brojevi", "pojam, brojevna prava", "proširivanje, skraćivanje i upoređivanje", "decimalni zapis", "deljivost brojeva", "svojstva deljivosti", "zajednički delilac i sadržalac", "deljivost sa 2, 3, 4, 5, 9, 10", "prosti i složeni brojevi", "brojevni izrazi", "skupovi", "zapis", "podskup, jednaki skupovi", "unija, presek", "razlika", "unija, presek, razlika", "5 geometrija", "osnovni pojmovi", "tačka, prava, duž", "krug", "preslikavanje", "pojam, upoređivanje, vrste", "računanje sa uglovima", "translacija i uglovi", "osna simetrija", "osna simetrija figure", "simetrala duži i ugla", "7 obrada podataka", "duž i mnogougao", "produžena proporcija", "funkcija direktne proporcionalnosti", "uzorak", "srednja vrednost, medijana, mod", "rastojanje tačaka u koord.sistemu", "7 realni brojevi", "realni brojevi", "iracionalni brojevi", "kvadrat racionalnog broja", "kvadratni koren", "približna vrednost", "apsolutna greška", "stepen", "operacije sa stepenima", "stepen proizvoda, količnika i stepena", "7 geometrija", "značajne duži i tačke trougla", "pitagorina teorema", "mnogougao", "vrstе, elementi", "pravilni mnogougao", "obim i površina", "centralni i periferijski ugao", "obim, dužina kružnog luka", "površina kruga, kružnog isečka i kružnog prstena", "rotacija", "2 merenje i mere", "6 brojevi", "racionalni brojevi", "upoređivanje", "pojam, prikaz na brojevnoj pravoj", "celi brojevi", "prikaz na brojevnoj pravoj, upoređivanje", "pojam, suprotan broj, apsolutna vrednost"]
"""


def translate(src_text, params):
  global client

  source_language = params["src_lang"]
  target_language = params["dst_lang"]

  if USE_CHATGPT_4:
    translation = DEBUG
    d = json.loads('{"a": ' + translation + '}')["a"]
    return d


  prompt = f"""
Translate each string in the following python list from {source_language} into {target_language}:.

{src_text}
  """


  finished = False
  while not finished:
    try:
      response = client.chat.completions.create(model=os.environ.get('OPENAI_MODEL'),
      messages=[
          {"role": "system", "content": "You are a helpful assistant that translates text."},
          {"role": "user", "content": prompt}
      ],
      # These are output tokens:
      # We have to have enough to send the prompt, so that the sum of len(prompt) + max_tokens < 5000
      max_tokens=2000,
      n=1,
      stop=None,
      temperature=0.5)

      translation = response.choices[0].message.content.strip()
      finished = True
    except openai.RateLimitError:
      print("RateLimitError: Sleeping 10s")
      time.sleep(10)
      pass
    except Exception as e:
      print(f"Unknown exception happened: {e}")
      print("Sleeping 20s")
      time.sleep(20)
      pass

  # print("---Prompt:", prompt, "|")
  # print("---Response:", response, "|")
  # print("---Translation:", translation, "|")

  d = json.loads('{"a": ' + translation + '}')["a"]
  return d




def translate_dict(d, params):

    text = "["
    trans = []
    cnt = 0
    if USE_CHATGPT_4:
      max_cnt = 5000
    else:
      max_cnt = 50
    for k,v in d.items():
      if cnt > 0:
        text += ", "
      text += '"' + k + '"'
      cnt += 1
      if cnt >= max_cnt:
        text += "]"
        trans.extend(translate(text, params))
        cnt = 0
        text = "[" 

    if cnt > 0:
      text += "]"
      trans.extend(translate(text, params))


    if len(trans) != len(d):
      logging.error(f"Cannot match dict size {len(d)} with translation size {len(trans)}:\n\n{d}\n\n{trans}")
      exit(1)

    # Put translations back in the dict
    cnt = 0
    for k,v in d.items():
      d[k] = trans[cnt]
      cnt += 1

    return d





if __name__ == "__main__":


  # Parse input arguments
  parser = argparse.ArgumentParser(
    prog='translate_lists', 
    epilog="Example: translate_lists.py uk")
  parser.add_argument("language", help="The language (two letter abbreviation)", type=str)
  parser.add_argument("-f", "--file", help="Translate specific list", type=str, default=None)
  parser.add_argument("-l", "--log_level", help="The log level (e.g. debug, info, warning, error)", default="info", type=str)
  parser.add_argument('--icons', action='store_true')
  parser.add_argument('--no-icons', dest='icons', action='store_false')
  parser.set_defaults(icons=True)
  args = parser.parse_args()

  # Set up logging
  logging.basicConfig(level=args.log_level.upper())

  # Check for OPENAI_API_KEY environment variable
  if not os.environ.get('OPENAI_API_KEY'):
    logging.error('OPENAI_API_KEY environment variable not defined')
    raise SystemExit
  elif not os.environ.get('OPENAI_MODEL'):
    logging.error('OPENAI_MODEL environment variable not defined')
    raise SystemExit
  else:
    client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


  # Access input arguments
  file = args.file
  language = args.language
  log_level = args.log_level
  icons = args.icons


  lang_list = {
    "uk": "English",
    "sl": "Slovenian",
    "mk": "Macedonian"
  }

  if language not in lang_list.keys():
    logging.error(f"Language {language} not in the list.")
    raise SystemExit

  params = {
    "directory" : "../lists/",
    "src_lang" : 'Serbian',
    "src_short" : 'rs',
    "dst_lang" : lang_list[language],
    "dst_short" : language
  }

  logging.info(f"Translating into {language}({params['dst_lang']}).")

  if not file:
    # Translate all lists
    if not os.path.isdir(params["directory"]):
      logging.error(f"Path {params['directory']} doesn't exist.")
      raise SystemExit
    lists = os.listdir(params["directory"])
  else:
    # Translate one selected list
    full_path = params["directory"] + file
    if not os.path.isfile(full_path):
      logging.error(f"Path {full_path} doesn't exist or is not a path.")
      raise SystemExit
    lists = [file]


  # First collect a list of all terms to be translated
  d = {}
  for src_list in lists:

    src_path, dst_path = convert_src_to_dst(src_list, \
                  params["directory"], params["src_short"], params["dst_short"])
    if not dst_path:
      continue

    logging.info(f"Collecting strings from {src_path}")

    # Reprocess all files since the list might have changed
    with open(src_path, 'r') as file:
        file_contents = file.read().strip()

    d = accumulate_names(file_contents, d, params)


  # Then translate strings
  logging.info(f"Translating {len(d)} strings...")
  d = translate_dict(d, params)


  # Then replace strings with translations
  for src_list in lists:

    src_path, dst_path = convert_src_to_dst(src_list, \
                  params["directory"], params["src_short"], params["dst_short"])
    if not dst_path:
      logging.debug(f"Skipping {src_list}...")
      continue

    logging.info(f"Processing list {src_path} -> {dst_path}")

    if not os.path.isfile(dst_path):
      logging.info(f"List {dst_path} doesn't exist, creating...")

    with open(src_path, 'r') as file:
        file_contents = file.read().strip()

    trans_text = translate_list(file_contents, d, params["dst_short"])

    with open(dst_path, 'w') as file:
      file.write(trans_text)


  if icons:
    icons_dir = "../src/images/themes/"
    src_file = "icons.rs.json"
    src_path, dst_path = convert_src_to_dst(src_file, \
                    icons_dir, params["src_short"], params["dst_short"])
    if dst_path:
      logging.info(f"Converting icons {src_path} -> {dst_path}")

      with open(src_path, 'r') as file:
        file_contents = file.read().strip().lower()
      src_icons = json.loads(file_contents)
      dst_icons = {}

      for k,v in src_icons.items():
        dst_key = k.strip().lower()
        if dst_key in d.keys():
          dst_icons[d[dst_key]] = v
        else:
          logging.error(f"Couldn't find {dst_key} in translation, skipping")

      with open(dst_path, 'w') as file:
          json.dump(dst_icons, file, indent=2, ensure_ascii=False)

    else:
      logging.error("Couldn't find {src_path}, skipping")



