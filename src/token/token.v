module token

import entities

pub struct Token {
pub:
	typ TokenType
	line int
	position int
	value string
}

pub fn (mut t []Token) include(token_type TokenType, l entities.ILexer, value string) {
	t << Token{
		typ: token_type
		line: l.line
		position: l.position
		value: value
	}
}

pub fn (t Token) str() string {
	return '${t.line}  ${t.position}  ${t.typ}  ${t.value.replace("\n", "\\n")}'
}
