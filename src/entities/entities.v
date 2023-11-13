module entities

pub interface ILexer {
	code string
mut:
	line     int
	position int
	idx int
}
