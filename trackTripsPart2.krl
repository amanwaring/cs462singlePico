ruleset track_trips_part_2 {
	meta {
		name "track trips part 2"
		description << part two of the single pico lab >>
		author "Andrew Manwaring"
		logging on
		sharing on
	}
	global{

	}
	rule process_trip {
		select when car new_trip
		pre {
			mileage = event:attr("mileage").klog("Mileage: ");
		}
		{
			send_directive("trip") with
				trip_length = mileage
		}
	}
}