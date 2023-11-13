module token

pub enum TokenType {
	variable
	comma
	number
	string
	op_equal

	right_brace
	left_brace
	left_paren
	right_paren
	left_brack
	right_brack

	/*
	* CONSTANTS
	* */
	boolean_true
	boolean_false
	boolean_default
	boolean_enable
	boolean_disable


	/*
	* BUILTIN FUNCTIONS
	* */
	builtin_function

	/*
	* KEYWORDS
	* */
	keyword_break
	keyword_in
	keyword_cutline

	keyword_if
	keyword_else
	keyword_endif

	keyword_for
	keyword_to
	keyword_step
	keyword_next

	keyword_while
	keyword_loop

	keyword_do
	keyword_until

	keyword_function
	keyword_endfunction
	keyword_private
	keyword_public

	word_undefined
}
