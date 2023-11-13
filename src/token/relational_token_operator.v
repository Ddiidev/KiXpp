module token

pub const operators_tok = {
	`=`: TokenType.op_equal
	`{`: TokenType.left_brace
	`}`: TokenType.right_brace
	`(`: TokenType.left_paren
	`)`: TokenType.right_paren
	`[`: TokenType.left_brack
	`]`: TokenType.right_brack
	`,`: TokenType.comma
	`'`: TokenType.string
	`"`: TokenType.string
}
