<!---
  The Main Header + Navigation
--->
<cfoutput>
<header>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
  #linkTo(route="root", class="navbar-brand", text=getSetting('general_sitename'))#
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">

      <!---
        These links should show and hide depending on the Users permissions
        The only catch with this approach is that they might have a permission "lower" down the chain
        than the one you're testing for.
      --->
      <cfif hasPermission("admin.users.index")>
        <li class="nav-item">
           #linkTo(route="users", class="nav-link", text="Users")#
        </li>
      </cfif>

      <cfif hasPermission("admin.settings.index")>
        <li class="nav-item">
           #linkTo(route="settings", class="nav-link", text="Settings")#
        </li>
      </cfif>

      <cfif hasPermission("admin.permissions.index")>
        <li class="nav-item">
           #linkTo(route="permissions", class="nav-link", text="Permissions")#
        </li>
      </cfif>

      <cfif hasPermission("admin.roles.index")>
        <li class="nav-item">
           #linkTo(route="roles", class="nav-link", text="Roles")#
        </li>
      </cfif>

      <cfif hasPermission("admin.auditlogs.index")>
        <li class="nav-item">
           #linkTo(route="logs", class="nav-link", text="Logs")#
        </li>
      </cfif>

    </ul>
      <ul class="navbar-nav ml-auto">
      <!---
          If the user's logged in, show their Account Link etc
          Otherwise show a login btn
      --->

      <cfif isAuthenticated()>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" id="navbarDropdown" data-toggle="dropdown" href="##" role="button" aria-haspopup="true" aria-expanded="false">#e(getSession().user.properties.email)#</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <cfif hasPermission("accounts.show")>
          #linkTo(route="account", class="dropdown-item", text="Account")#
          <div class="dropdown-divider"></div>
        </cfif>
        #linkTo(route="logout", class="dropdown-item", text="Logout")#
        </div>
      </li>

      <cfelse>
         <li>#linkTo(route="login", class="btn btn-outline-primary", text="Login")#</li>
      </cfif>

    </ul>

  </div>
</nav>
</header>
</cfoutput>
