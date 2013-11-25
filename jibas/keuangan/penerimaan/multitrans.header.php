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
require_once('../include/sessionchecker.php');
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('../include/sessioninfo.php');
require_once('../library/departemen.php');
require_once('multitrans.header.func.php');

$departemen = "";
if (isset($_REQUEST['departemen']))
	$departemen = $_REQUEST['departemen'];

OpenDb();    
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Multiple Transactions</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../style/style.css" />
    <script language="javascript" src="multitrans.header.js"></script>
	<script language="javascript" src="../script/tools.js"></script>
    <script language="javascript" src="../script/jquery-1.9.0.js"></script>
</head>

<body topmargin="0" leftmargin="0" onload="document.getElementById('departemen').focus();">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
<tr>
    <td width="40%">
        
    <table width="100%" border="0">
    <tr>
    	<td align="left" width = "15%"><strong>Departemen&nbsp;</strong></td>
      	<td width="*">
<?      ShowSelectDept(); ?>            
        <strong>Tahun Buku&nbsp;</strong>
<?      ShowAccYear();    ?>
    	</td>
	</tr>
    <tr>
    	<td><strong>Nama&nbsp;</strong></td>
      	<td>
			<input type="hidden" name="kelompok" id="kelompok">
            <input type="text" name="noid" id="noid" size="15" readonly style="background-color:#CCCC99">
            <input type="text" name="nama" id="nama" size="30" readonly style="background-color:#CCCC99">
            <input type="button" class="but" value="..." onclick="SearchUser()">    
    	</td>
	</tr>
	</table>
    
    </td>		
    <td width="*" valign="middle">
		<a href="#" onclick="StartPayment()">
        <img src="../images/view.png" border="0" height="48" width="48"/>
		</a>    
    </td>
    <td width="30%" align="right" valign="top">
        <font size="4" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="4" face="Verdana, Arial, Helvetica, sans-serif" color="Gray">Multi Payment</font><br />
        <a href="../penerimaan.php" target="_parent">
        <font size="1" color="#000000"><b>Penerimaan</b></font></a>&nbsp>&nbsp
        <font size="1" color="#000000"><b>Multi Payment</b></font>
    </td>  
</tr>
</table>
</body>
</html>
<?
CloseDb();
?>