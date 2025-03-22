import argparse
import os
import openai
from openai import OpenAI

import json
import time
import logging







# Check if the translation to <short_lang> has been done
# automatically or manually (by human). 
# If update = True, mark it as auto translation.
def is_auto(directory, filename, short_lang, update=False):

  path = os.path.join(directory, "auto.json")
  wrong_json = False
  try:
      with open(path, 'r') as file:
          json_data = json.load(file)
  except FileNotFoundError:
      json_data = {}
      pass      
  except json.JSONDecodeError:
      with open(path, 'r') as file:
          file_data = file.read()
      if not file_data:
          json_data = {}
      else:
          logging.info(f"Found empty/wrong auto.json file in {directory}, assuming not auto.")
          wrong_json = True
      pass      

  if wrong_json:
    return False

  if filename in json_data.keys() and \
     isinstance(json_data[filename], list) and \
     short_lang in json_data[filename]:
    auto = True
  else:
    auto = False

  if update and not auto:
    # update field in JSON data
    if not filename in json_data.keys():
      json_data[filename] = [short_lang]
    else:
      json_data[filename].append(short_lang)

    # write updated JSON data back into file
    # print(f"Writing auto in {path}: {json_data}")
    with open(path, 'w') as file:
        json.dump(json_data, file, ensure_ascii=False)

  return auto




def translate_text(text, source_language, target_language):
    global client
    prompt = f"""
Translate the following {source_language} text into {target_language}, 
but do not translate code or special tags 
except for the string parts that are in {source_language}.
Special tags start and end with characted '@'. 
Do not put the output text into quotes. 
Make sure you copy over all the code and special tags into the output. 
If there is nothing to translate, just copy over the input text. 
Here is the text: 

{text}
    """

    finished = False
    while not finished:
      try:
        response = client.chat.completions.create(model=os.environ.get('OPENAI_MODEL'),
        messages=[
            {"role": "system", "content": """
You are a helpful software developer who translates text.
The text is in a special format for a web site. 
The format will be described in the prompt. 
Respect the prompt and just translate the text, do not leave any other comments.  
             """},
            {"role": "user", "content": prompt}
        ],
        max_tokens=1500,
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


    return translation



def translate_files(directory, params):
    for filename in os.listdir(directory):
        path = os.path.join(directory, filename)
        if os.path.isdir(path):
            # recursively call translate_files() for subdirectories
            translate_files(path, params)
        else:
            if filename == "init.lua" or filename == "iter.lua":
              # Do not translate code since all messages are extracted into text and terms files
              continue
            arr = filename.split(".")
            lang = arr[1]
            if lang != params["src_short"]:
              # Only consider files in source language
              continue
            arr[1] = params["dst_short"]
            trans_filename =  ".".join(arr)
            trans_path = os.path.join(directory, trans_filename)
            again = False
            if os.path.isfile(trans_path):
              # Dst file already exists
              if is_auto(directory, filename, params["dst_short"], update=False):
                logging.debug(f"{directory}/{trans_filename} already exists and is automatically translated.")
                if not params["repeat"]: 
                  continue
                again = True
              else:
                logging.debug(f"{directory}/{trans_filename} already exists and is manually translated.")
                # We never automatically translate files already translated by human
                continue
            logging.info(f"{directory}: {filename} -> {trans_filename} ({'again' if again else 'new'})")
            is_auto(directory, filename, params["dst_short"], update=True)

            with open(path, 'r') as file:
                file_contents = file.read().strip()

            trans = translate_text(file_contents, params["src_lang"], params["dst_lang"])
            # trans = file_contents

            with open(trans_path, 'w') as file:
                file.write(trans)


            # open file and print contents
            # with open(path, 'r') as file:
            #     file_contents = file.read().strip()
            #     print(file_contents)
            # if filename != "init.lua" and filename != "iter.lua" \
            #    and filename != "terms.rs.lua" and filename != "terms.uk.lua" and filename != "terms.rsc.lua" \
            #    and filename != "text.rs" and filename != "text.uk":
            #   print(path)



if __name__ == "__main__":


  # Parse input arguments
  parser = argparse.ArgumentParser(
    prog='translate_question', 
    epilog="Example: translate_questions.py equat_2/q00026 uk")
  parser.add_argument("path", help="The path to questions relative to questions folder (set to . for all questions)", type=str)
  parser.add_argument("language", help="The language (two letter abbreviation)", type=str)
  parser.add_argument("-r", "--repeat", help="Translate questions again if translation exists", action="store_true")
  parser.add_argument("-l", "--log_level", help="The log level (e.g. debug, info, warning, error)", default="info", type=str)
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
  path = args.path
  language = args.language
  log_level = args.log_level
  repeat = args.repeat


  lang_list = {
    "uk": "English",
    "sl": "Slovenian",
    "mk": "Macedonian"
  }

  if language not in lang_list.keys():
    logging.error(f"Language {language} not in the list.")
    raise SystemExit


  #print(openai.Model.list())



  params = {
    "repeat" : repeat,
    "src_lang" : 'Serbian',
    "src_short" : 'rs',
    "dst_lang" : lang_list[language],
    "dst_short" : language
  }

  full_path = "../questions/" + path

  if not os.path.isdir(full_path):
    logging.error(f"Path {full_path} doesn't exist or is not a path.")
    raise SystemExit



  #filename = '../../questions/equations/q00023/text.rs'
  #filename = '../../questions/equations/q00023/terms.rs.lua'

  #path = '../../questions/equat_2/q00024'
  #path = '../../questions/equat_2'
  #path = '../../questions'


  logging.info(f"Translating {path} from rs/Serbian into {language}/{lang_list[language]}")
  translate_files(full_path, params)



