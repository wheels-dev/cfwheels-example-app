<cfscript>
	/*
		If you leave these settings commented out, CFWheels will set the data source name to the same name as the folder the application resides in.
	*/

	// set(dataSourceName="");
	// set(dataSourceUserName="");
	// set(dataSourcePassword="");

	/*
		If you leave this setting commented out, CFWheels will try to determine the URL rewrite capabilities automatically.
		The "URLRewriting" setting can bet set to "on", "partial" or "off".
		To run with "partial" rewriting, the "cgi.path_info" variable needs to be supported by the web server.
		To run with rewriting set to "on", you need to apply the necessary rewrite rules on the web server first.
	*/

	// Reload your application with ?reload=true&password=<your WHEELS_RELOAD_PASSWORD>
	// The secret comes from .env (git-ignored) or the OS environment. An empty value
	// disables URL reloads entirely: Wheels 4 fails closed rather than allowing them.
	set(reloadPassword=env("WHEELS_RELOAD_PASSWORD", ""));

	// Your Apps datasource name
	set(dataSourceName="exampleApp");

	// Turn on new flashAppend Behaviour
	set(flashAppend = true);

	// Optional: Create SQL files when migrating
	// Useful for debugging
	// set(writeMigratorSQLFiles=true);

	// Turn on URL rewriting by default.
	// Commandbox urlrewrite.xml is provided.
	// See https://guides.cfwheels.org/docs/url-rewriting for Apache/IIS etc
	set(URLRewriting="On");

	// Don't include potentially sensitive data in error handling emails
	set(excludeFromErrorEmail="password,passwordHash,passwordResetToken");
	set(sendEmailOnError=false); // TODO: change this

//=====================================================================
//= 	Bootstrap 4 form settings
//=====================================================================
	// Submit Tag
	set(functionName="submitTag", class="btn btn-primary", value="Save Changes");

	// Checkboxes and Radio Buttons
	set(functionName="hasManyCheckBox,checkBox,checkBoxTag", labelPlacement="aroundRight", prependToLabel="<div class='form-check'>", appendToLabel="</div>", uncheckedValue="0", encode="attributes", class="form-check-input");
	set(functionName="radioButton,radioButtonTag", labelPlacement="aroundRight", prependToLabel="<div class='radio'>", appendToLabel="</div>");

	// Text/select/password/file Fields
	set(functionName="textField,textFieldTag,select,selectTag,passwordField,passwordFieldTag,textArea,textAreaTag,fileFieldTag,fileField",
		class="form-control",
		labelClass="control-label",
		labelPlacement="before",
		prependToLabel="<div class='form-group'>",
		prepend="<div class=''>",
		append="</div></div>",
		encode="attributes"  );

	// Date Pickers
	set(functionName="dateTimeSelect,dateSelect", prepend="<div class='form-group'>", append="</div>", timeSeparator="", minuteStep="5", secondStep="10", dateOrder="day,month,year", dateSeparator="", separator="");

	// Pagination
	// paginationNav() replaces the deprecated paginationLinks() in Wheels 4; viewStyle="bootstrap4"
	// renders <nav><ul class="pagination"><li class="page-item">... without hand-built wrappers.
	set(functionName="paginationNav", viewStyle="bootstrap4");

	// Error Messagss
	set(functionName="errorMessagesFor", class="alert alert-dismissable alert-danger");
	set(functionName="errorMessageOn", wrapperElement="div", class="alert alert-danger");

	// Password Fields
	set(functionName="passwordField,passwordFieldTag", autocomplete="off");

// CLI-Appends-Here
</cfscript>
