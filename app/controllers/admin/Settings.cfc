component extends="app.controllers.Controller" {

	function config() {
		super.config(restrictAccess=true);
		verifies(except="index", params="key", paramsTypes="integer", handler="objectNotFound");
	}

	/**
	* View all settings
	**/
	function index() {
		settings=model("setting").findAll(order="name");
		settingCategories=[];
		for(setting in settings){
			var s=listFirst(setting.name, "_");
			if(!arrayFind(settingCategories, s)){
				arrayAppend(settingCategories, s);
			}
		}
	}

	/**
	* Edit setting
	**/
	function edit() {
		setting=model("setting").findByKey(key=params.key, where="editable = 1");
	}

	/**
	* Update setting
	**/
	function update() {
		setting=model("setting").findByKey(key=params.key, where="editable = 1");
		if(setting.update(params.setting)){
			redirectTo(action="index", success="Setting successfully updated: you must reload the application for these to take effect.");
		} else {
			renderView(action="edit");
		}
	}

	/**
	* Redirect away if verifies fails, or if an object can't be found
	**/
	private function objectNotFound() {
		redirectTo(action="index", error="That Setting wasn't found");
	}

}
