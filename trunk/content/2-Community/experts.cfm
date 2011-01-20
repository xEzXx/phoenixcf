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
	<cfquery name = "eXperts" datasource = "#DSN#">
		SELECT *
		FROM user_achievements
		WHERE achievement_id = 32
		ORDER BY user_id ASC
	</cfquery>
	<div class="contentBox">
		<div class="boxHeader">Hotel eXperts</div>
		<div class="boxContent">
			<cfoutput query="eXperts">
				<cfquery name = "ThisUser" datasource = "#DSN#">
					SELECT *
					FROM users
					WHERE id = '#user_id#'
					LIMIT 1
				</cfquery>
				<div class="StaffBox">
					<img src="http://www.habbo.com/habbo-imaging/avatarimage?figure=#ThisUser.look#" alt="#ThisUser.username#" style="float:left" />
					<div class="OnlineStatus">
						<cfif ThisUser.online is 1>
							<div class="Online">Online</div>
						<cfelse>
							<div class="Offline">Offline</div>
						</cfif>
					</div>
					<div class="Usersname">#ThisUser.username#</div>
					<div class="Usersmotto">#ThisUser.motto#</div>
					<img src="/Public/Images/badges/XXX.gif" alt="Habboon eXpert" />
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