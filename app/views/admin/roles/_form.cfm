<!--- Role Form Contents --->
<cfoutput>

#panel(title="Role Details", class="mb-2")#
	<div class="row">
		<div class="col">
			#textField(objectName="role", property="name", label="Name")#
		</div>
		<div class="col">
			#textField(objectName="role", property="description", label="Description")#
		</div>
	</div>
#panelEnd()#

<!--- CLI-Appends-Here --->
</cfoutput>
