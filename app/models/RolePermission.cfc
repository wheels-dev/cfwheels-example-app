component extends="Model" {

	function config() {
		// Associations
		belongsTo("role");
		belongsTo("permission");

		// Properties
		validatesPresenceOf("roleid,permissionid");
	}

}
