# https://riptutorial.com/python/example/23044/read-the-excel-data-using-xlrd-module
#from xlrd import open_workbook
import xlrd
import json
import argparse
import os.path

defaut_file_name = 'lists.rs.xlsx'
default_path = "../questions"

parser = argparse.ArgumentParser(description="Create ARM template")
parser.add_argument("-f", "--file", help="Input XLS file", type=str, default=defaut_file_name)
parser.add_argument("-p", "--path", help="Path to questions", type=str, default=default_path)

args = parser.parse_args()
file_name = args.file.strip()
path = args.path.strip()

if path[-1] != "/":
  path += "/"


known_languages = ["rs", "uk"]

try:
  language = file_name.split(".")[-2]
  if not language in known_languages:
    raise Exception("Unknown language {}".format(language)) 
except Exception as e:
  print("Problem with language:", e)
  exit(0)

print("Processing language: ", language)


book = xlrd.open_workbook(file_name)

LEVEL = 0
QUESTION = 1
RANDOM = 2
PERIOD = 3
DIFFICULTY = 4
THEME = 5
SUBTHEME = 6
TOPIC = 7
RANK_THEME = 8
RANK_SUBTHEME = 9
RANK_TOPIC = 10
LAST = RANK_TOPIC

lists = {}
themes = {}


for isheet in range(0, book.nsheets):
  sheet = book.sheet_by_index(isheet)
  sheet_name = sheet.name

  assert(sheet.ncols >= LAST)
  for y in range(0, sheet.nrows):

    if y == 0:
      # Skip headers
      continue

    all_empty = True
    any_empty = False
    for x in range(0, LAST):
      all_empty = all_empty and (sheet.cell(y,x).ctype == xlrd.XL_CELL_EMPTY)
      any_empty = any_empty or (sheet.cell(y,x).ctype == xlrd.XL_CELL_EMPTY)

    if not all_empty and not sheet.cell(y,QUESTION).ctype == xlrd.XL_CELL_EMPTY:
      question = str(int(sheet.cell(y,QUESTION).value))
      question = sheet_name + "/q" + "0"*(5-len(question)) + question
      #print("Processing: {}".format(question))

    # If all empty, then skip, otherwise report an error
    if any_empty and not all_empty:
      print("Problem in question {}, row {} - skipping: ".format(question, y), end="")
      for x in range(0, sheet.ncols):
        print("{} ".format(sheet.cell(y,x).value), end="")
      print("")
      continue

    if not all_empty:
      level = int(sheet.cell(y,LEVEL).value)
      random = str(int(sheet.cell(y,RANDOM).value))
      period = str(int(sheet.cell(y,PERIOD).value))
      difficulty = str(int(sheet.cell(y,DIFFICULTY).value))
      theme = sheet.cell(y,THEME).value.strip()
      subtheme = sheet.cell(y,SUBTHEME).value.strip()
      topic = sheet.cell(y,TOPIC).value.strip()
      rank_theme = str(int(sheet.cell(y,RANK_THEME).value))
      rank_subtheme = str(int(sheet.cell(y,RANK_SUBTHEME).value))
      rank_topic = str(int(sheet.cell(y,RANK_TOPIC).value))

      list_file_name = str(level) + "_" + theme.split(" ")[0].lower() + "." + language + ".json"
      list_name = str(level) + " " + theme

      if not os.path.isfile(path + question + "/text." + language): 
        print("Missing: ", path + question + "/text." + language)
      else:
        if list_file_name not in lists.keys():
          lists[list_file_name] = {
            "name" : list_name,
            "level": str(level), 
            "level_short": str(level), 
            "theme" : theme, 
            "language" : language,
            "rank_theme": rank_theme, 
            "questions":  []
          }

        lists[list_file_name]["questions"].append({
          "name" : question, 
          "random": random, 
          "period": period, 
          "subtheme": subtheme, 
          "topic": topic, 
          "rank_subtheme": rank_subtheme, 
          "rank_topic": rank_topic, 
          "difficulty": difficulty
        })

        themes[subtheme] = ""


print("\n\nLista tema:\n")
print(json.dumps(themes, indent=2))


#print(json.dumps(lists, indent=2))
for file_name, content in lists.items():
  with open(file_name, 'w') as outfile:
    json.dump(content, outfile, indent=2, ensure_ascii=False)
