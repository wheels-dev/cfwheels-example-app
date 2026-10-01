component extends="Model" {

	function config() {

		super.config(logChanges=true);

		// Associations
		belongsTo("role");
		hasMany("userpermissions");

		// Properties
		validatesPresenceOf("firstname,lastname,email");
		validatesUniquenessOf("email");
		validatesFormatOf(property="email", allowBlank=true, type="email");

		// More Password Checks
		validate("additionalPasswordValidation");

		// When a user is created by registration (i.e, not being created by an authenticated user)
		// Then require the prescence of a checked terms and conditions box
		validatesPresenceOf(
			property="terms", when="onCreate", unless="isAuthenticated()",
			message="You must agree to the terms and conditions");

		// Protected certain properties from mass assignment
		protectedProperties("roleid,verified");

		// Callbacks
		beforeValidation("sanitize,setIgnoreLogProperties");
		beforeUpdate("setPasswordLastChanged");

		// Password handling: formerly the authenticateThis plugin, now app code on the
		// framework's bcryptHash()/bcryptVerify() helpers (Wheels 4.1).
		validatesPresenceOf(property="password", when="onCreate");
		validatesPresenceOf(property="password", when="onUpdate", condition="StructKeyExists(this, 'updatePassword')");
		validatesFormatOf(
			property="password", regEx="^.*(?=.{8,})(?=.*\d)(?=.*[a-z]).*$", allowBlank=true,
			message="Password must be at least 8 characters long and contain a mixture of numbers and letters");
		validatesConfirmationOf(property="password");
		beforeValidation("hashPassword");

	}

	/**
	* Sanitizes the user object
	*/
	function sanitize() {
		if(structKeyExists(this, "firstname"))
			this.firstname = sanitizeInput(this.firstname);
		if(structKeyExists(this, "lastname"))
			this.lastname = sanitizeInput(this.lastname);
		if(structKeyExists(this, "email"))
			this.email = sanitizeInput(this.email);
	}

	/**
	 * Check Password doesn't exist within Email
	 */
	function additionalPasswordValidation() {
		if(structKeyExists(this, "password")
			&& structKeyExists(this, "email")
			&& this.email CONTAINS this.password
		)
			this.addError(property="password", message="Your password should not be part of your email address");
	}

	/**
	* Generates a verification token on register
	*/
	function generateVerificationToken() {
		this.verificationToken	= $generateToken();
	}

	/**
	* Marks a user as verified
	*/
	function verifyUser() {
		this.verificationToken	= "";
		this.verified = 1;
	}

	/**
	* Generates a password reset token and sets the time token was created
	*/
	function generatePasswordResetToken() {
		this.passwordResetToken 	= $generateToken();
		this.passwordResetTokenAt 	= Now();
	}

	/**
	* Runs on successful password update via passwordresettoken
	* Will also get cleared on successful login
	*/
	function clearPasswordResetToken(){
		this.passwordResetToken = "";
		this.passwordResetTokenAt = "";
	}

	/**
	* When using the super.config() logging changed values feature, we might not want to log datasensitive values
	* Such as password hashes; it can be useful for development to leave this out so you can see exactly where things
	* are changing in more complex callbacks
	**/
	function setIgnoreLogProperties(){
		this.ignoreLogProperties = "password,passwordConfirmation,passwordHash,loggedinat";
	}

	/**
	* Update the passwordReset timestamp when the password changes: done as a call back so we don't have to duplicate
	* ourselves in password resets vs account resets
	**/
	function setPasswordLastChanged(){
		if(structKeyExists(this, "passwordHash") && this.hasChanged("passwordHash"))
			this.passwordResetAt = now();
	}

	/**
	* Hashes a plaintext `password` into `passwordHash` (bcrypt, cost 12, as the plugin used).
	* Runs before validation whenever a password has been set.
	**/
	function hashPassword() {
		if(structKeyExists(this, "password"))
			this.passwordHash = bcryptHash(this.password, 12);
	}

	/**
	* Checks a plaintext password against the stored hash. bcryptVerify() compares in
	* constant time and accepts the existing $2a$ hashes the plugin's BCrypt.class wrote.
	**/
	boolean function checkPassword(required string password) {
		return bcryptVerify(arguments.password, this.passwordHash);
	}

	/**
	* Sets a random temporary password and flags that it must be changed on next login.
	* Saves without validation (the caller hashes it afterwards, see admin.Users.reset()).
	**/
	boolean function resetPassword() {
		this.password = generateRandomPassword();
		this.passwordChangeRequired = true;
		return this.update(validate=false);
	}

	/**
	* Generates a 12 character random password with at least one lowercase letter,
	* one uppercase letter and one number.
	**/
	string function generateRandomPassword() {
		local.charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		local.result = [
			Mid(local.charset, RandRange(1, 26, "SHA1PRNG"), 1),
			Mid(local.charset, RandRange(27, 52, "SHA1PRNG"), 1),
			Mid(local.charset, RandRange(53, 62, "SHA1PRNG"), 1)
		];
		for(local.i = 1; local.i <= 9; local.i++)
			ArrayAppend(local.result, Mid(local.charset, RandRange(1, 62, "SHA1PRNG"), 1));
		CreateObject("java", "java.util.Collections").shuffle(local.result);
		return ArrayToList(local.result, "");
	}

	/**
	* Internal: Generate a token for use in password reset emails
	**/
	function $generateToken() {
		return Replace(LCase(CreateUUID()), "-", "", "all");
	}


}
