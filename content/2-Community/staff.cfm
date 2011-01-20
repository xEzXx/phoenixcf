<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("/config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<cfset CurrentStyle = getProfileString(iniFile, "settings", "style")>
<!-- Read config.ini settings & apply them -->

<cfinclude template = "/system/functions/checkusersession.cfm" />
<cfinclude template = "/system/functions/loadsettings.cfm" />

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<cfinclude template = "/system/functions/hdr_generic.cfm" />
	<cfinclude template = "/system/functions/hdr_user.cfm" />
</head> 
 
<body> 
 
<div class="mainBox"> 
	<cfinclude template = "/system/header.cfm" />
	<cfinclude template = "navigation.cfm" />

	<div class="mid" id="midcontent"> 

<!-- CONTENT, BRO -->
<div class="column" id="column1">
	<cfquery name = "Staff" datasource = "#DSN#">
		SELECT *
		FROM users
		WHERE rank > 4
		ORDER BY rank DESC
	</cfquery>
	<div class="contentBox">
		<div class="boxHeader">Hotel Staff</div>
		<div class="boxContent">
			<cfoutput query="Staff">
				<div class="StaffBox">
					<img src="http://www.habbo.com/habbo-imaging/avatarimage?figure=#look#" alt="#username#" style="float:left" />
					<div class="OnlineStatus">
						<cfif online is 1>
							<div class="Online">Online</div>
						<cfelse>
							<div class="Offline">Offline</div>
						</cfif>
					</div>
					<div class="Usersname">#username#</div>
					<div class="Usersmotto">#motto#</div>
					<cfif rank is 7>
						<img src="/Public/Images/badges/ADM.gif" alt="Habboon Staff" />
					<cfelseif rank is 6>
						<img src="/Public/Images/badges/HBA.gif" alt="Habboon Moderator" />
					<cfelseif rank is 5>
						<img src="/Public/Images/badges/NWB.gif" alt="Trial Moderator" />
					</cfif>
				</div>
			</cfoutput>
		</div>
	</div>
</div>
		
<div class="column" id="column2">
	<div class="contentBox">
		<div class="boxHeader">We're Hiring!</div>
		<div class="boxContent">Habboon is a brand new hotel and our staff team is still pretty small, we're looking out for active users to hire as new moderators over the next few weeks. So keep active and get noticed for your chance at moderator!</div>
	</div>
</div>
		
<cfinclude template = "/system/sideads.cfm" />
<!-- /CONTENT, BRO -->

	</div> 

	<cfinclude template = "/system/footer.cfm" />
</div> 

</body> 
</html>