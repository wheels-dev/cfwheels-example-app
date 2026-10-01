<cfoutput>
#panel(title="User Options", class="mb-2")#
<div class="row">
	<div class="col">
		#select(objectName="user", property="roleid", options=roles, label="Role")#
	</div>
	<div class="col">
		#checkBox(objectname="user", property="verified", label="Verified")#
		#checkbox(objectName="user", property="passwordchangerequired", label="Require Change of Password on Next Login")#
	</div>
</div>
#panelEnd()#
</Cfoutput>

