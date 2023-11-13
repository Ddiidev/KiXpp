module lexer

import token { Token }
import strings

const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'

const numbers = [`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `.`]

const variable = letters + '0123456789'

const white_space = [` `, `\t`, `\n`, `\r`]

const str = [`"`, `'`]

const scapes = [
	'\\t', '\\r', '\\n', '\\"', "\\'"
]

@[noinit]
pub struct Lexer {
	code string
pub mut:
	line     int = 1
	position int = 1
mut:
	idx int
}

fn (mut l Lexer) reset() {
	l.line = 1
	l.position = 1
	l.idx = 0
}

fn (mut l Lexer) next() ?u8 {
	curr_char := l.code[l.idx..l.idx + 2] or {
		defer {
			l.reset()
		}
		return none
	}

	if curr_char == '\n\r' {
		l.line += 2
		l.idx++
	} else if curr_char[0] in [`\n`, `\r`] {
		l.line++
	}

	l.idx++
	l.position++
	return curr_char[0]
}

fn (mut l Lexer) previous() ? {
	if l.position >= 1 {
		l.idx--
	} else {
		return none
	}
}

fn (l Lexer) is_scape() bool {
	// println('<- ${l.code[l.idx-2 .. l.idx]} : (${l.code[l.idx-2 .. l.idx] in scapes}) ->')
	return l.code[l.idx-2 .. l.idx] in scapes
}

[params]
struct ParamsGetToken {
pub:
	start_position ?int = 1
	start_line     ?int
	end_line       ?int
	end_postion    ?int
}

fn (l Lexer) get_token(at ParamsGetToken) !string {
	return if at.start_position != none {
		l.code[at.start_position! .. l.idx]
	} else {
		return error('not possible get token from locate ({${at}})')
	}
}

pub fn new(code string) Lexer {
	return Lexer{
		code: code
	}
}

pub fn (mut l Lexer) scan() ![]Token {
	mut tokens := []Token{}
	mut current_text := ''

	for current in l {
		current_text += current.ascii_str()

		if current in lexer.white_space {
			current_text = current_text#[0 .. -1]
			if current_text.len > 1 {
				tokens.include(.word_undefined, l, current_text)
			}
			current_text = ''
		} else if current in lexer.str {
			start_pos_string := l.idx - 1

			for curr_string in l {
				if curr_string == current && !l.is_scape() {
					tokens << Token{
						typ: .string
						line: l.line
						position: start_pos_string
						value: l.get_token(start_position: start_pos_string)!
					}
				 	break
				}
			}
			current_text = ''
		} else if current == `$` {
			start_pos_variable := l.idx - 1

			for curr_variable in l {
				if !lexer.variable.contains_u8(curr_variable) || curr_variable == `$` {
					l.previous()
					tokens << Token{
						typ: .variable
						line: l.line
						position: start_pos_variable
						value: l.get_token(start_position: start_pos_variable)!
					}
					break
				}
			}
			current_text = ''
		} else if current in lexer.numbers {
			start_pos_numbers := l.idx - 1

			for current_number in l {
				if current_number !in lexer.numbers {
					l.previous()
					number := l.get_token(start_position: start_pos_numbers)!
					tokens << Token{
						typ: .number
						line: l.line
						position: l.position
						value: number
					}
					break
				}
			}
			current_text = ''
		} else if current_text in token.constants_tok {
			tokens << Token{
				typ: token.constants_tok[current_text]
				line: l.line
				position: l.position
				value: current_text
			}
			current_text = ''
		} else if current_text in token.builtin_functions_tok {
			tokens << Token{
				typ: token.builtin_functions_tok[current_text]
				line: l.line
				position: l.position
				value: current_text
			}
			current_text = ''
		} else if current_text in token.keywords_tok {
			tokens << Token{
				typ: token.keywords_tok[current_text]
				line: l.line
				position: l.position
				value: current_text
			}
			current_text = ''
		} else if current in token.operators_tok {
			current_text = current_text#[0 .. -1]
			if current_text.len > 1 {
				tokens.include(.word_undefined, l, current_text)
			}
			tokens << Token{
				typ: token.operators_tok[current]
				line: l.line
				position: l.position
				value: current.ascii_str()
			}
			current_text = ''
		}
	}

	return tokens
}
