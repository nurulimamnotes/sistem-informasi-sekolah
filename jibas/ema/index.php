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
session_name("jbsema");
session_start();

if (!isset($_SESSION['login']))
{ 
	//header("location: login.php");
	include('login.php');
	exit;
}
else 
{	?>
	<title>JIBAS - EMA</title>
	<link href="img/jibas.ico" rel="shortcut icon" />
	<frameset rows="80,*,30" frameborder="0">
	<frame src="frametop.php" name="frametop" scrolling="no">
	<frame src="siswa/siswa.php" name="content">
	<frame src="framebottom.php" name="framebottom" scrolling="no">
	</frameset><noframes></noframes>
<?
}
?>