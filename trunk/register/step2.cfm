<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("../config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<cfset CurrentStyle = getProfileString(iniFile, "settings", "style")>
<!-- Read config.ini settings & apply them -->

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
	<title>Phoenix 3.0</title> 
	<cfoutput>
		<link type="text/css" rel="stylesheet" href="/Public/Styles/#CurrentStyle#/CSS/login.css" />
	</cfoutput> 
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head> 
 
<body> 

<cfif not isdefined('form.email') OR not isdefined('form.bdday') OR not isdefined('form.bdmonth') OR not isdefined('form.bdyear') OR not isdefined('form.password')>
	<cflocation url="index.cfm" addtoken="no" />
</cfif>

<div class="loginBox"> 
	<div class="top"> 
		<cfoutput><a href="./"><img src="/Public/Styles/#CurrentStyle#/Images/logo.png" /></a></cfoutput>
		<cfinclude template="/online.cfm" /> Users Online
	</div> 
	
	<div class="mid"> 
		<div class="registerstep2">
			<div class="box_header">Create Your Character</div> 
			Habbo Name:<br /> 
			<input type="text" id="habbo_name_field" /> 
			<input type="submit" value="Check" onmousedown="this.style.backgroundColor='#ddd'; doCheckHabboName();" onmouseup="this.style.backgroundColor='#eee';" onmouseover="this.style.backgroundColor='#eee';" onmouseout="this.style.backgroundColor='#fff';" /><br />
			<div class="errormsg display_none" id="habbo_name_message_box"> 
				<h3>Error message</h3> 
				Error text goes here oh no.
			</div>
			<br /> 
			
			<script type="text/javascript"> 
				function doUpdateImage( incoming ) {
					$('#figure').val(incoming.rel);
					document.getElementById('main_reg_img').src = 'http://www.habbo.com/habbo-imaging/avatarimage?figure=' + incoming.rel + '&size=b&direction=2';
					return false;
				}
				
				function enableField() {
					$('#username').val($('#habbo_name_field').val());
					document.getElementById('register-button').disabled=false;
				}
 
				function disableField() {
					$('#username').val('');
					document.getElementById('register-button').disabled=true;
				}
 
				function doCheckHabboName() {
					name = $("#habbo_name_field").val();
					
					if( name.length < 3 ) {
						$("#habbo_name_message_box").html("<h3>Your name is too short</h3>Please choose a longer name.");
						$("#habbo_name_message_box").removeClass().addClass("errormsg");
						disableField();
							
						return false;
					}
					
					$.get("namecheck.cfm", {ajaxAct: "check_habbo_name", habbo_name: name}, function(data) {
						if( $.trim(data) == "1" ) {
							$("#habbo_name_message_box").html("<h3>" + name + " is available</h3>That's fantastic news. Choose your Habbo look and then click register.");
							$("#habbo_name_message_box").removeClass().addClass("goodmsg");
							enableField();
						} else {
							$("#habbo_name_message_box").html("<h3>" + name + " is <u>not</u> available</h3>Please choose a different name.");
							$("#habbo_name_message_box").removeClass().addClass("errormsg");
							disableField();
						}
					});
				}
				
				$('#habbo_name_field').keypress(function(e){
					if(e.which == 13){
						doCheckHabboName();
					}
				});
				
				$('#habbo_name_field').blur(function(e){
					doCheckHabboName();
				});
				</script>
			
			
			<div id="avatar-field-container"> 
                <div class="field field-avatar"> 
                    <div id="selected-avatar"> 
                        <h3>Preview</h3>
                        <img id="main_reg_img" src="http://www.habbo.com/habbo-imaging/avatarimage?figure=hr-515-45.hd-600-8.ch-884-76.lg-696-76.sh-740-76.ea-1401-76.ca-1815-62.wa-2011&size=b&direction=4" ref="hr-515-45.hd-600-8.ch-884-76.lg-696-76.sh-740-76.ea-1401-76.ca-1815-62.wa-2011" width="64" height="110"/> 
                    </div> 
                    <div id="avatar-choices"> 
                        <h3>Girls</h3> 
						<cfquery name = "GrabFFigures" datasource = "#DSN#">
							SELECT *
							FROM cms_registration_figures
							WHERE gender = 'f'
							ORDER BY RAND()
							LIMIT 11
						</cfquery>
						<cfoutput query="GrabFFigures">
	                        <a class="female-avatar" onclick="doUpdateImage(this); return false;" rel="#figure#">
	                            <img src="http://www.habbo.com/habbo-imaging/avatarimage?figure=#figure#&direction=4&size=s" width="33" height="56"/> 
	                        </a> 
						</cfoutput>
                        <h3>Boys</h3> 
						<cfquery name = "GrabMFigures" datasource = "#DSN#">
							SELECT *
							FROM cms_registration_figures
							WHERE gender = 'm'
							ORDER BY RAND()
							LIMIT 11
						</cfquery>
						<cfoutput query="GrabMFigures">
	                        <a class="male-avatar" onclick="doUpdateImage(this); return false;" rel="#figure#">
	                            <img src="http://www.habbo.com/habbo-imaging/avatarimage?figure=#figure#&direction=4&size=s" width="33" height="56"/> 
	                        </a> 
						</cfoutput>
                    </div>
				</div>
			</div>
			<cfoutput>
				<form id="register_step_two" method="post" action="complete.cfm">
					<input type="hidden" name="email" id="email" value="#form.email#" />
					<input type="hidden" name="bdday" id="bdday" value="#form.bdday#" />
					<input type="hidden" name="bdmonth" id="bdmonth" value="#form.bdmonth#" />
					<input type="hidden" name="bdyear" id="bdyear" value="#form.bdyear#">
					<input type="hidden" name="username" id="username" value="" />
					<input type="hidden" name="figure" id="figure" value="hr-515-45.hd-600-8.ch-884-76.lg-696-76.sh-740-76.ea-1401-76.ca-1815-62.wa-2011" />
					<input type="hidden" name="password" id="password" value="#form.password#" />
					<input type="submit" value="Register" id="register-button" onmousedown="this.style.backgroundColor='##ddd';" onmouseup="this.style.backgroundColor='##eee';" onmouseover="this.style.backgroundColor='##eee';" onmouseout="this.style.backgroundColor='##fff';" disabled="disabled" />	
				</form>
			</cfoutput>
		</div>
	</div>
	
	<cfinclude template = "/system/footer.cfm" />
</div> 
 
</body> 
</html>