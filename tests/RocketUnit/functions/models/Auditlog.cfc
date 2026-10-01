component extends="tests.RocketUnit.Test" {

	function setup(){
		super.setup();
		params = {
			"message" = "This is a test Log Message",
			"type" = "testsuite",
			"severity" = "info",
			"createdBy" = "TestSuite",
			"ipaddress" = "0.0.0.0"
		};
	}

	function teardown(){
		super.teardown();
	}

	function test_validation_passes(){
		log = model("auditlog").newEntry(params);
		assert("log.valid()");
	}

	function test_validation_fails(){
		log = model("auditlog").new();
		assert("!log.valid()");
	}

	function test_data_simpleValue(){
		params.data = "I am a string";
		log = model("auditlog").newEntry(params);
		r = log.properties();
		assert("log.valid()");
		assert("isJSON(r.data)");
	}

	function test_data_array(){
		params.data = ["one", "two", "three"];
		log = model("auditlog").newEntry(params);
		r = log.properties();
		assert("log.valid()");
		assert("isJSON(r.data)");
	}

	function test_data_struct(){
		params.data = {
			"one" = "foo", "two" = "bar", "three" = "baz"
		};
		log = model("auditlog").newEntry(params);
		r = log.properties();
		assert("log.valid()");
		assert("isJSON(r.data)");
	}
}
