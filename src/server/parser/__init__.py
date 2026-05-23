"""
Template parser for the Shkola question language.

Implements the grammar defined in grammar/ShkolaTemplate.g4:
  template : element* EOF
  element  : text | directive
  text     : TEXT
  directive: '@' CONTENT '@'

The parser tokenizes a template string into TEXT and DIRECTIVE tokens,
then builds a simple AST that a visitor can walk to render output.
"""
from __future__ import annotations
from dataclasses import dataclass, field
from typing import List


# ============ AST Nodes ============

@dataclass
class TextNode:
    """Plain text content outside @ delimiters."""
    content: str


@dataclass
class DirectiveNode:
    """Content between @ delimiters — may be a keyword or Lua expression."""
    content: str


@dataclass
class TemplateNode:
    """Root node containing a list of elements."""
    elements: List[TextNode | DirectiveNode] = field(default_factory=list)


# ============ Tokenizer / Parser ============

def parse_template(source: str) -> TemplateNode:
    """Parse a template string into a TemplateNode AST.

    The parsing follows the grammar:
    - TEXT is everything outside @ markers (with \\ before newline treated as continuation)
    - DIRECTIVE is everything between a pair of @ markers

    Raises ValueError if an unclosed @ delimiter is found.
    """
    elements: List[TextNode | DirectiveNode] = []
    pos = 0
    length = len(source)

    while pos < length:
        # Find next @
        at_pos = source.find('@', pos)

        if at_pos == -1:
            # Rest is text
            elements.append(TextNode(source[pos:]))
            break

        # Text before the @
        if at_pos > pos:
            elements.append(TextNode(source[pos:at_pos]))

        # Find closing @
        close_pos = source.find('@', at_pos + 1)
        if close_pos == -1:
            raise ValueError(
                f"Unclosed @ delimiter at position {at_pos}: "
                f"'{source[at_pos:at_pos+20]}...'"
            )

        # Content between @ markers
        content = source[at_pos + 1:close_pos]
        elements.append(DirectiveNode(content))

        pos = close_pos + 1

    return TemplateNode(elements=elements)


# ============ Visitor Base Class ============

class TemplateVisitor:
    """Base visitor for walking a TemplateNode AST.

    Override visit_text and visit_directive in subclasses to implement
    rendering or other processing.
    """

    def visit(self, node: TemplateNode) -> str:
        """Visit all elements and concatenate results."""
        result = []
        for element in node.elements:
            if isinstance(element, TextNode):
                result.append(self.visit_text(element))
            elif isinstance(element, DirectiveNode):
                result.append(self.visit_directive(element))
        return ''.join(result)

    def visit_text(self, node: TextNode) -> str:
        """Process a text node. Override in subclass."""
        return node.content

    def visit_directive(self, node: DirectiveNode) -> str:
        """Process a directive node. Override in subclass."""
        return ''
