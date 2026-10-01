<cfoutput>

#pageHeader(title="Welcome")#

<p class="lead">This is an example App using CFWheels 2.x and some Bootstrap</p>
<cfif !isAuthenticated()>
	<p>Why don't you #linkTo(route="login", text="Login?")#</p>
<cfelse>
	<p>Cool beans bro. <cfif hasPermission("accounts.show")> Check out your #linkTo(route="account", text="Account")#.</cfif></p>
</cfif>
</cfoutput>
