component extends="Model"
{
	function config() {
		// Associations
		hasMany(name="rolepermissions", jointype="left");
		hasMany(name="userpermissions");
		nestedProperties(associations="rolepermissions,userpermissions", allowDelete=true);

		// Properties
		validatesUniquenessOf("name");
		validatesPresenceOf("name,type");
		validatesInclusionOf(
			property="type",
			list="named,controller", message="Invalid Permission Type" );

		beforeValidation("validatePermissionName");

	}

	/**
	* This is a bit lazy. Really should use regEx. 
	**/
	function validatePermissionName(){
		if(structKeyExists(this, "name") && structKeyExists(this, "type")){
			if(this.type == 'named'){
				if(this.name CONTAINS "." || this.name CONTAINS " "){
					addError(property="name", message="Named Permission Name should not contain dots or spaces");
				}
			}
			if(this.type == 'controller'){ 
				if(this.name CONTAINS " "){
					addError(property="name", message="Controller Permission Name should not contain spaces");
				}
			}
		}
	}


}
