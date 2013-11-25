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
require_once('include/config.php');
require_once('include/db_functions.php');

header("Last-Modified: " .gmdate("D, d M Y H:i:s"). " GMT");
header("Cache-control: no-store, no-cache, must-revalidate");
header("Cache-control: post-check=0, pre-check=0", false);

OpenDb();

session_name("jbsinfosiswa");
session_start();
    
$username = trim($_POST[username]);
if ($username == "jibas") 
	$username = "landlord";
$password = trim($_POST[password]);

$user_exists = false;

if ($username == "landlord")
{
	$sql_la = "SELECT password FROM jbsuser.landlord";
	$result_la = QueryDb($sql_la) or die(mysql_error());
	$row_la = @mysql_fetch_row($result_la);
	if (md5($password)==$row_la[0])
	{
		$_SESSION['login'] = "landlord";
		$_SESSION['nama'] = "landlord";
		$_SESSION['panggilan'] = "Admin";
		$_SESSION['theme'] = 1;
		$user_exists = true;
	}
} 
elseif ($username=="adminsiswa")
{
	$sql_la = "SELECT password FROM jbsuser.adminsiswa";
	$result_la = QueryDb($sql_la) or die(mysql_error());
	$row_la = @mysql_fetch_row($result_la);
	if (md5($password)==$row_la[0])
	{
		$_SESSION['login'] = "adminsiswa";
		$_SESSION['nama'] = "adminsiswa";
		$_SESSION['panggilan'] = "Admin Siswa";
		$_SESSION['theme'] = 1;
		$user_exists = true;
	}
} 
else 
{
	$query = "SELECT p.nis as nis,p.nama as nama, p.panggilan as panggilan FROM jbsakad.siswa p WHERE p.nis = '$username' AND p.pinsiswa='$password'";
	$result = QueryDb($query) or die(mysql_error());
	$row = mysql_fetch_array($result);
	$num = mysql_num_rows($result);
	if($num != 0) 
	{
		$_SESSION['login'] = $row[nis];
		$_SESSION['nama'] = $row[nama];
		$_SESSION['panggilan'] = $row[panggilan];
		$user_exists = true;
	}
}

if (!$user_exists) 
{
    ?>
    <script language="JavaScript">
        alert("Username atau password tidak cocok!");
        document.location.href = "../infosiswa/";
    </script>
    <?
}
else
{
	if ($username=="landlord")
	{
		$query = "UPDATE jbsuser.landlord SET lastlogin=NOW() WHERE password='".md5($password)."'";
    } 
	elseif ($username=="adminsiswa")
	{
		$query = "UPDATE jbsuser.adminsiswa SET lastlogin=NOW() WHERE password='".md5($password)."'";
    } 
	else 
	{
		$sql = "SELECT * FROM jbsuser.hakakses WHERE modul='INFOSISWA' AND login='$username'";
		$result = QueryDb($sql);
		$num=@mysql_num_rows($result);
		$query = "UPDATE jbsuser.hakaksesinfosiswa SET lastlogin=NOW() WHERE nis='$username'";
	}
	$result = QueryDb($query);
	?>
    <script language="JavaScript">
        top.location.href = "../infosiswa/";
    </script>
    <?
	exit();
	}
?>