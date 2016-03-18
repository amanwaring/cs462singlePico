ruleset part_one {
	meta {
		name "Part One"
		description << part one of the single pico lab >>
		author "Andrew Manwaring"
		logging on
		sharing on
	}
	global{

	}
	rule hello {
		select when echo hello
		always {
			send_directive("say") with
				something = "Hello World"
		}
	}
	rule message {
		select when echo message
		always {
			send directive("basketball") with
				truth = "rocks"
		}
	}
}