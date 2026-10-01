/**
 * BDD conversion of tests/RocketUnit/functions/models/Auditlog.cfc.
 *
 * RocketUnit -> WheelsTest, side by side:
 *   component extends="tests.RocketUnit.Test"  ->  component extends="wheels.WheelsTest"
 *   setup() / teardown()                       ->  beforeEach() / afterEach() inside describe()
 *   function test_validation_passes()           ->  it("passes validation ...", () => { ... })
 *   assert("log.valid()")                       ->  expect(log.valid()).toBeTrue()
 *   assert("isJSON(r.data)")                    ->  expect(r.data).toBeJSON()
 */
component extends="wheels.WheelsTest" {

	function run() {

		describe("Auditlog", () => {

			beforeEach(() => {
				variables.properties = {
					"message" = "This is a test Log Message",
					"type" = "testsuite",
					"severity" = "info",
					"createdBy" = "TestSuite",
					"ipaddress" = "0.0.0.0"
				};
			});

			it("passes validation with message, type, severity, createdBy and ipaddress", () => {
				var log = model("auditlog").newEntry(variables.properties);
				expect(log.valid()).toBeTrue();
			});

			it("fails validation when empty", () => {
				var log = model("auditlog").new();
				expect(log.valid()).toBeFalse();
				expect(log.errorsOn("message")).notToBeEmpty();
			});

			describe("newEntry() serializes data to JSON", () => {

				it("serializes a simple value", () => {
					variables.properties.data = "I am a string";
					var log = model("auditlog").newEntry(variables.properties);
					expect(log.valid()).toBeTrue();
					expect(log.properties().data).toBeJSON();
				});

				it("serializes an array", () => {
					variables.properties.data = ["one", "two", "three"];
					var log = model("auditlog").newEntry(variables.properties);
					expect(log.valid()).toBeTrue();
					expect(DeserializeJSON(log.properties().data)).toBe(["one", "two", "three"]);
				});

				it("serializes a struct", () => {
					variables.properties.data = {"one" = "foo", "two" = "bar", "three" = "baz"};
					var log = model("auditlog").newEntry(variables.properties);
					expect(log.valid()).toBeTrue();
					expect(DeserializeJSON(log.properties().data)).toHaveKey("two");
				});

			});

			it("rejects a struct passed straight to new(), as Wheels 4 does for any scalar column", () => {
				variables.properties.data = {"one" = "foo"};
				expect(() => {
					model("auditlog").new(variables.properties);
				}).toThrow(type = "Wheels.PropertyIsIncorrectType");
			});

		});

	}

}
