<?
/**[N]**
 * JIBAS Education Community
 * Jaringan Informasi Bersama Antar Sekolah
 * 
 * @version: 3.2 (September 03, 2013)
 * @notes: JIBAS Education Community will be managed by Yayasan Indonesia Membaca (http://www.indonesiamembaca.net)
 * 
 * Copyright (C) 2009 Yayasan Indonesia Membaca (http://www.indonesiamembaca.net)
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 **[N]**/ ?>
<?
require_once('inc/config.php');
require_once('inc/db_functions.php');
require_once('inc/sessioninfo.php');
require_once('inc/sessionchecker.php');
OpenDb();
$sql = "SELECT YEAR(NOW()),MONTH(NOW()),DAY(NOW())";
$result = QueryDb($sql);
$row = @mysql_fetch_row($result);
$y = $row[0];
$m = $row[1];
$d = $row[2]; 
CloseDb();
$month = array ('','Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Jibas Ema</title>
<script type="text/javascript" src="script/dhtml/stmenu.js"></script>
<script type="text/javascript">
function logout(){
	if (confirm('Anda yakin akan keluar dari JibasEma?'))
		top.location.href = "logout.php";
}
</script>
<style type="text/css">
<!--
.style1 {
	font-family: Calibri;
	font-size: 36px;
	font-weight: bold;
	color: #FFFFFF;
}
.style2 {
	font-family: Arial;
	font-weight: bold;
	color: #FFCC66;
}
.style4 {
	font-family: Tahoma;
	color: #FFCC66;
	font-weight: bold;
}
-->
</style>
</head>
<body style="margin-top:0px;margin-left:0px;margin-right:0px;margin-bottom:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="80%" style="background-image:url(img/top_header_new_01.png); background-repeat:repeat-x"><img src="img/top_header_new.png" width="396" height="50" /></td>
    <td width="20%" style="background-image:url(img/top_header_new_01.png); background-repeat:repeat-x">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="18%" align="right"><div style="padding-right:5px"><span class="style1"><?=$d?></span></div></td>
            <td width="82%" valign="middle"><span class="style2"><?=$month[$m]?></span><br /><span class="style4"><?=$y?>
            </span></td>
            </tr>
      	</table>    </td>
  </tr>
  <tr>
    <td style="background-image:url(img/bluefireback1.gif); background-repeat:repeat-x">
	<? if(is_admin()) { ?>
	<script type="text/javascript" src="script/dhtml/emamenu.js"></script>
    <? } else { ?>
    <script type="text/javascript" src="script/dhtml/emamenu2.js"></script>
	<? } ?>
	</td>
    <td style="background-image:url(img/bluefireback1.gif); background-repeat:repeat-x">
    </td>
  </tr>
</table>
</body>
</html>