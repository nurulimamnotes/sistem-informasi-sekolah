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
require_once('../include/errorhandler.php');
require_once('../include/sessioninfo.php');
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('../library/departemen.php');
require_once('../cek.php');

if (isset($_REQUEST['departemen']))
	$departemen = $_REQUEST['departemen'];

if (isset($_REQUEST['proses'])) 
	$proses = $_REQUEST['proses'];

OpenDb();

if (isset($_REQUEST['Simpan']))
{
	$sql = "SELECT COUNT(replid) FROM settingpsb WHERE idproses = '$proses'";
	$res = QueryDb($sql);
	$row = mysql_fetch_row($res);
	$ndata = $row[0];
	
	$set = "";
	for($i = 1; $i <= 2; $i++)
	{
		if ($set != "")
			$set .= ", ";
		$fkd = "kdsum$i";
		$fnm = "nmsum$i";
		$kd = $_REQUEST[$fkd];
		$nm = $_REQUEST[$fnm];
		$kd = str_replace("'", "`", $kd);
		$nm = str_replace("'", "`", $nm);
		$set .= "$fkd = '$kd', $fnm = '$nm'";
	}
	
	for($i = 1; $i <= 5; $i++)
	{
		if ($set != "")
			$set .= ", ";
		$fkd = "kdujian$i";
		$fnm = "nmujian$i";
		$kd = $_REQUEST[$fkd];
		$nm = $_REQUEST[$fnm];
		$kd = str_replace("'", "`", $kd);
		$nm = str_replace("'", "`", $nm);
		$set .= "$fkd = '$kd', $fnm = '$nm'";
	}
	
	if ($ndata == 0)
		$sql = "INSERT INTO settingpsb SET idproses = '$proses', $set";
	else
		$sql = "UPDATE settingpsb SET $set WHERE idproses = '$proses'";
	
	QueryDb($sql);
}

$sql = "SELECT COUNT(replid) FROM settingpsb WHERE idproses = '$proses'";
$res = QueryDb($sql);
$row = mysql_fetch_row($res);
$ndata = $row[0];

if ($ndata > 0)
{
	$sql = "SELECT * FROM settingpsb WHERE idproses = '$proses'";
	$res = QueryDb($sql);
	$row = mysql_fetch_array($res);
	
	$kdsum1 = $row['kdsum1']; $nmsum1 = $row['nmsum1'];
	$kdsum2 = $row['kdsum2']; $nmsum2 = $row['nmsum2'];
	$kdujian1 = $row['kdujian1']; $nmujian1 = $row['nmujian1'];
	$kdujian2 = $row['kdujian2']; $nmujian2 = $row['nmujian2'];
	$kdujian3 = $row['kdujian3']; $nmujian3 = $row['nmujian3'];
	$kdujian4 = $row['kdujian4']; $nmujian4 = $row['nmujian4'];
	$kdujian5 = $row['kdujian5']; $nmujian5 = $row['nmujian5'];
}

CloseDb();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/tooltips.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Konfigurasi Pendataan PSB</title>
<script language="JavaScript" src="../script/tooltips.js"></script>
<script language="javascript" src="../script/tables.js"></script>
<script language="javascript" src="../script/tables.js"></script>
<script language="javascript" src="../script/tools.js"></script>
<script language="javascript">
function validate()
{
	return confirm("Simpan data?");
}

</script>

</head>

<body topmargin="0" leftmargin="0">
<table border="0" width="100%" align="center" background="../images/b_calon.png" style="background-repeat:no-repeat;">
<tr>
<td align="right" >

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="15%">&nbsp;</td>
    <td width="*">
    
    <form name="main" method="post" onsubmit="return validate()">
	<br /><br />    
    <input type="hidden" name="departemen" id="departemen" value="<?=$departemen ?>" />
    <input type="hidden" name="proses" id="proses" value="<?=$proses ?>" />
    <table border="1" cellpadding="2" cellspacing="0" align="left" width="50%" class="tab">
    <tr height="30">
        <td align="left" width="30%" class="header">Jenis</td>
        <td align="center" width="20%" class="header">Kode</td>
        <td align="left" width="*" class="header">Nama</td>
    </tr>
    <tr>
    	<td align="left">Sumbangan #1</td>
        <td align="center"><input type="text" id="kdsum1" value="<?= $kdsum1 ?>" name="kdsum1" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmsum1" value="<?= $nmsum1 ?>" name="nmsum1" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Sumbangan #2</td>
        <td align="center"><input type="text" id="kdsum2" value="<?= $kdsum2 ?>" name="kdsum2" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmsum2" value="<?= $nmsum2 ?>" name="nmsum2" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Ujian #1</td>
        <td align="center"><input type="text" id="kdujian1" value="<?= $kdujian1 ?>" name="kdujian1" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmujian1" value="<?= $nmujian1 ?>" name="nmujian1" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Ujian #2</td>
        <td align="center"><input type="text" id="kdujian2" value="<?= $kdujian2 ?>" name="kdujian2" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmujian2" value="<?= $nmujian2 ?>" name="nmujian2" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Ujian #3</td>
        <td align="center"><input type="text" id="kdujian3" value="<?= $kdujian3 ?>" name="kdujian3" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmujian3" value="<?= $nmujian3 ?>" name="nmujian3" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Ujian #4</td>
        <td align="center"><input type="text" id="kdujian4" value="<?= $kdujian4 ?>" name="kdujian4" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmujian4" value="<?= $nmujian4 ?>" name="nmujian4" size="30" maxlength="50" /></td>
    </tr>
    <tr>
    	<td align="left">Ujian #5</td>
        <td align="center"><input type="text" id="kdujian5" value="<?= $kdujian5 ?>" name="kdujian5" size="5" maxlength="5" /></td>
        <td align="left"><input type="text" id="nmujian5" value="<?= $nmujian5 ?>" name="nmujian5" size="30" maxlength="50" /></td>
    </tr>
    <tr>
        <td colspan="3" align="center" style="background-color:#CCC">
        <input type="submit" class="but" name="Simpan" id="Simpan" value="Simpan" />
        </td>
    </tr>
    </table>
    </form>
    
    </td>
</tr>
</table>

    
</td>
</tr>
</table>    
</body>
</html>