ruleset trip_store {
	meta {
		name "trip store"
		description << part three of the single pico lab >>
		author "Andrew Manwaring"
		logging on
		sharing on
		provides trips
		provides long_trips
		provides short_trips
		provides parent
		use module b507199x5 alias wranglerOS
	}
	global{
		long_trip = 60;

		trips = function() {
			trips = ent:trips;
			trips;
		};

		long_trips = function() {
			long_trips = ent:long_trips;
			long_trips;
		};

		short_trips = function() {
			all_trips = ent:trips;
			short_trips = all_trips.filter( function(id, val) {
				item = id; //.klog("id is: ");
				values = val; //.klog("val is: ");
				mileage = values{["mileage"]};
				(mileage <= long_trip);
			});
			short_trips;
		}

		parent = function() {
			results = wranglerOS:parents();
			parents = results{"parents"};
			parents
		}
	}
	rule collect_trips {
		select when explicit trip_processed
		pre {
			mileage = event:attr("mileage").klog("Mileage: ");
			timestamp = time:now();
			new_trip = {
				"mileage" : mileage,
				"time" : timestamp
			};
			id = random:uuid();
		}
		always {
			set ent:trips{[id]} new_trip;
		}
	}
	rule collect_long_trips {
		select when explicit found_long_trip
		pre {
			mileage = event:attr("mileage").klog("Mileage: ");
			timestamp = time:now();
			new_trip = {
				"mileage" : mileage,
				"time" : timestamp
			};
			id = random:uuid();
		}
		always {
			set ent:long_trips{[id]} new_trip;
		}
	}
	rule clear_trips {
		select when car trip_reset
		always {
			clear ent:trips;
			clear ent:long_trips;
		}
	}

	rule send_report {
		select when explicit report_requested
		pre {
			mycid = event:attr("mycid");
			attr = {}
				.put(["mycid"], mycid)
				.put(["report"], trips())
				;
		}
		{
			noop();
		}
		always {
			raise explicit event report_gather
				attributes attr;
		}
	}
}