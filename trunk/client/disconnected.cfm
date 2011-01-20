<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("/config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<cfset CurrentStyle = getProfileString(iniFile, "settings", "style")>
<!-- Read config.ini settings & apply them -->

<html xmlns="http://www.w3.org/1999/xhtml"> 

<cfinclude template = "/system/functions/loadsettings.cfm" />
<head> 
	<cfinclude template = "/system/functions/hdr_generic.cfm" />
</head>
<body style="text-align:center">
		<table style="padding:50px 50px 50px 50px;">
			<tr>
				<td width="30%"></td>
				<td style="width:64px; height:64px; background-image:url(/Public/Styles/Default/Images/icons/warning_64.png); background-repeat:no-repeat"></td>
				<td style="width:400px">
					<strong>A problem occurred, sorry!</strong><br/>
					Please try reloading the hotel, if the problem continues wait a few minutes before trying again. If you are unable to get onto the hotel for a long peroid of time please report the issue on our forums.
				</td>
				<td width="30%"></td>
			</tr>
		</table>
	<cfinclude template = "/system/footer.cfm" />
</body>