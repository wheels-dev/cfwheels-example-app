/**
 * Base for the legacy RocketUnit tests. wheels.Test is deprecated in Wheels 4 and removed in 5.0,
 * so `wheels upgrade check` keeps flagging the extends below until every test is converted.
 * Run these at /wheels/tests/app (add ?format=json for JSON). New tests are WheelsTest BDD specs
 * under tests/specs/ (run with `wheels test` or /wheels/app/tests); see tests/specs/models/AuditlogSpec.cfc.
 */
component extends="wheels.Test" {

	/**
	 * Executes once before the test suite runs.
	 */
	function beforeAll() {
	}

	/**
	 * Executes before every test case (unless overridden in a package without calling super.setup()).
	 */
	function setup() {
		// NOTE: These tests require URL rewriting to work as they occasionally test for strings like /login (as opposed to /index.cfm/login/)
		// Add a flag so that we know we're in testing mode; this is used to swap out scopes such as sessions and the
		// main application settings
		request.isTestingMode=true;
		request.mockSession={};
		request.mockApplication={
			"authentication_gateway" = "Local",
			"permissions_cascade" = true,
			"authentication_allowRegistration" = true,
			"authentication_allowPasswordResets" = true,
			"general_sitename" = "Example App (TESTING)",
			"general_copyright" = ""
		};
	}

	/**
	 * Executes after every test case (unless overridden in a package without calling super.teardown()).
	 */
	function teardown() {
		request.isTestingMode=false;
		request.mockSession={};
		request.mockApplication={};
	}

	/**
	 * Executes once after the test suite runs.
	 */
	function afterAll() {
	}

	/**
	* Helpers:
	**/
	function loginFakeUser(){
		request.mockSession.user={
			"properties" = {
				"id": 1,
				"email": "admin@domain.com"
			},
			"permissions" = {
				"accounts" = true
			}
		};
	}

	function logoutFakeUser(){
		request.mockSession={};
	}

}
