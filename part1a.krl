ruleset track_trips {
	meta {
		name "track trips"
		description << part one of the single pico lab >>
		author "Andrew Manwaring"
		logging on
		sharing on
	}
	global{

	}
	rule process_trip {
		select when echo message
		pre {
			mileage = event:attr("mileage").klog("Mileage: ");
		}
		{
			send_directive("trip") with
				trip_length = mileage
		}
	}
}