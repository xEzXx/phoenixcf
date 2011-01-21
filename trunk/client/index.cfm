<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- Read config.ini settings & apply them -->
<cfset iniFile = expandPath("/config.ini")>
<cfset DSN = getProfileString(iniFile, "coldfusion", "DSN")>
<!-- Read config.ini settings & apply them -->

<cfinclude template = "/system/functions/checkusersession.cfm" />
<cfinclude template = "/system/functions/loadclientsettings.cfm" />

<cfscript>
	function randString(type,ct){ var i=1; var randStr=""; var randNum=""; var 
	useList=""; var 
	alpha="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z"; 
	var secure="!,@,$,%,&amp;,*,-,_,=,+,?,~"; for(i=1;i LTE ct;i=i+1){ 
	randNum=RandRange(1,10); useList="0,1,2,3,4,5,6,7,8,9"; 
	randStr="#randStr##ListGetAt(useList,randNum)#"; } return randStr; }
</cfscript>

<cfset rand1 ="#randString('numeric',6)#" />
<cfset rand2 ="#randString('numeric',5)#" />
<cfset rand3 ="#randString('numeric',5)#" />
<cfset rand4 ="#randString('numeric',5)#" />
<cfset rand5 ="#randString('numeric',5)#" />
<cfset rand6 ="#randString('numeric',1)#" />
<cfset ticket ="ST-#rand1#-#rand2##rand3#-#rand4##rand5#-otaku-#rand6#">

<cfquery name="ssoticket" datasource="#DSN#">
	UPDATE users SET auth_ticket = '#ticket#' WHERE username = '#session.username#'
</cfquery>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" xmlns:og="http://opengraphprotocol.org/schema/" xmlns:fb="http://www.facebook.com/2008/fbml"> 
<head> 
	<meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
	<title>Habbo Hotel -  </title> 
 
<cfoutput>
	<script type="text/javascript"> 
		var andSoItBegins = (new Date()).getTime();
		var ad_keywords = "";
		document.habboLoggedIn = true;
		var habboName = "Sojobo";
		var habboReqPath = "#cms_url#";
		var habboStaticFilePath = "http://images.habbo.com/habboweb/60_cf3b27a092308ed2f4b382d9929147fc/4/web-gallery";
		var habboImagerUrl = "http://www.habbo.com/habbo-imaging/";
		var habboPartner = "";
		var habboDefaultClientPopupUrl = "#cms_url#/client";
		window.name = "ClientWndw";
		if (typeof HabboClient != "undefined") { HabboClient.windowName = "ClientWndw"; }
	</script> 
</cfoutput>

<link rel="alternate" type="application/rss+xml" title="Habbo Hotel - RSS" href="http://www.habbo.com/articles/rss.xml" /> 
<script src="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/static/js/libs2.js" type="text/javascript"></script>
<script src="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/static/js/visual.js" type="text/javascript"></script>
<script src="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/static/js/libs.js" type="text/javascript"></script>
<script src="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/static/js/common.js" type="text/javascript"></script>
<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/style.css" type="text/css" />
<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/buttons.css" type="text/css" />
<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/boxes.css" type="text/css" />
<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/tooltips.css" type="text/css" />
<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/changepassword.css" type="text/css" />

<noscript> 
    <meta http-equiv="refresh" content="0;url=/client/nojs" />
</noscript> 

<link rel="stylesheet" href="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/v2/styles/habboclient.css" type="text/css" />
<link rel="stylesheet" href="/Public/Styles/Default/CSS/client.css" type="text/css" />
<script src="http://images.habbo.com/habboweb/63_1dc60c6d6ea6e089c6893ab4e0541ee0/68/web-gallery/static/js/habboflashclient.js" type="text/javascript"></script>

<cfoutput>
<script type="text/javascript"> 
    FlashExternalInterface.loginLogEnabled = true;
    FlashExternalInterface.logLoginStep("web.view.start");
    
    if (top == self) {
        FlashHabboClient.cacheCheck();
    }
    var flashvars = {
            "client.allow.cross.domain" : "1", 
            "client.notify.cross.domain" : "1", 
            "connection.info.host" : "#client_ip#", 
            "connection.info.port" : "#client_port#", 
            "site.url" : "#cms_url#", 
            "url.prefix" : "#cms_url#", 
            "client.reload.url" : "#cms_url#/reauthenticate.cfm?page=/client", 
            "client.fatal.error.url" : "#cms_url#/client/disconnected.cfm?flash_client_error", 
            "client.connection.failed.url" : "#cms_url#/client/disconnected.cfm?client_connection_failed", 
            "external.variables.txt" : "#client_variables#", 
            "external.texts.txt" : "#client_texts#", 
            "use.sso.ticket" : "1", 
            "sso.ticket" : "#ticket#", 
            "processlog.enabled" : "1", 
            "account_id" : "1", 
            "client.starting" : "Please wait! Habboon is starting up.", 
            "flash.client.url" : "#cms_url#/client/r59/", 
            "user.hash" : "31385693ae558a03d28fc720be6b41cb1ccfec02", 
            "has.identity" : "0", 
            "flash.client.origin" : "popup",
            "token" : "#ticket#"
    };
    var params = {
        "base" : "#cms_url#/client/r59/",
        "allowScriptAccess" : "always",
        "menu" : "false"                
    };
    
    if (!(HabbletLoader.needsFlashKbWorkaround())) {
    	params["wmode"] = "opaque";
    }
    
    var clientUrl = "#cms_url#/client/r59/Habbo10.swf";
    try {
        if (swfobject.getFlashPlayerVersion().major <= 9) { 
            clientUrl = "#cms_url#/client/r59/Habbo.swf"; 
        }
    } catch(e) {}

    swfobject.embedSWF(clientUrl, "flash-container", "100%", "100%", "10.0.0", "http://images.habbo.com/habboweb/61_c0f99b7b02ed27ad5d4d5661fe02784f/8/web-gallery/flash/expressInstall.swf", flashvars, params);
 
    window.onbeforeunload = unloading;
    function unloading() {
        var clientObject;
        if (navigator.appName.indexOf("Microsoft") != -1) {
            clientObject = window["flash-container"];
        } else {
            clientObject = document["flash-container"];
        }
        try {
            clientObject.unloading();
        } catch (e) {}
    }
</script>
</cfoutput>

</head> 
 
<body id="client" class="flashclient"> 
<div id="BottomBar">
	<div id="player"><a href="http://www.macromedia.com/go/getflashplayer">Radio Name</a>
	<script type="text/javascript" src="swfobject.js"></script>
	<script type="text/javascript">
	var s1 = new SWFObject("/system/radio/player.swf","ply","328","20","9","#FFFFFF");
	s1.addParam("allowfullscreen","true");
	s1.addParam("allowscriptaccess","always");
	s1.addParam("flashvars","file=http://69.162.84.26:1337/;stream.nsv&type=sound&volume=50&duration=-1&autostart=true");
	s1.write("player");</script>
	</div> 
</div> 

<div id="overlay"></div> 
<img src="http://images.habbo.com/habboweb/61_c0f99b7b02ed27ad5d4d5661fe02784f/8/web-gallery/v2/images/page_loader.gif" style="position:absolute; margin: -1500px;" /> 
 
<div id="overlay"></div> 
<div id="client-ui" > 
    <div id="flash-wrapper"> 
    <div id="flash-container"> 
        <div id="content" style="width: 400px; margin: 20px auto 0 auto; display: none"> 
			<div class="cbb clearfix"> 
			    <h2 class="title">Please install Adobe Flash Player.</h2> 
			    <div class="box-content"> 
			            <p>You can install and download Adobe Flash Player here: <a href="http://get.adobe.com/flashplayer/">
						Install flash player</a>. More instructions for installation can be 
						found here: <a href="http://www.adobe.com/products/flashplayer/productinfo/instructions/">
						More information</a></p> 
			            <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://images.habbo.com/habboweb/61_c0f99b7b02ed27ad5d4d5661fe02784f/8/web-gallery/v2/images/client/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p> 
			    </div> 
			</div> 
        </div> 
        <script type="text/javascript"> 
            $('content').show();
        </script> 
        <noscript> 
            <div style="width: 400px; margin: 20px auto 0 auto; text-align: center">
                <p>If you are not automatically redirected, please <a href="/client/nojs">click here</a></p>
            </div>
        </noscript> 
    </div> 
    </div> 
	<div id="content" class="client-content"></div>
</div> 

</body> 
</html>