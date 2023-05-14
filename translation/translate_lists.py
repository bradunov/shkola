import argparse
import os
import openai
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
def translate_list(text, d):
  list = json.loads(text)
  list["name"] = d[list["name"].strip().lower()]
  list["theme"] = d[list["theme"].strip().lower()]

  
  for q in list["questions"]:
    q["subtheme"] = d[q["subtheme"].strip().lower()]
    q["topic"] = d[q["topic"].strip().lower()]

  return json.dumps(list, indent=2, ensure_ascii=False)




# DEBUG = """
# ["2 measurement and units", "measurement and units", "length measurement", "comparison of measures", "conversion of one measure to another", "time measurement", "arithmetic operations", "7 algebra", "algebra", "algebraic expressions", "concept", "polynomials", "addition and subtraction of polynomials", "multiplication of polynomials", "factoring", "square of a binomial", "difference of squares", "7 real numbers", "real numbers", "irrational numbers", "square of a rational number", "square root", "multiplication and division", "decimal representation", "approximate value", "absolute error", "addition and subtraction", "numerical expression", "power", "operations with powers", "power of a product, quotient, and power", "6 geometry", "geometry", "quadrilateral", "parallelogram", "triangle", "concept, elements, types", "sides and angles", "congruence", "concept, types, angles", "trapezoid", "area of a figure", "congruent figures", "rectangle, square", "parallelogram, triangle, trapezoid, deltoid", "vector", "5 algebra", "equations", "application of fractions", "inequalities", "6 data processing", "data processing", "application of rational numbers", "percentage", "proportion", "data representation by diagrams", "bar", "coordinate system", "data representation", "line", "data interpretation", "graphically represented", "represented in a table", "5 natural numbers", "natural numbers", "fractions", "concept, number line", "expansion, reduction, and comparison", "divisibility of numbers", "properties of divisibility", "common divisor and common multiple", "divisibility by 2, 3, 4, 5, 9, 10", "prime and composite numbers", "numerical expressions", "sets", "notation", "subset, equal sets", "union, intersection", "difference", "union, intersection, difference", "1 numbers", "numbers", "numbers up to 10", "counting", "addition", "subtraction", "number comparison", "numbers up to 20", "numbers up to 100", "number writing", "number sequence", "dinar, banknotes up to 100 dinars", "expression in different denominations", "number line", "8 algebra", "linear equations with one unknown", "solution", "equivalent equations", "equivalent transformations", "solving", "application", "linear inequalities with one unknown", "equivalent inequalities", "linear function", "graph", "implicit function", "1 geometry", "position, size, and shape", "spatial relations", "size of objects and beings", "geometric figures and solids", "line", "straight, curved, broken line", "open, closed line", "external, internal area", "2 geometry", "straight line", "point, line, ray, segment", "broken line", "open, closed", "length of a broken line", "figures", "perimeter", "symmetry", "3 numbers", "comparing fractions", "word problem", "decimal representation of a number", "numbers up to 1000", "number notation, number ray", "order of arithmetic operations", "multiplication", "division", "Roman numerals", "all arithmetic operations", "1 measurement and units", "measurement with nonstandard units", "length and weight measurement", "7 data processing", "line and polygon", "extended proportion", "direct proportionality function", "sample", "average value, median, mode", "distance between points in coord. system", "6 algebra", "with integers", "with rational numbers", "6 numbers", "rational numbers", "comparison", "concept, representation on the number line", "whole numbers", "representation on the number line, comparison", "concept, opposite number, absolute value", "3 measurement and measures", "measurement of liquid volume", "measurement of mass", "4 numbers", "number notation, number line", "4 measurement and measures", "surface area of a square and a rectangle", "surface area of a rectangle", "surface area of a square", "surface area of a cube and a cuboid", "surface area of a cube", "surface area of a cuboid", "measurement of volume", "measurement of surface area", "volume of a cube and a cuboid", "volume of a cube", "volume of a cuboid", "5 data processing", "ratio", "arithmetic mean", "display and data processing", "table", "pie chart", "5 geometry", "basic concepts", "point, line, segment", "circle", "mapping", "angle", "concept, comparison, types", "calculations with angles", "translation and angles", "axial symmetry", "axial symmetry of a figure", "perpendicular bisector of a segment and an angle", "6 coordinate system", "dependence among magnitudes", "coordinates of points", "7 geometry", "significant lines and points of a triangle", "Pythagorean theorem", "polygon", "types, elements", "regular polygon", "perimeter and area", "central and peripheral angle", "perimeter, length of a circular arc", "area of a circle, circular sector and circular ring", "2 numbers", "calculating part of a given size", "number notation, number line", "data", "table and bar diagram", "3 geometry", "concept, elements", "perimeter of geometric figures", "square", "rectangle", "measurement of area with a given measure", "line", "mutual position of lines", "types of angles", "circle and disk", "4 geometry", "geometric solids", "angular, round", "cuboid and cube", "net", "elements, properties"]
# """



def translate(src_text, params):

  source_language = params["src_lang"]
  target_language = params["dst_lang"]

  # DEBUG - ChatGPT 3.5 misses some strings.   
  # translation = DEBUG
  # d = json.loads('{"a": ' + translation + '}')["a"]
  # return d


  prompt = f"""
Translate each string in the following python list from {source_language} into {target_language}:.

{src_text}
  """


  finished = False
  while not finished:
    try:
      response = openai.ChatCompletion.create(
          model="gpt-3.5-turbo",
          messages=[
              {"role": "system", "content": "You are a helpful assistant that translates text."},
              {"role": "user", "content": prompt}
          ],
          # These are output tokens:
          # We have to have enough to send the prompt, so that the sum of len(prompt) + max_tokens < 5000
          max_tokens=2000,
          n=1,
          stop=None,
          temperature=0.5,
      )

      translation = response.choices[0].message.content.strip()
      finished = True
    except openai.error.RateLimitError:
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
    # For now we set this to be very long
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
  else:
    openai.api_key = os.getenv("OPENAI_API_KEY")


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
      logging.info(f"List {dst_list} doesn't exist, creating...")

    with open(src_path, 'r') as file:
        file_contents = file.read().strip()

    trans_text = translate_list(file_contents, d)

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
        dst_icons[d[k.strip().lower()]] = v

      with open(dst_path, 'w') as file:
          json.dump(dst_icons, file, indent=2, ensure_ascii=False)

    else:
      logging.error("Couldn't find {src_path}, skipping")



