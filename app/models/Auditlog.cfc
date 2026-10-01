component extends="Model"
{
	function config() {
		// Properties
		validatesPresenceOf("message,type,severity,createdBy,ipaddress");
	}

	/**
	 * Builds a new (unsaved) log line, serializing whatever is passed as `data` to JSON first.
	 *
	 * Wheels 4 refuses to mass-assign a struct or array to a scalar column
	 * (Wheels.PropertyIsIncorrectType), so `data` has to be a string before it reaches new().
	 * Call this on the class object: model("auditlog").newEntry(properties).
	 *
	 * @properties The log line's properties; `data` may be any value
	 */
	function newEntry(required struct properties) {
		local.properties = Duplicate(arguments.properties);
		if (StructKeyExists(local.properties, "data")) {
			local.properties.data = SerializeJSON(local.properties.data);
		}
		return new(local.properties);
	}
}
