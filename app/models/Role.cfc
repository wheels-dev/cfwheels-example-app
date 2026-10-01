component extends="Model" {

	function config() {
		// Associations
		hasMany("rolepermissions");

		// Properties
		validatesPresenceOf("name");
		validatesUniquenessOf(properties="name", message="Role name must be unique");
	}

}
