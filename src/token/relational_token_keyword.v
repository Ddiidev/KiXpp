module token

pub const keywords_tok = {
	'?': TokenType.keyword_cutline
	'if': TokenType.keyword_if
	'else': TokenType.keyword_else
	'endif': TokenType.keyword_endif

	'for': TokenType.keyword_for
	'to': TokenType.keyword_to
	'step': TokenType.keyword_step
	'next': TokenType.keyword_next

	'while': TokenType.keyword_while
	'loop': TokenType.keyword_loop

	'do': TokenType.keyword_do
	'until': TokenType.keyword_until

	'in': TokenType.keyword_in
	'break': TokenType.keyword_break

	'function': TokenType.keyword_function
	'endfunction': TokenType.keyword_endfunction
	'private': TokenType.keyword_private
	'public': TokenType.keyword_public
}
