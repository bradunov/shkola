# https://riptutorial.com/python/example/23044/read-the-excel-data-using-xlrd-module
#from xlrd import open_workbook
import xlrd
import json

file_name = 'lists.rs.xlsx'
book = xlrd.open_workbook(file_name)

LEVEL = 0
QUESTION = 1
RANDOM = 2
PERIOD = 3
DIFFICULTY = 4
THEME = 5
SUBTHEME = 6
TOPIC = 7
LAST = TOPIC

lists = {}

language = file_name.split(".")[-2]

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
      theme = sheet.cell(y,THEME).value
      subtheme = sheet.cell(y,SUBTHEME).value
      topic = sheet.cell(y,TOPIC).value

      list_file_name = str(level) + "_" + theme.split(" ")[0].lower() + "." + language + ".json"
      list_name = str(level) + " " + theme

      if list_file_name not in lists.keys():
        lists[list_file_name] = {
          "name" : list_name,
          "level": str(level), 
          "level_short": str(level), 
          "theme" : theme, 
          "language" : language,
          "questions":  []
        }

      lists[list_file_name]["questions"].append({
        "name" : question, 
        "random": random, 
        "period": period, 
        "subtheme": subtheme, 
        "topic": topic, 
        "difficulty": difficulty
      })


#print(json.dumps(lists, indent=2))
for file_name, content in lists.items():

  # Tmp: do not convert level 5
  if file_name[0] == '5':
    continue
  
  with open(file_name, 'w') as outfile:
    json.dump(content, outfile, indent=2, ensure_ascii=False)
