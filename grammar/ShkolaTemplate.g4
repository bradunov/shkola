// ANTLR4 Grammar for the Shkola question template language.
//
// The language is a text template with embedded directives/expressions
// delimited by @ markers. The lexer uses modes to cleanly separate
// text content from directive content.
//
// Usage:
//   antlr4 -Dlanguage=Python3 -visitor -o ../src/server/parser ShkolaTemplate.g4
//   antlr4 -Dlanguage=Java -visitor ShkolaTemplate.g4       (for Android)
//   antlr4 -Dlanguage=Swift -visitor ShkolaTemplate.g4      (for iOS)

grammar ShkolaTemplate;

// ============ Parser Rules ============

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

// ============ Lexer Rules ============

// Default mode: outside @ delimiters — everything is TEXT
// Line continuation: backslash followed by newline is consumed as whitespace
TEXT
    : ( ~[@\\]+ | '\\' ~[\r\n] | '\\' '\r'? '\n' )+
    ;

// Opening delimiter switches to INSIDE mode
AT
    : '@' -> pushMode(INSIDE)
    ;

// ---- INSIDE mode: between @ delimiters ----
mode INSIDE;

// Closing delimiter returns to default mode
AT_CLOSE
    : '@' -> popMode
    ;

// Directive content: everything between the @ delimiters
CONTENT
    : ~[@]+
    ;
