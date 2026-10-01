/**
 * Wheels 4.1.0 made validation condition/unless strings fail closed: anything the evaluator
 * cannot parse throws Wheels.InvalidValidationCondition instead of silently skipping the
 * validation (CHANGELOG 4.1.0 upgrade note, #3634). These specs drive both conditions the
 * app uses through valid(), so a condition that stopped parsing would error here.
 */
component extends="wheels.WheelsTest" {

	function run() {

		describe("User validation conditions under the 4.1 grammar", () => {

			beforeEach(() => {
				// app/global/auth.cfm reads the session from request.mockSession in testing mode
				request.isTestingMode = true;
				request.mockSession = {};
			});

			afterEach(() => {
				StructDelete(request, "isTestingMode");
				StructDelete(request, "mockSession");
			});

			describe('unless="isAuthenticated()" on terms (a bare call)', () => {

				it("requires terms for an anonymous registration", () => {
					var user = model("user").new(newUserProperties());
					expect(user.valid()).toBeFalse();
					expect(user.errorsOn("terms")).notToBeEmpty();
				});

				it("skips terms when an authenticated admin creates the user", () => {
					request.mockSession.user = {"properties" = {"id" = 1}, "permissions" = {}};
					var user = model("user").new(newUserProperties());
					expect(user.valid()).toBeTrue();
				});

			});

			describe("condition=""StructKeyExists(this, 'updatePassword')"" on password (a whitelisted call)", () => {

				it("does not require a password on a normal update", () => {
					var user = model("user").findByKey(1);
					expect(user.valid()).toBeTrue();
				});

				it("requires a password when updatePassword is set", () => {
					var user = model("user").findByKey(1);
					user.updatePassword = true;
					expect(user.valid()).toBeFalse();
					expect(user.errorsOn("password")).notToBeEmpty();
				});

			});

		});

	}

	private struct function newUserProperties() {
		return {
			"firstname" = "Cond",
			"lastname" = "Itions",
			"email" = "conditions-#CreateUUID()#@example.com",
			"password" = "validPassword123",
			"passwordConfirmation" = "validPassword123"
		};
	}

}
