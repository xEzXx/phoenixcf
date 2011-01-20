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
	<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery.validate/1.7/jquery.validate.pack.js"></script>
</head> 

<script type="text/javascript">
	function doLinkForumAcc() {
		name = $("#forumname").val();
		uid = $("#uid").val();
		$.get("/system/functions/linkforum.cfm", {ajaxAct: "check_habbo_name", name: name, uid: uid}, function(data) {
			if( $.trim(data) == "success" ) {
				$("#habbo_name_message_box").html("<h3>Success!</h3> You have successfully linked your account to an Otaku-Studios.com account");
				$("#habbo_name_message_box").removeClass().addClass("goodmsg");
			} else if ( $.trim(data) == "wrong" ) {
				$("#habbo_name_message_box").html("<h3>Whoops - something went wrong!</h3> Double check that you have placed your name into your profile on Otaku-Studios.com");
				$("#habbo_name_message_box").removeClass().addClass("errormsg");
			} else {
				$("#habbo_name_message_box").html("<h3>Whoops - something went wrong!</h3> An error occurred, try again later");
				$("#habbo_name_message_box").removeClass().addClass("errormsg");
			}
		});
	}

	function doCheckMail() {
		name = $("#email").val();
		$.get("/register/mailcheck.cfm", {ajaxAct: "check_habbo_name", mail: name}, function(data) {
			if( $.trim(data) == "0" ) {
				$("#habbo_name_message_box").html("<h3>Our records indicate that this email is already in use.</h3> You cannot use an email that is in use by another player.");
				$("#habbo_name_message_box").removeClass().addClass("errormsg");
				MailisFree = 0;
			} else {
				MailisFree = 1;
			}
		});
	}

$().ready(function() {
	$('#email').keypress(function(e){
		if(e.which == 13){
			doCheckMail();
		}
	});

	$('#email').blur(function(e){
		doCheckMail();
	});

	$("#UserEmail").validate({
		submitHandler: function(form) {
			doCheckMail();
			if (MailisFree === 1) {
				form.submit();
			}
		},
		rules: {
			email: {
				required: true,
				email: true
			}
		},
		messages: {
			email: "You must enter a valid email."
		}
	});	
});

MailisFree = 0;

</script>

<cfif not isdefined('url.page')>
	<cfset url.page="general">
</cfif>

<body id="news_body"> 
 
<div class="mainBox"> 
	<cfinclude template = "/system/header.cfm" />
	<cfinclude template = "navigation.cfm" />

	<div class="mid" id="midcontent"> 

<!-- CONTENT, BRO -->
<div class="column" id="column1">
	<div class="contentBox">
		<div class="boxHeader">Account Settings</div>
		<div class="boxContent">
			<a href="?page=general" <cfif url.page is "general">class="selected"</cfif>>General Settings</a><br/>
			<a href="?page=forum" <cfif url.page is "forum">class="selected"</cfif>>Forum Settings</a><br/>
			<a href="?page=email" <cfif url.page is "email">class="selected"</cfif>>Email settings</a><br/>
			<a href="?page=password" <cfif url.page is "password">class="selected"</cfif>>Password settings</a>
		</div>
	</div>
</div>
		
<div class="column" id="column2">
	<div class="contentBox">
		<cfif url.page is "general">
			<div class="boxHeader">General Settings</div>
			<div class="boxContent">
				<cfif isdefined('url.success') AND url.success is "false">
					<div class="errormsg" id="habbo_name_message_box"> 
						<h3>An error occurred</h3> 
					</div>
				<cfelseif isdefined('url.success') AND url.success is "true">
					<div class="goodmsg" id="habbo_name_message_box"> 
						<h3>Your settings have successfully been updated</h3> 
					</div>
				</cfif>
				<form name="UserSettings" action="/system/functions/updateusersettings.cfm" method="post">
					<p><strong>Friend Requests</strong><br/>
					<input type="checkbox" name="friendreqs" id="friendreqs" <cfif user.block_newfriends is 0>checked=checked</cfif> />
					<label for="friendreqs">Allow other users to send you friend requests</label></p>
					<p><strong>Online Status</strong><br/>
					<input type="checkbox" name="online" id="online" <cfif user.hide_online is 0>checked=checked</cfif> />
					<label for="online">Allow your friends to see when you are online</label></p>
					<p><strong>Follow Me Settings</strong><br/>
					<input type="checkbox" name="stalking" id="stalking" <cfif user.hide_inroom is 0>checked=checked</cfif> />
					<label for="stalking">Allow your friends to follow you via the console</label></p>
					<div class="Submitbtn right">
						<button type="submit" class="positive" name="submitcomment">Submit</button>
		   			</div>
	   			</form>
			</div>
		<cfelseif url.page is "forum">
			<div class="boxHeader">Forum Settings</div>
			<div class="boxContent">
				<div class="errormsg display_none" id="habbo_name_message_box"> 
					<h3>An error occurred</h3> 
					Your account could not be verified by Otaku-Studios.com
				</div>
				<form id="ForumForm" name="ForumForm" onSubmit="doLinkForumAcc(); return false;">
					<label for="forumname">Otaku Studios Account</label><br/>
					<cfoutput>
						<input type="text" name="forumname" id="forumname" value="#user.real_name#" /><br/>
						<input type="hidden" name="uid" id="uid" value="#user.id#" />
					</cfoutput>
					<div class="Submitbtn right">
						<a onclick="doLinkForumAcc();" class="positive">Submit</a>
		   			</div>
	   			</form>
			</div>
		<cfelseif url.page is "email">
			<div class="boxHeader">Email Settings</div>
			<div class="boxContent">
				<cfif isdefined('url.success') AND url.success is "false">
					<div class="errormsg" id="habbo_name_message_box"> 
						<h3>An error occurred</h3> 
					</div>
				<cfelseif isdefined('url.success') AND url.success is "true">
					<div class="goodmsg" id="habbo_name_message_box"> 
						<h3>Your email has successfully been updated</h3> 
					</div>
				</cfif>
				<cfif not user.mail_verified is "true">
					<div class="errormsg" id="habbo_name_message_box"> 
						<h3>Your email has not been verified yet</h3> 
					</div>
				</cfif>
				<cfif isdefined('url.sent') AND url.sent is "true">
					<div class="goodmsg" id="habbo_name_message_box"> 
						<h3>We've sent you an email</h3> 
						Check your inbox to validate your email address
					</div>
				</cfif>
				<cfif isdefined('url.validated') AND url.validated is "true">
					<div class="goodmsg" id="habbo_name_message_box"> 
						<h3>Your email address has been verified</h3> 
					</div>
				</cfif>
				<form id="UserEmail" name="UserEmail" action="/system/functions/updatemail.cfm" method="post">
					<label for="email">Email Address</label><br/>
					<cfoutput><input type="text" name="email" id="email" value="#user.mail#" /><br/></cfoutput>
					<div class="Submitbtn right">
						<cfif not user.mail_verified is "true"><a href="/system/functions/send_validateemail.cfm" class="regular">Re-send Verification Email</a></cfif>
					    <button type="submit" class="positive" name="submitcomment">Submit</button>
		   			</div>
	   			</form>
			</div>
		<cfelseif url.page is "password">
			<div class="boxHeader">Password Settings</div>
			<div class="boxContent">
				<cfif isdefined('url.success') AND url.success is "false">
					<div class="errormsg" id="habbo_name_message_box"> 
						<h3>An error occurred</h3> 
					</div>
				<cfelseif isdefined('url.success') AND url.success is "true">
					<div class="goodmsg" id="habbo_name_message_box"> 
						<h3>Your password has successfully been updated</h3> 
					</div>
				</cfif>
				<form name="UserPassword" action="/system/functions/updatepassword.cfm" method="post">
					<label for="curpassword">Current Password</label><br/>
					<input type="password" name="curpassword" id="curpassword" /><br/>
					<label for="newpassword">New Password (must be at least 6 letters long)</label><br/>
					<input type="password" name="newpassword" id="newpassword" /><br/>
					<label for="conpassword">Confirm New Password</label><br/>
					<input type="password" name="conpassword" id="conpassword" /><br/>
					<div class="Submitbtn right">
						<button type="submit" class="positive" name="submitcomment">Submit</button>
		   			</div>
	   			</form>
			</div>
		</cfif>
	</div>
</div>
		
<cfinclude template = "/system/sideads.cfm" />
<!-- /CONTENT, BRO -->

	</div> 

	<cfinclude template = "/system/footer.cfm" />
</div> 

</body> 
</html>