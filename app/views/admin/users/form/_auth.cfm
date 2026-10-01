<cfoutput>
	#panel(title="Initial Password", class="mb-2")#
	<div class="row">
		<div class="col">
			#passwordField(objectName="user", property="password", label="Password")#
		</div>

		<div class="col">
			#passwordField(objectName="user", property="passwordConfirmation", label="Confirm Password")#
		</div> 
	</div> 
#panelEnd()#
</Cfoutput>
