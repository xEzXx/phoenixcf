<div class="top"> 
	<cfoutput><a href="./"><img src="/Public/Styles/#CurrentStyle#/Images/logo.png" /></a></cfoutput>
	<div style="float:right">
		<div class="usersBox" style="width:140px;">
			<div class="OnlineCount"><cfinclude template="/online.cfm" /> Users Online</div>
			<br/><a href="/system/functions/logout.cfm">Sign Out</a>
		</div>
		<div id="enter-hotel">
			<div class="open">
				<cfoutput><a href="/client/" target="ClientWndw" onclick="window.open('#cms_url#/client','ClientWndw','width=980,height=597');return false;">Enter Hotel<i></i></a></cfoutput>
				<b></b>
			</div>
		</div>
	</div>
	
	<cfset theroot = expandPath("/content/")>
	<cfdirectory action="LIST" directory="#theroot#" name="dirlist" filter="*-*">
	<cfoutput>
		<div class="navBar">
			<cfloop query="dirlist">
				<div class="navButton" ref="#dirlist.name#" onClick="location.href='/content/#dirlist.name#'"><a href="/content/#dirlist.name#">#listgetat(dirlist.name, 2, "-")#</a></div>
			</cfloop>
		</div>
	</cfoutput>
</div> 
