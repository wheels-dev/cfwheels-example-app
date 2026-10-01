/**
 * This is the parent controller file that all your controllers should extend.
 * You can add functions to this file to make them available in all your controllers.
 * Do not delete this file.
 *
 * NOTE: When extending this controller and implementing `config()` in the child controller, don't forget to call this
 * base controller's `config()` via `super.config()`, or else the call to `protectsFromForgery` below will be skipped.
 *
 * Example controller extending this one:
 *
 * component extends="Controller" {
 *   function config() {
 *     // Call parent config method
 *     super.config();
 *
 *     // Your own config code here.
 *     // ...
 *   }
 * }
 */
component extends="wheels.Controller" {
	function config(
		boolean protectFromForgery=true,
		boolean restrictAccess=false,
		boolean redirectAuthenticatedUsers=false,
		boolean logFlash=true
	) {
		// We can skip CSRF from a sub controller if required
		if(arguments.protectFromForgery){
			protectsFromForgery();
		}
		// Require a permission to access this controller?
		if(arguments.restrictAccess){
			filters(through="checkPermissionAndRedirect");
		}
		// Redirect Authenticated Users away from this controller?
		// Example would be to not allow registration or password resets to logged in users
		if(arguments.redirectAuthenticatedUsers){
			filters(through="redirectAuthenticatedUsers");
		}
		// Log the flash in audit log?
		if(arguments.logFlash){
			filters(through="logFlash", type="after");
		}
		// Check for password blocks
		filters(through="checkForPasswordBlock");
	}

	// Include controller wide shared functions
	include "functions/auth.cfm";
	include "functions/filters.cfm";
}
