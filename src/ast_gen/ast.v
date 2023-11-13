module ast_gen

pub struct Ast {
	ast_typ AstType
	name string
	mod string
	is_public bool
	operator string
	statements []Ast
	expression []Ast
	params []Ast
	val string
	typ string
}

pub fn gen_ast() {

}
