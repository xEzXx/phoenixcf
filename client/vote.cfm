<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("/config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<cfset CurrentStyle = getProfileString(iniFile, "settings", "style")>
<!-- Read config.ini settings & apply them -->

<cfinclude template = "/system/functions/checkusersession.cfm" />
<cfinclude template = "/system/functions/loadsettings.cfm" />
<cfinclude template = "/system/functions/loadclientsettings.cfm" />

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<cfinclude template = "/system/functions/hdr_generic.cfm" />
	<cfinclude template = "/system/functions/hdr_user.cfm" />
	<cfinclude template = "/system/functions/hdr_news.cfm" />
</head> 
 
<body class="votepage">

	<div class="contentBox">
		<div class="boxHeader">Vote for us</div>
		Vote for us each day for your chance to win bonus credits!<br /><br />
		<a href="http://retrotopsites.com/functions/in.cfm?user=#rts_uname#" target="_blank" onclick="location.href='index.cfm'"><img src="http://retrotopsites.com/Images/vote.gif" alt="Vote For Us!" /></a>
	</div>

</body>
</html>