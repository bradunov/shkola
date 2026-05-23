// ANTLR4 Parser Grammar for the Shkola question template language.
//
// Pair this with ShkolaTemplateLexer.g4 for the full grammar.

parser grammar ShkolaTemplateParser;

options { tokenVocab=ShkolaTemplateLexer; }

template
    : element* EOF
    ;

element
    : text
    | directive
    ;

text
    : TEXT
    ;

directive
    : AT content AT_CLOSE
    ;

content
    : CONTENT
    ;
