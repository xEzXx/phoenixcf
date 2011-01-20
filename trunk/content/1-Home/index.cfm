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
	<script language="javascript"> 
	(function($){
		$(document).ready(function() {
			$('.Usersmotto').click(function()  {
				$('.Usersmotto').css("display", "none")
				$('.UserMotto').css("display", "block")
				$('.UserMotto').focus()
				return;
			});
	
			$('.UserMotto').blur(function()  {
				$('.UserMotto').css("display", "none")
				$.ajax({
					url: "/system/functions/updatemotto.cfm?motto=" + $('.UserMotto').val(),
					async: false
				})
				$('.Usersmotto').html($('.UserMotto').val())
				$('.Usersmotto').css("display", "block")
				return;
			});
		});
	})(jQuery);
	</script>
</head> 
 
<body> 
 
<div class="mainBox"> 
	<cfinclude template = "/system/header.cfm" />
	<cfinclude template = "navigation.cfm" />

	<div class="mid" id="midcontent"> 

<!-- CONTENT, BRO -->
<div class="column" id="column1">

	<cfoutput>
		<cfquery name = "Subscriptions" datasource = "#DSN#">
			SELECT *
			FROM user_subscriptions
			WHERE user_id = #user.id#
			LIMIT 1
		</cfquery>
		<div class="myOverview">
			<div id="enter-hotel">
				<div class="open">
					<a href="/client/?forwardid=2&roomid=1" target="ClientWndw" onclick="window.open('#cms_url#/client','ClientWndw','width=980,height=597');return false;">Enter Hotel<i></i></a><b></b>
				</div>
			</div>
			<div id="avatar-plate" onclick="location.href='/characters.cfm'"><img src="http://www.habbo.com/habbo-imaging/avatarimage?figure=#user.look#" alt="#user.username#" style="margin:0 0 0 15px;" /></div>
		</div>
		<div class="avatarinfo">
			<div class="MottoContainer">
				<div class="Usersname">#user.username#:</div>
				<div class="Usersmotto">#user.motto#</div>
				<input class="UserMotto" type="text" value="#User.motto#" style="display:none" />
			</div>
			<div class="link-bar">
				<div class="credits">#user.credits# Credits</div>
				<div class="activitypoints">#user.activity_points# Pixels</div>
				<cfif Subscriptions.recordcount>
					<cfset TimeExpires = #dateAdd("s", Subscriptions.timestamp_expire, "01/01/1970")#>
					<cfif Subscriptions.subscription_id is "habbo_club">
						<div class="club">#DateDiff("d", Now(), TimeExpires)# days of HC left</div>
					<cfelseif Subscriptions.subscription_id is "vip_club">
						<div class="club">#DateDiff("d", Now(), TimeExpires)# days of VIP left</div>
					</cfif>
				</cfif>
			</div>
		</div>
	</cfoutput>
	<div class="avatarextrainfo">
		<cfquery name = "Friendships" datasource = "#DSN#">
			SELECT *
			FROM messenger_friendships
			WHERE user_one_id = #user.id#
		</cfquery>
		<cfset i = 0>
		<cfoutput query="Friendships">
			<cfquery name = "Friend" datasource = "#DSN#">
				SELECT username
				FROM users
				WHERE id = '#user_two_id#' AND online = '1'
				LIMIT 1
			</cfquery>
			<cfif Friend.recordcount>
				<cfset i += 1>
				<cfif i is 1><div class="content" id="feed-friends">
					Friends online; 
				</cfif>
				#Friend.username#, 
			</cfif>
		</cfoutput>
		<cfif i gt 0></div></cfif>
		<div class="smallcontent" id="feed-lastlogin">
			<cfoutput>Last signed in: #DateFormat(dateAdd("s", user.last_online, "01/01/1970"))# #TimeFormat(dateAdd("s", user.last_online, "01/01/1970"))#</cfoutput>
		</div>
	</div>

	
	<cfif Campaigns.recordcount>
		<cfset colour ="odd">
		<div class="contentBox">
			<div class="boxHeader">Campaigns</div>
			<cfoutput query="Campaigns">
				<div class="campaigncontainer" id="#colour#">
					<div class="image" style="background: url(#campaignimg#) no-repeat;"></div>
					<div class="campaign">
						<div class="title"><a href="/content/2-Community/articles.cfm?story=#id#">#title#</a></div>
						<div class="story">#shortstory#</div>
						<div class="published">Posted: #DateFormat(dateAdd("s", published, "01/01/1970"))#</div>
						<div class="readmore"><a href="/content/2-Community/articles.cfm?story=#id#">Read More &raquo;</a></div>
					</div>
				</div>
				<cfif colour is "odd"><cfset colour="even"><cfelse><cfset colour="odd"></cfif>
			</cfoutput>
		</div>
	</cfif>
</div>

<div class="column" id="column2">
	<cfif News.recordcount>
		<div class="newsHeader">
			<cfset display ="block">
			<cfoutput query="News">
				<div class="HeadlineStory" id="story#id#" style="background: url(#image#) no-repeat; display:#display#">
					<p class="Mainheadline"><a href="/content/2-Community/articles.cfm?story=#id#">#title#</a></p>
					<p class="Mainstory">#shortstory#</p>
				</div>
				<cfif display is "block"><cfset display ="none"></cfif>
			</cfoutput>
		</div>
		<cfset colour ="odd">
		<cfoutput query="News">
			<div class="storybox" id="#colour#" ref="#id#">
				<p class="headline"><a href="/content/2-Community/articles.cfm?story=#id#">#title#</a></p>
				<p class="date">#DateFormat(dateAdd("s", published, "01/01/1970"))#</p>
			</div>
			<cfif colour is "odd"><cfset colour="even"><cfelse><cfset colour="odd"></cfif>
		</cfoutput>
		<div class="storyboxEnd">
			<div class="readmore"><a href="/content/2-Community/articles.cfm">Read More &raquo;</a></div>
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