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
	<cfinclude template = "/system/functions/hdr_news.cfm" />
</head> 
 
<body> 
 
<div class="mainBox"> 
	<cfinclude template = "/system/header.cfm" />
	<cfinclude template = "navigation.cfm" />

	<div class="mid" id="midcontent"> 

<!-- CONTENT, BRO -->
<div class="column" id="column1">
	<div class="contentBox">
		<div class="boxHeader">Welcome to Habboon!</div>
		<div class="boxContent">Community overview?</div>
	</div>

	<div class="contentBox">
		<div class="boxHeader">Server Stats</div>
		<div class="boxContent" align="center">
			<cfquery name="statCount" datasource="#DSN#">
				SELECT MAX(ID) FROM system_stats
			</cfquery>
			<cfquery name="stats" datasource="#DSN#">
				SELECT *
				FROM system_stats
				WHERE ID > ((SELECT MAX(ID) FROM system_stats) - 72)
				ORDER BY id asc
			</cfquery>
			
			<cfchart format="png" 
				xaxistitle="Date" 
				yaxistitle="Count"
				showLegend="yes"
				chartHeight="300"
				chartWidth="410"
				showMarkers="no"> 
			
				<cfchartseries type="line" 
					query="stats" 
					itemcolumn="date" 
					valuecolumn="users"
					seriesLabel="Users Online"
					seriesColor="red">
				<cfchartseries type="line" 
					query="stats" 
					itemcolumn="date" 
					valuecolumn="rooms"
					seriesLabel="Active Rooms"
					seriesColor="blue">
				</cfchartseries>
			</cfchart> 
		</div>
	</div>
</div>
		
<div class="column" id="column2">
	<cfif News.recordcount>
		<div class="newsHeader">
			<cfset display ="block">
			<cfoutput query="News">
				<div class="HeadlineStory" id="story#id#" style="background: url(#image#) no-repeat; display:#display#">
					<p class="Mainheadline"><a href="articles.cfm?story=#id#">#title#</a></p>
					<p class="Mainstory">#shortstory#</p>
				</div>
				<cfif display is "block"><cfset display ="none"></cfif>
			</cfoutput>
		</div>
		<cfset colour ="odd">
		<cfoutput query="News">
			<div class="storybox" id="#colour#" ref="#id#">
				<p class="headline"><a href="articles.cfm?story=#id#">#title#</a></p>
				<p class="date">#DateFormat(dateAdd("s", published, "01/01/1970"))#</p>
			</div>
			<cfif colour is "odd"><cfset colour="even"><cfelse><cfset colour="odd"></cfif>
		</cfoutput>
		<div class="storyboxEnd">
			<div class="readmore"><a href="articles.cfm">Read More &raquo;</a></div>
		</div>
	</cfif>
</div>
		
<cfinclude template = "/system/sideads.cfm" />
<!-- /CONTENT, BRO -->

	</div> 

	<cfinclude template = "/system/footer.cfm" />
</div> 

</body> 
</html>