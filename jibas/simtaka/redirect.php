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
session_name("jbsperpus");
session_start();

header("Last-Modified: " .gmdate("D, d M Y H:i:s"). " GMT");
header("Cache-control: no-store, no-cache, must-revalidate");
header("Cache-control: post-check=0, pre-check=0", false);

require_once('inc/config.php');
require_once('inc/db_functions.php');

OpenDb();
   
$username = trim($_POST[username]);
if ($username=="jibas") 
	$username="landlord";
$password = trim($_POST[password]);

$user_exists = false;
if ($username=="landlord")
{
	$sql_la = "SELECT password FROM $db_name_user.landlord";
	$result_la = QueryDb($sql_la) ;
	$row_la=@mysql_fetch_array($result_la);
	if (md5($password)==$row_la[password])
	{
		$_SESSION['login'] = "landlord";
		$_SESSION['tingkat'] = "0";
		$_SESSION['nama'] = "Administrator Jibas SimTaka";
		
		$user_exists = true;
	}
	else
	{
		$user_exists = false;
	}
}
else
{
	$sql = "SELECT p.aktif FROM $db_name_user.login l, $db_name_sdm.pegawai p WHERE l.login=p.nip AND l.login='$username' ";
	$result = QueryDb($sql);
	$row = mysql_fetch_array($result);
	$jum = mysql_num_rows($result);
	if ($jum > 0)
	{
		if ($row['aktif'] == 0)
		{
			?>
			<script language="JavaScript">
				alert("Status pengguna sedang tidak aktif!");
				document.location.href = "../simtaka/";
			</script>
			<?
		}
		else
		{
			$query = "SELECT login,password,nama FROM $db_name_user.login, $db_name_sdm.pegawai WHERE login = '$username'  ".
					 "AND password='".md5($password)."' AND nip=login";
			$result = QueryDb($query) or die(mysql_error());
			$row = mysql_fetch_array($result);
			$num = mysql_num_rows($result);
			if ($num != 0)
			{
				$q = "SELECT aktif,tingkat,departemen,info1 FROM $db_name_user.hakakses WHERE login = '$username'  ".
					 "AND modul='SIMTAKA'";
				$res = QueryDb($q) or die(mysql_error());
				$r = mysql_fetch_array($res);
				if ($r[aktif]==0)
				{	?>
					<script language="JavaScript">
						alert("Status pengguna sedang tidak aktif!");
						document.location.href = "../simtaka/";
					</script>
				<?		
				}
				else
				{
					$_SESSION['login'] = $row[login];
					$_SESSION['tingkat'] = $r[tingkat];
					$_SESSION['perpustakaan'] = $r[departemen];
					$_SESSION['idperpustakaan'] = $r[info1];
					$_SESSION['nama'] = $row[nama];
					$user_exists = true;
				}
			}
		} 
	}
	else
	{
		$user_exists = false;
	}		
}

if (!$user_exists)
{	?>
    <script language="JavaScript">
        alert("Username atau password tidak cocok!");
        document.location.href = "../simtaka/";
    </script>
	<?
}
else
{
	if ($username == "landlord")
    	$query = "UPDATE $db_name_user.landlord SET lastlogin=NOW() WHERE password='".md5($password)."'";
    else 
		$query = "UPDATE $db_name_user.hakakses SET lastlogin=NOW() WHERE login='$username' AND modul = 'SIMTAKA'";
	$result = QueryDb($query);
	
	if (isset($_SESSION['login']) && isset($_SESSION['tingkat']))
	{ 
	?>
    <script language="JavaScript">
        top.location.href = "../simtaka/";
    </script>
    <?
	}
	exit();
}
?>