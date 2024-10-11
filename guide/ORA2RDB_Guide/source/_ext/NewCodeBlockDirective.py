from __future__ import annotations

import sys

from docutils import nodes
from docutils.parsers.rst import directives


from sphinx import addnodes
from sphinx.directives import optional_int
from sphinx.locale import __
from sphinx.util import logging, parselinenos
from sphinx.util.docutils import SphinxDirective
from docutils.statemachine import StringList
import re
import json
import os


def format_caption(input_string):
    pattern = r'\$'
    formatted_string = re.sub(pattern, r'\\$', input_string)
    pattern = r'_'
    formatted_string = re.sub(pattern, r'\_', formatted_string)
    pattern = r'\`\`(.*?)\`\`'
    formatted_string = re.sub(pattern, r'\\texttt{\1}', formatted_string)
    return formatted_string

def cut_statement(input_string):
    output_string = input_string.replace("select ", "").replace("from rdb$database;", "")
    return output_string

def setsub(input_string, replacement_list):
    result = input_string
    for item in replacement_list:
        result = result.replace("%s", str(item), 1)
    return result


def parsefile(idtest):
    codeblock = []
    idtest = str(idtest)
    code = ""
    with open("./source/examples/examples.json", "r") as f:
        data = json.load(f)
    for command in data[idtest].keys():
        comment = ""
        for item in data[idtest][command].keys():
            if item == "code":
                code = '\n'.join(data[idtest][command]["code"])
            elif item == "substitutions":
                code = setsub(code, data[idtest][command]["substitutions"])
            elif item == "hide_select":
                code = cut_statement(code)
            elif item == "newline":
                if data[idtest][command]["newline"] == "no":
                    code = code + "-- "
                else:
                    code = code + "\n"
            elif item == "result":
                result = '\n'.join(data[idtest][command]["result"])
                code = code + result
            elif item == "comment":
                comment = '\n'.join(data[idtest][command]["comment"])
                code = code + comment
        codeblock.append(code)
    return codeblock

def set_condition(lines, color):
    lines = lines.replace(" ", "")
    pattern = r','
    lines = re.sub(pattern, r' \\or ', lines)
    pattern = r'(\d+)'
    lines = re.sub(pattern, r'\\value{FancyVerbLine}=\1', lines)
    return '\\ifthenelse{'+lines + '}{\\textcolor{' + color + '}{#1}}{#1}'

def set_command_sphinxVerbatimFormatLine(condition):
    return '\\renewcommand\\sphinxVerbatimFormatLine[1]{' + condition + '}'

def remove_ifcert(content):
    result = []
    pattern = r':testrole:\`(.+?)\`'
    for line in content:
        if ":testrole:" not in line:
            result.append(line)
        else:
            line = re.sub(pattern, r'\1', line) # то вставляем все строки с :testrole:
            result.append(line)
    return result

def formatstr(green_condition,red_condition):
    pattern = r'}}{#1}'
    return re.sub(pattern, r'}}{' + (green_condition.encode('unicode_escape')).decode() + r'}', red_condition)

class ReCodeBlock(SphinxDirective):
    has_content = True
    required_arguments = 0
    optional_arguments = 1
    final_argument_whitespace = False
    option_spec: OptionSpec = {
        'force': directives.flag,
        'linenos': directives.flag,
        'lineno-start': int,
        'emphasize-lines': directives.unchanged_required,
        'redlines': directives.unchanged_required,
        'greenlines': directives.unchanged_required,
        'bluelines': directives.unchanged_required,
        'caption': directives.unchanged_required,
        'class': directives.class_option,
        'name': directives.unchanged,
        'include': directives.unchanged_required,
    }


    def run(self) -> list[Node]:
        if 'caption' in self.options:
            prefix = '\\noindent \\textit{\\textbf{' + self.options.get('caption', '') + '}}\\vspace{-5pt}'
        else:
            prefix = ''
        document = self.state.document
        if 'include' in self.options:
            idtest = self.options.get('include')
            code = '\n'.join(parsefile(idtest))
        else:
            self.content = remove_ifcert(self.content)
            code = '\n'.join(self.content)

        location = self.state_machine.get_source_and_line(self.lineno)

        prefix = prefix + r'\fvset{formatcom=\color{black}}'

        linespec = self.options.get('emphasize-lines')
        if linespec:
            prefix = prefix + r'\fvset{formatcom=\color{green!40!black}}'
            try:
                nlines = len(self.content)
                hl_lines = parselinenos(linespec, nlines)
                if any(i >= nlines for i in hl_lines):
                    logger.warning(__('line number spec is out of range(1-%d): %r') %
                                   (nlines, self.options['emphasize-lines']),
                                   location=location)

                hl_lines = [x + 1 for x in hl_lines if x < nlines]
            except ValueError as err:
                return [document.reporter.warning(err, line=self.lineno)]
        else:
            hl_lines = None

        color_condition = 0
        red_condition = ''
        green_condition = ''
        blue_condition = ''
        redlines = ''
        greenlines = ''
        if 'redlines' in self.options:
            color_condition += 1
            redlines = self.options.get('redlines', '')
            red_condition = set_condition(redlines, 'red!40!white')
        if 'greenlines' in self.options:
            color_condition += 1
            greenlines = self.options.get('greenlines', '')
            green_condition = set_condition(greenlines, 'green!40!black')
        if 'bluelines' in self.options:
            color_condition += 10
            bluelines = self.options.get('bluelines', '')
            blue_condition = set_condition(bluelines, 'blue!40!black')
        if color_condition == 1 or color_condition == 10:
            prefix = prefix + set_command_sphinxVerbatimFormatLine(green_condition+red_condition+blue_condition)
        elif color_condition == 2:
            formatted_string = formatstr(green_condition,red_condition)
            prefix = prefix + set_command_sphinxVerbatimFormatLine(formatted_string)
        elif color_condition == 11:
            if redlines != '':
               formatted_string = formatstr(red_condition,blue_condition)
            else:
                formatted_string = formatstr(green_condition,blue_condition)
            prefix = prefix + set_command_sphinxVerbatimFormatLine(formatted_string)
        elif color_condition == 12:
               formatted_string = formatstr(red_condition,blue_condition)
               formatted_string = formatstr(green_condition,formatted_string)
               prefix = prefix + set_command_sphinxVerbatimFormatLine(formatted_string)



        literal: Element = nodes.literal_block(code, code)
        if 'linenos' in self.options or 'lineno-start' in self.options:
            literal['linenos'] = True
        literal['classes'] += self.options.get('class', [])
        literal['force'] = 'force' in self.options
        if self.arguments:
            literal['language'] = self.env.temp_data.get('highlight_language',
                                                         self.config.highlight_language)
            prefix = prefix + '\\redstatementstyle'
            arg = self.arguments[0]
            if arg.lower()=='redstatement':
                prefix = prefix + '\\redstatementstyle'
            elif arg.lower()=='redexample':
                prefix = prefix + '\\redexamplestyle'
            elif arg.lower()=='redbordless':
                prefix = prefix + '\\redbordlessstyle'
            elif arg.lower()=='sql':
                literal['language'] = arg
        else:
            prefix = prefix + '\\redstatementstyle'
            literal['language'] = self.env.temp_data.get('highlight_language',
                                                         self.config.highlight_language)

        extra_args = literal['highlight_args'] = {}
        if hl_lines is not None:
            extra_args['hl_lines'] = hl_lines
        if 'lineno-start' in self.options:
            extra_args['linenostart'] = self.options['lineno-start']
        self.set_source_info(literal)
        self.add_name(literal)


        latex_prefix = nodes.raw('', prefix, format='latex')
        return [latex_prefix, literal]

def setup(app):
    app.add_directive('code-block', ReCodeBlock)

