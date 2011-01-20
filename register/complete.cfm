<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("../config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<cfset CurrentStyle = getProfileString(iniFile, "settings", "style")>
<!-- Read config.ini settings & apply them -->

<cfset password = #hash(form.password)#>
<cfif not isdefined('session.account')>
	<cfquery name = "MailCheck" datasource = "#DSN#">
		SELECT mail
		FROM users
		WHERE mail = '#form.email#'
		LIMIT 1
	</cfquery>
	<cfif MailCheck.recordcount>
		<cflocation url="index.cfm?error=email" Addtoken="No">
	</cfif>
<cfelse>
	<cfquery name = "AccountDetails" datasource = "#DSN#">
		SELECT *
		FROM users
		WHERE mail = '#session.account#'
		LIMIT 1
	</cfquery>
	<cfset password = #AccountDetails.password#>
	<cfset form.email = #session.account#>
</cfif>

<cfquery name = "NameCheck" datasource = "#DSN#">
	SELECT username
	FROM users
	WHERE username = '#form.username#'
	LIMIT 1
</cfquery>
<cfif NameCheck.recordcount>
	<cflocation url="index.cfm?error=username" Addtoken="No">
</cfif>

<cfset regname = REMatch("^[-a-zA-Z0-9._:,]+$", form.username)>
<cfif not ArrayLen(regname)>
	<cflocation url="index.cfm?error=username" Addtoken="No">
</cfif>

<cfquery name = "InsertUser" datasource = "#DSN#">
	INSERT INTO users (username, password, mail, look, motto, account_created, last_online, ip_last, ip_reg, auth_ticket)
	VALUES ('#form.username#', '#password#', '#form.email#', '#form.figure#', 'Habboon', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), '#CGI.REMOTE_ADDR#', '#CGI.REMOTE_ADDR#', '')
</cfquery>
<cfquery name = "NewAccount" datasource = "#DSN#">
	SELECT id
	FROM users
	WHERE username = '#form.username#'
	LIMIT 1
</cfquery>
<cfquery name = "UsersStats" datasource = "#DSN#">
	INSERT INTO user_stats (id, RoomVisits, OnlineTime, Respect, RespectGiven, GiftsGiven, GiftsReceived, DailyRespectPoints, DailyPetRespectPoints)
	VALUES (#NewAccount.id#, 0, 0, 0, 0, 0, 0, 3, 3)
</cfquery>

<cfset session.account = "#form.email#">
<cflocation url="/characters.cfm" Addtoken="No">

bdday: #form.bdday#
bdmonth: #form.bdmonth#
bdyear: #form.bdyear#
password: #form.password#
