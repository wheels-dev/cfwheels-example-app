component extends="Model"
{
	function config() {
		// Properties
		validatesPresenceOf("message,type,severity,createdBy,ipaddress");
		afterNew("serializeExtendedData");
	}

	/**
	 * If anything is passed into data, serialize if at all possible
	 */
	function serializeExtendedData() {
		if(structKeyExists(this, "data"))
			 this.data=serializeJSON(this.data);
	}
}
