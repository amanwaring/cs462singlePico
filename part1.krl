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
		{
			send_directive("say") with
				something = "Hello World"
		}
	}
	rule message {
		select when echo message
		pre {
			input = event:attr("input").klog("Input: ");
		}
		{
			send_directive("say") with
				something = input
		}
	}
}