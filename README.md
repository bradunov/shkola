# Shkola

Shkola is a web framework for exercising math for primary school kids.
It is used to run [tatamata.org](https://www.tatamata.org/) web site. 
Its current focus is on Serbian language and curriculum, but it can be easily extended to other countries and languages (please reach out if you are interested in helping).

*RS:* Video prezentaciju o Shkoli/Tatamati mozete pogledati [ovde](https://youtu.be/rSYrRwMJ4Vg).


## Structure

Shkola has five main parts:
- A simple language to express math questions and an "engine" that can visualise questions expressed in the language.
- A test framework that groups questions into lists, select random questions from the list according to certain criteria, and logs the results per user. 
- A web app with a child-friendly design that runs on a web server and presents questions to kids in a browser.   
- A dev web app that allows users to try and test new questions (but not to store them).
- A large list of carefully curated math questions for primary school kids. 

Shkola supports multiple languages. It is designed so that the layout for each language is expressed in a separate file, and the scripts are shared among languages. 





## Shkola language

Shkola language is desinged as a mix of [Lua](https://www.lua.org/) scripts used to create randomized questions and a very simple layout language that can output text and simple vector graphic and provide basic inputs.

Each question is expressed through several files:
- `text.<language>` expresses the layout of the question. This file is mandatory. It can include simple vector graphics and input fields. It can also include inlined lua script commands. Finally, it can include a single loop which is used to create a several instances on the same template question on one page. There could be several `text.<langauge>` files, one for each supported language. 
- `init.lua` is the Lua script that executes at the beginning of parsing question. It is used to set variables that will be used within `text.<language>` to display the question. 
- `iter.lua` is the Lua scripts that executes at the beginning of each iteration of the loop in `text.<langauge>`, if such a loop exists.
See the following [directory](questions/numbers/q00001) for an example of a question.

In addition to this, there are global Lua scripts that are placed in the [global](questions/global) directory. These are executed at the beginning of every questions. Script files with name `<name>.<language>.lua` are executed only when `<language>` is selected. 

The layout language is a simple markup language that encapsulate special commands and Lua scripts inside @@ quotes. 
There is a [library module](src/server/library.py) that implements Lua wrappers for many basic visualisation elements, such as HTML inputs and SVG vector elements. 
Vector graphics can be displayed by creating a canvas and adding basic elements (squares, triangles, etc) onto the canvas. 
The following [document](docs/language_help.md) has a brief summary of supported quotes, library functions and other useful elements. 

Each question is rendered as a HTML with some JavaScript. The JavaScript is most notably used to clear inputs or to submit them to the web site for checking. 




## Testing framework

Questions can be organized in lists according to years and themes. 
These lists are stored as JSON files in [lists](lists) directory. 
One question can be placed into multiple lists and assigned different attributes, such as subtheme, topic, and difficulty. 
There are a few special question attributes. Attributes `rank_*` define question ordering within `*` category.
Different questions have different level of randomness and attribute `random` defines up to how many times should a question appear in a test before repeating itself. 

It is also possible to define lists in an XLS file, and use the [following script](lists/convert_xlsx_to_json.py) to convert it into JSON lists. Note that new versions of xlrd do not support XLSX files. To install a supported version, type
```
pip3 uninstall xlrd
pip3 install xlrd==1.2.0
```

The testing framework also provides a basic [logic](src/server/test.py) for selecting questions from a list. It can randomly select questions from a given theme, subtheme or topic, with different difficulties. 
It also consider previously asked questions and takes care to repeat questions according to the value of `random` attribute. 




## Web apps

The above frameworks can be used in any Python based web app. However, Shkola provides its own web app. This is a web app that can be exposed to children to practice math. It includes  Google authentication, basic session management, and logging of responses. To learn how to install it, please check [Install](docs/install.md) document.

The web app also has a developer mode. In this mode the app lists all the questions and lists. It can be used to visualise all questions, and also to try out new questions. However, it does not provide online question management system - it does not store new or modified questions. These should be copied to an editor and manually stored locally. 




## Math questions

Probably the most valuable part of Shkola is a large list of curated and tested [math questions](questions) for primary school kids, [listed](lists) according to years and themes. 





## Contributions

Shkola is an open source project released under [MIT](LICENSE) license and open to contributions. 













