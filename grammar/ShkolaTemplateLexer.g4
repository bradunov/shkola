// ANTLR4 Lexer Grammar for the Shkola question template language.
//
// The language is a text template with embedded directives/expressions
// delimited by @ markers. The lexer uses modes to cleanly separate
// text content from directive content.
//
// Usage:
//   antlr4 -Dlanguage=Python3 -visitor ShkolaTemplateLexer.g4 ShkolaTemplateParser.g4
//   antlr4 -Dlanguage=Java -visitor ShkolaTemplateLexer.g4 ShkolaTemplateParser.g4   (for Android)
//   antlr4 -Dlanguage=Swift -visitor ShkolaTemplateLexer.g4 ShkolaTemplateParser.g4  (for iOS)

lexer grammar ShkolaTemplateLexer;

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
