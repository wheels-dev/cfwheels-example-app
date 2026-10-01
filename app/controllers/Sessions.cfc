component extends="app.controllers.Controller" {

	function config() {
		super.config();
		verifies(post=true, only="create");
		filters(through="checkRememberMeCookie", only="new,create");
		filters(through="redirectAuthenticatedUsers", only="new,create");
	}

	/**
	* Login user form: uses tableless model for validation
	**/
	function new(){
		auth=model("auth." & getSetting('authentication_gateway')).new();
	}

	/**
	* Login a user: create an instance of the tableless Auth model, runs its validation, and if ok,
	* Creates the session
	**/
	function create(){
		auth=model("auth." & getSetting('authentication_gateway')).new(params.auth);
		if(!auth.hasErrors() && auth.login()){
			addLogLine(type="auth", severity="info", message="User #getSession().user.properties.email# successfully logged in");
			redirectTo(route="root");
		} else {
			addLogLine(type="auth", severity="danger", message="Failed Login", data=auth.allErrors());
			// TO DO : add brute force attack mitigation
			renderView(action="new");
		}
	}

	/**
	* Logs out a user
	**/
	function delete(){
		// Grab this before killing getSession()
		var nameofLogginOutUser=getSession().user.properties.email;
		// Kill session
		forcelogout();
		// Add Log
		addLogLine(type="auth", severity="info", message="User #nameofLogginOutUser# logged out");
		// does this insertFlash ever work?
		redirectTo(route="root", success="You have been logged out");
	}

	/**
	* Forgets a users remember me cookie
	**/
	function forget(){
		deleteCookieRememberEmail();
		redirectTo(route="login");
	}

	/**
	 * Looks for remember me cookie
	 */
	private function checkRememberMeCookie() {
		usingRememberMeCookie  = structkeyexists(cookie, "REMEMBERME") && len(cookie.rememberme) ? true : false;
		savedEmail = usingRememberMeCookie ? decryptString(cookie.rememberme) : "";
	}
}
