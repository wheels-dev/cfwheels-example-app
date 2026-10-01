component extends="app.controllers.Controller" {

	function config() {
		super.config(restrictAccess=true);
		verifies(except="index", params="key", paramsTypes="integer", handler="objectNotFound");
		filters(through="filterGetAllRoles");
	}

	/**
	* View all permissions
	**/
	function index() {
		allroles=model("role").findAll(order="name");
		allpermissions=model("permission").findAll();
	}

	/**
	* Edit permission
	**/
	function edit() {
		permission=model("permission").findByKey(key=params.key, include="rolepermissions");
	}

	/**
	* Update permission
	**/
	function update() {
		permission=model("permission").findByKey(params.key);
		if(permission.update(params.permission)){
			redirectTo(action="index", success="Permission successfully updated: you must reload the application for these to take effect.");
		} else {
			renderView(action="edit");
		}
	}

	/**
	* Redirect away if verifies fails, or if an object can't be found
	**/
	private function objectNotFound() {
		redirectTo(action="index", error="That permission wasn't found");
	}

}
