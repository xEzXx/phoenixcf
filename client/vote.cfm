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

	<script type="text/javascript"> 
		var javascript_countdown = function () {
			var time_left = 10; //number of seconds for countdown
			var output_element_id = 'jstimer';
			var keep_counting = 1;
		 
			function countdown() {
				if(time_left < 2) {
					keep_counting = 0;
				}
		 
				time_left = time_left - 1;
			}
		 
			function add_leading_zero(n) {
				if(n.toString().length < 2) {
					return '0' + n;
				} else {
					return n;
				}
			}
		 
			function format_output() {
				var seconds;
				seconds = time_left % 60;
		 
				seconds = add_leading_zero( seconds );
		 
				return seconds;
			}
		 
			function show_time_left() {
				document.getElementById(output_element_id).innerHTML = format_output();//time_left;
			}
		 
			function no_time_left() {
				location.href='index.cfm';
				//document.getElementById(output_element_id).innerHTML = no_time_left_message;
			}
		 
			return {
				count: function () {
					countdown();
					show_time_left();
				},
				timer: function () {
					javascript_countdown.count();
		 
					if(keep_counting) {
						setTimeout("javascript_countdown.timer();", 1000);
					} else {
						no_time_left();
					}
				},
				init: function (t, element_id) {
					time_left = t;
					output_element_id = element_id;
					javascript_countdown.timer();
				}
			};
		}();
	
	function CastVote() {
		javascript_countdown.init(5, 'jstimer');
		$('.VoteIcon').fadeOut('slow');
		$('.CountDown').fadeIn('slow');
		//location.href='index.cfm';
	}
	</script> 
</head> 
 
<body class="votepage">

	<div class="contentBox">
		<div class="boxHeader">Vote for us</div>
		Vote for us each day for your chance to win bonus credits!<br /><br />
		<div class="VoteIcon">
			<cfoutput><a href="http://retrotopsites.com/functions/in.cfm?user=#rts_uname#" target="_blank" onclick="location.href='index.cfm'"><img src="http://retrotopsites.com/Images/vote.gif" alt="Vote For Us!" /></a></cfoutput>
		</div>
		<div class="CountDown" style="display:none;">
			Redirecting in <div id="jstimer" style="display:inline; font-size:150%">5</div> seconds..
		</div>
	</div>

</body>
</html>