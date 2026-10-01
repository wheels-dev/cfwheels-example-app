<cfscript>
//=====================================================================
//= 	Global Functions
//=====================================================================
if (StructKeyExists(server, "lucee")) {
	include "install.cfm";
	include "auth.cfm";
	include "logging.cfm";
	include "utils.cfm";
} else {
	// Root-relative includes resolve through the /app mapping in public/Application.cfc
	include "/app/global/install.cfm";
	include "/app/global/auth.cfm";
	include "/app/global/logging.cfm";
	include "/app/global/utils.cfm";
}
</cfscript>
