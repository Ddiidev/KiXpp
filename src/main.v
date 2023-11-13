module main

import os
import cli
import lexer

fn main() {
	mut app := cli.Command{
		name: 'KiXtart++'
		disable_man: true
		disable_help: true
		version: '0.0.1'
		usage: '[args/stdin]'
		sort_flags: true
		description: 'Language with toolkit for KiXtart language'
		commands: [
				cli.Command{
				name: 'help'
				description: 'Help about the tool'
				execute: fn (cmd cli.Command) ! {
					cli.print_help_for_command(cmd)!
				}
			},
		]
		execute: compile
	}
	app.setup()
	app.parse(os.args)
}

fn compile(cmd cli.Command) ! {

	file_readed := if os.exists(cmd.args[0] or { '' }) {
		os.read_file(cmd.args[0])!
	} else {
		return error("File '${cmd.args[0] or {''}}' not exist")
	}

	mut lex := lexer.new(file_readed)
	tokens := lex.scan()!

	for tok in tokens {
		dump(tok)
	}
}
