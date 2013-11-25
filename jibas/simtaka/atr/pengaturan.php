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
require_once("../inc/session.checker.php");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="../sty/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../scr/tools.js"></script>
<script language="javascript">
function OpenConf(){
	newWindow('konfigurasi.php', 'Konfigurasi','348','225','resizable=0,scrollbars=0,status=0,toolbar=0')
}
function ChgPass(){
	newWindow('user_ganti.php', 'Konfigurasi','348','225','resizable=0,scrollbars=0,status=0,toolbar=0')
}
</script>
<style type="text/css">
<!--
.style2 {
	color: #A9A9A9;
	font-size: 18px;
}
.style4 {color: #A9A9A9; font-size: 14px; }
-->
</style>
</head>

<body>
<div id="title" align="center">
	<font style="color:#FF9900; font-size:30px;"><strong>.:</strong></font>
	<font style="font-size:18px; color:#999999">Pengaturan</font><br />
</div>
<br>
<!-- ImageReady Slices (Untitled-5) -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td>
        <table id="Table_01" width="194" height="100" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td colspan="4">
                    <img src="../img/set_01.jpg" width="194" height="15" alt=""></td>
            </tr>
            <tr>
                <td>
                    <a href="anggota.php"><img src="../img/set_02.jpg" alt="" width="82" height="78" border="0"></a></td>
                <td rowspan="2">
                  <img src="../img/set_03.jpg" width="23" height="85" alt=""></td>
                <td>
                  <a href="pengguna.php"><img src="../img/set_04.jpg" alt="" width="79" height="78" border="0"></a></td>
                <td rowspan="2">
                  <img src="../img/set_05.jpg" width="10" height="85" alt=""></td>
            </tr>
            <tr>
                <td>
                    <img src="../img/set_06.jpg" width="82" height="7" alt=""></td>
                <td>
                    <img src="../img/set_07.jpg" width="79" height="7" alt=""></td>
            </tr>
        </table>
        </td>
        <td>
        <table  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><a href="javascript:ChgPass()"><img src="../img/lock.png" width="64" height="63" border="0" /><br />
              <span class="style4">Ganti&nbsp;Password</span></a></td>
          </tr>
        </table>
        </td>
      </tr>
    </table>

    
    
    </td>
  </tr>
  <tr>
    <td align="center">
    <table border="0">
      <tr>
        <td width="105"><a href="javascript:OpenConf()"><img src="../img/Konfigurasi.png" width="105" height="105" border="0" /><br />
          <span class="style2">Konfigurasi</span></a></td>
        <td width="95" align="center"><a href="Header.php"><img src="../img/header.png" width="105" height="105" border="0" /><br />
          <span class="style4">Header Cetak</span></a></td>
        <td width="95" align="center"><a href="queryerror.php"><img src="../img/ico/b_warning.png" width="105" height="105" border="0" /><br />
          <span class="style4">Query Error Log</span></a></td>
      </tr>
    </table>
    </td>
  </tr>
</table>


<!-- End ImageReady Slices -->
</body>
</html>