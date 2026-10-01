<!--- User Search/Filter --->
<cfparam name="roles">
<cfparam name="params.q">
<cfparam name="params.roleid">
<cfparam name="params.status">
<cfoutput>
#startFormTag(route="users", method="get", class="form-inline mb-2")#
	<div class="row">
	    <div class="col">
				#selectTag(name="roleid", options=roles, includeBlank="All Roles", selected=params.roleid, label="Role", prependToLabel="<div class=""form-group mb-2"">", labelClass="sr-only")#
		</div>
	    <div class="col">
			 #selectTag(name="status", options="Active,Pending,Disabled,All",  selected=params.status, label="Status", prependToLabel="<div class=""form-group mb-2"">", labelClass="sr-only")#
		</div>

		<div class="col">
			#textFieldTag(name="q", value=params.q, label="Keyword Search", labelClass="sr-only", placeholder="Keyword")#
		</div>

	    <div class="col">
			#submitTag(value="Filter", class="btn btn-info")#
		</div>
	</div>
#endFormTag()#
</cfoutput>
