component extends="app.controllers.Controller" {

	function config() {
		super.config(restrictAccess=true);
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
	}

	/**
	* View all roles
	**/
	function index() {
		roles=model("role").findAll();
	}
	/**
	* Add New Role
	**/
	function new() {
		role=model("Role").new();
	}

	/**
	* Create Role
	**/
	function create() {
		role=model("Role").create(params.Role);
		if(Role.hasErrors()){
			renderView(action="new");
		} else {
			redirectTo(action="index", success="Role successfully created");
		}
	}
	/**
	* Edit role
	**/
	function edit() {
		role=model("role").findByKey(params.key);
	}

	/**
	* Update role
	**/
	function update() {
		role=model("role").findByKey(params.key);
		if(role.update(params.role)){
			redirectTo(action="index", success="Role successfully updated");
		} else {
			renderView(action="edit");
		}
	}

	/**
	* Redirect away if verifies fails, or if an object can't be found
	**/
	private function objectNotFound() {
		redirectTo(action="index", error="That Role wasn't found");
	}

}
