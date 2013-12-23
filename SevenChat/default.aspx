<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="SevenChat._default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="css/style.css" media="screen" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
        <div class="welcome">
            Welcome to SevenChat - Geeks talk here.
        </div>
        <div class="transparentbackground">
            &nbsp;
        </div>
        <div class="content">
            <div class="currentusers">
                Rychird
            </div>
            <div class="loginbox">
                <label>E-mail Address</label><br /><br />
                <asp:TextBox ID="EmailAddress" runat="server" TextMode="Email" Width="250px" Height="20px"></asp:TextBox><br /><br />
                <label>Password</label><br /><br />
                <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="250px" Height="20px"></asp:TextBox><br /><br />
                <asp:Button ID="SubmitLogin" runat="server" OnClick="SubmitLogin_Click" Text="Login" CssClass="button" /><br /><br />
                Not a member yet?  <a href="register.aspx">Register</a>
            </div>
        </div>
    </div>

<!--
<title>Greyfaction.com Chat Room Login</title>
<style type="text/css" media="all">
@import "skins/generic.css";
</style>

<?php

if ($_REQUEST["blocked"] == 'yes'){
	$blockedid = "blocked";
}else{
	$blockedid = "notblocked";
}
	// GET THE USERNAME FROM COOKIE IF IT EXISTS
   if ($_COOKIE[username] == ''){
    $username='';
   }else{
    $username=$_COOKIE[username];
   }
   //echo ($username);
   // GET THE FONT FROM COOKIE IF IT EXISTS
   if ($_COOKIE[userfont] == ''){
    $userfont='';
   }else{
    $userfont=$_COOKIE[userfont];
   }

   // GET THE COLOR FROM COOKIE IF IT EXISTS
   if ($_COOKIE[usercolor] == ''){
    $usercolor='';
   }else{
    $usercolor=$_COOKIE[usercolor];
   }

    // GET THE ICON FROM COOKIE IF IT EXISTS
   if ($_COOKIE[usericon] == ''){
    $usericon='images/characters/humanmale.gif';
   }else{
    $usericon=$_COOKIE[usericon];
   }
   
// CLEAR OUT OLD USERS
$sql = "SELECT `user_name`,`user_icon`, NOW( )  - `last_action` 'delay'  FROM  `chat_user` ORDER BY `user_name`";
$result = mysql_query( $sql )
	or die ( 'Unable to query users. <BR><BR>' . $sql );
$num = mysql_numrows( $result );
if( $num != 0 )
{
	for ($i=0; $i<=$num-1;$i++)
	{
		if(mysql_result($result,$i,2) >= 600)
		{// USER IS NOT REFRESHING THEREFORE ASSUMPTION IS DISCONNECTED
			if($deadUsers == "")
			{
				$deadUsers = "'" . mysql_result($result,$i,0) . "'" ;
				$deadUsersShow = mysql_result($result,$i,0);
			}
			else
			{
				$deadUsers = $deadUsers . ", '" . mysql_result($result,$i,0). "'";
				$deadUsersShow = $deadUsersShow . ",  " . mysql_result($result,$i,0);
			}
		}
	}
}

if ($deadUsers != "")
{
$sql = "INSERT INTO `chat_log`(`user_name`,`chat_text`,`chat_private_to`) Values
	('system', '$deadUsersShow - fallen to the lag monster', '')";
$result = mysql_query( $sql )
	or die ( 'Unable to insert the chat text users. <BR><BR>' . $sql );
$sql = "DELETE FROM `chat_user` where `user_name` in ($deadUsers)";
$result = mysql_query( $sql )
	or die ( 'Unable to remove the chat users. <BR><BR>' . $sql );
}


// CLEAN UP ROOMS
$deadRooms = "";
$sql = "SELECT distinct `chat_room`.`chat_room_name`  FROM `chat_room`, `chat_user`  WHERE  `chat_room`.`chat_room_name` = `chat_user`.`chat_room_name`";
$result = mysql_query( $sql )
	or die ( 'Unable to query rooms. <BR><BR>' . $sql );
$num = mysql_numrows( $result );
if( $num != 0 )
{
	for ($i=0; $i<=$num-1;$i++)
	{// USER IS NOT REFRESHING THEREFORE ASSUMPTION IS DISCONNECTED
		if ($deadRooms == "")
		{
			$deadRooms = "'" . mysql_result($result,$i,0) . "'" ;
		}
		else
		{
			$deadRooms = $deadRooms . ", '" . mysql_result($result,$i,0). "'";
		}
	}	
}
if ($deadRooms != "")
{
	$sql = "DELETE FROM `chat_room` where `chat_room_name` NOT IN ($deadRooms)";
}
else
{
	$sql = "DELETE FROM `chat_room`";
}
$result = mysql_query( $sql )
	or die ( 'Unable to remove the old rooms. <BR><BR>' . $sql );

?>
<SCRIPT language="javascript" src="colorpick.js"></SCRIPT>
<script language="javascript" type="text/javascript">
function roomClick(roomName){
	  var messageVar = document.getElementById("chatRoom");
	  messageVar.value = '';
	  messageVar.value = roomName;
}

var cp = new ColorPicker(); // DIV style

</script>
</head>
<body>
<form action="validate.php">
<div id="wrapper">
<p class="title">Greyfaction.com Chat Room</p>
	<div id="roomuserlist">
	<b>Currently Active Rooms:</b>
	<?php
	// LIST ROOMS AND USERS
	$sql = "SELECT `chat_room_name` FROM  `chat_room` ORDER BY `chat_room_id`";
	$resultRoom = mysql_query( $sql )
			  or die ( 'Unable to query room. <BR/><BR/>' . $sql );
	
	$sql = "SELECT `user_name`,`user_icon`,`user_font`,  NOW( )  - `last_action` 'delay', `chat_room_name` FROM  `chat_user` ORDER BY `user_name`";
	$resultUsers = mysql_query( $sql )
		or die ( 'Unable to query users. <BR/><BR/>' . $sql );
			  
	$numRoom = mysql_numrows($resultRoom);
	if($numRoom != 0)
	{
		for($r=0; $r <= $numRoom-1; $r++)
		{
			echo("<p><a href=\"javascript:roomClick('".mysql_result($resultRoom,$r,0)."')\">".mysql_result($resultRoom,$r,0)."</a></p>");
			$num = mysql_numrows($resultUsers);
			if($num !=0)
			{
				for($i=0; $i <= $num-1; $i++)
				{
					if(mysql_result($resultUsers,$i,4) == mysql_result($resultRoom,$r,0))
					{
						echo ("<p class=\"userlist\"><img src=\"" . mysql_result($resultUsers,$i,1) . "\" width='24' height='24'/> ".mysql_result($resultUsers,$i,0)."</p>");
					}
				}
			}
		}
	}
	else
		echo("<br/>Nobody.  Take the initiative!");
	?>
	<p><input type="submit" id="btnSubmit" value="Enter Room" /></p>
	</div>
	<div id="logindetails">
	<p>
		<label for="txtNickname">Nickname:</label> <input type="text" id="txtNickname" name="txtNickname" class="txt" <?php if ($username<>""){ echo(" value='" . $username . "'"); } ?>/>
	</p>
	<p>
		<label for="chatRoom">Room:</label> <input type="text" id="chatRoom" name="chatRoom" class="txt" value="General"/>
	</p>
	<p>
		<label for="lstStyles">Skin:</label> 
		<select id="lstStyles" name="lstStyles">
			<option value="generic.css">Generic</option>
		</select>
	</p>
	<p>
	<label for="lstColors">Color:</label>
	<INPUT TYPE="text" id="txtColor" NAME="txtColor" <?php if ($usercolor<>""){ echo(" value='" . $usercolor . "'"); } ?> class="txt"> <A HREF="#" onClick="cp.select(document.forms[0].txtColor,'pick');return false;" NAME="pick" ID="pick">Pick</A>
	</TD>
	</p>
	</div>
	<div id="avatars">
	<ul>
		<li><input CHECKED type="radio" name="IconList" value="images/characters/humanmale.gif"/> <img src="images/characters/humanmale.gif" width="24" height="24" title="WoW Human Male" alt="WoW Human Male"/></li>
		<li><input <?php if ($usericon=="images/characters/humanfemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/humanfemale.gif"/> <img src="images/characters/humanfemale.gif" width="24" height="24" alt="WoW Human Female"/></li>
		<li><input <?php if ($usericon=="images/characters/nemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/nemale.gif"/> <img src="images/characters/nemale.gif" width="24" height="24" alt="Night Elf Male"/></li>
		<li><input <?php if ($usericon=="images/characters/nefemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/nefemale.gif"/> <img src="images/characters/nefemale.gif" width="24" height="24" alt="Night Elf Female"/></li>
		<li><input <?php if ($usericon=="images/characters/dwarfmale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/dwarfmale.gif"/> <img src="images/characters/dwarfmale.gif" width="24" height="24" alt="WoW Dwarf Male"/></li>
		<li><input <?php if ($usericon=="images/characters/dwarffemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/dwarffemale.gif"/> <img src="images/characters/dwarffemale.gif" width="24" height="24" alt="WoW Dwarf Female"/></li>
	</ul>
	<ul>
		<li><input <?php if ($usericon=="images/characters/gnomemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/gnomemale.gif"/> <img src="images/characters/gnomemale.gif" width="24" height="24" alt="WoW Gnome Male"/></li>
		<li><input <?php if ($usericon=="images/characters/gnomefemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/gnomefemale.gif"/> <img src="images/characters/gnomefemale.gif" width="24" height="24" alt="WoW Gnome Female"/></li>
		<li><input <?php if ($usericon=="images/characters/taurenmale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/taurenmale.gif"/> <img src="images/characters/taurenmale.gif" width="24" height="24" alt="Tauren Male"/></li>
		<li><input <?php if ($usericon=="images/characters/taurenfemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/taurenfemale.gif"/> <img src="images/characters/taurenfemale.gif" width="24" height="24" alt="Tauren Female"/></li>
		<li><input <?php if ($usericon=="images/characters/undeadmale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/undeadmale.gif"/> <img src="images/characters/undeadmale.gif" width="24" height="24" alt="Undead Male"/></li>
		<li><input <?php if ($usericon=="images/characters/undeadfemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/undeadfemale.gif"/> <img src="images/characters/undeadfemale.gif" width="24" height="24" alt="Undead Female"/></li>
	</ul>
	<ul>
		<li><input <?php if ($usericon=="images/characters/orcemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/orcmale.gif"/> <img src="images/characters/orcmale.gif" width="24" height="24" alt="Orc Male"/></li>
		<li><input <?php if ($usericon=="images/characters/orcfemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/orcfemale.gif"/> <img src="images/characters/orcfemale.gif" width="24" height="24" alt="Orc Female"/></li>
		<li><input <?php if ($usericon=="images/characters/trollmale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/trollmale.gif"/> <img src="images/characters/trollmale.gif" width="24" height="24" alt="Troll Male"/></li>
		<li><input <?php if ($usericon=="images/characters/trollfemale.gif"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/trollfemale.gif"/> <img src="images/characters/trollfemale.gif" width="24" height="24" alt="Troll Female"/></li>
		<li><input <?php if ($usericon=="images/characters/arwen.jpg"){ echo(" CHECKED "); } ?>  type="radio" name="IconList"  value="images/characters/arwen.gif"/> <img src="images/characters/arwen.jpg" width="24" height="24" alt="Arwen"/></li>
	</ul>
	</div>
	<div id="#footer">
	<p>
		<a href="http://validator.w3.org/check?uri=referer">
			<img src="http://www.w3.org/Icons/valid-xhtml10" alt="Valid XHTML 1.0!" height="31" width="88" />
		</a>
	</p>
	</div>
</div>
<SCRIPT LANGUAGE="JavaScript">cp.writeDiv()</SCRIPT>
</form>
</body>
</html>
<?php
 include("dbclose.php");
?>
-->    
    </form>
</body>
</html>
