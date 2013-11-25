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
require_once('../sessionchecker.php');
require_once('../library/dpupdate.php');

if(isset($_REQUEST["departemen"]))
	$departemen = $_REQUEST["departemen"];
if(isset($_REQUEST["tingkat"]))
	$tingkat = $_REQUEST["tingkat"];
if(isset($_REQUEST["semester"]))
	$semester = $_REQUEST["semester"];
if(isset($_REQUEST["kelas"]))
	$kelas = $_REQUEST["kelas"];
if(isset($_REQUEST["nip"]))
	$nip = $_REQUEST["nip"];
	
$warna = array('fcf5ca','d5fcca','cafcf3','cae6fc','facafc');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../style/style.css">
<title>Menu</title>
<script language="JavaScript" src="../script/tables.js"></script>
<script language="JavaScript">

function klik(kelas,semester,idaturan)
{	
	parent.nilai_pelajaran_content.location.href="nilai_pelajaran_content.php?&kelas="+kelas+"&semester="+semester+"&idaturan="+idaturan;
}

</script>
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:1px">
<? 
OpenDb();

$query_aturan = "SELECT DISTINCT g.idpelajaran, p.nama
				       FROM jbsakad.aturannhb a, jbsakad.pelajaran p, jbsakad.guru g
						WHERE g.nip = '$nip'
						  AND a.nipguru = g.nip
						  AND g.idpelajaran = p.replid
						  AND p.departemen = '$departemen'
						  AND a.idtingkat = '$tingkat'
						  AND a.aktif = 1
					   ORDER BY p.nama";

$result_aturan = QueryDb($query_aturan);
if (!mysql_num_rows($result_aturan) == 0)
{
?>
<table width="100%" border="0">
<?	$i = 0;
	$cnt = 0;
	while ($row_aturan = @mysql_fetch_array($result_aturan))
	{
		if ($i >= 5)
			$i = 0; ?>
<tr>
	<td>
    <fieldset style="background-color:#<?=$warna[$i]?>">
    <legend><strong><font size="2" face="verdana">
		<?=$row_aturan['nama']; ?></font></strong>
    </legend> 
    <table width="100%" cellspacing="2" >
<?	$query_ap = "SELECT DISTINCT a.dasarpenilaian, dp.keterangan 
				   FROM jbsakad.aturannhb a, dasarpenilaian dp
				  WHERE idpelajaran = '$row_aturan[idpelajaran]' 
				    AND a.dasarpenilaian = dp.dasarpenilaian 
				    AND idtingkat = '$tingkat' AND nipguru = '$nip' ORDER BY keterangan";
	$result_ap = QueryDb($query_ap);
	while($row_ap = @mysql_fetch_array($result_ap))
	{
		$cnt++;	?> 
	   	<tr>
   		<td>  
        	<table class="tab" id="table<?=$cnt?>" border="1" style="border-collapse:collapse" width="100%" align="left" bordercolor="#000000">
        	<tr height="30" class="header" align="center">
            	<td><?=$row_ap['keterangan']?></td>
	        </tr>
    <? 	$query_jp = "SELECT a.idjenisujian, j.jenisujian, j.replid, a.replid 
					   FROM jbsakad.aturannhb a, jbsakad.jenisujian j 
					  WHERE a.idpelajaran='$row_aturan[idpelajaran]' AND a.dasarpenilaian='$row_ap[dasarpenilaian]' 
					    AND a.idjenisujian=j.replid AND a.idtingkat='$tingkat' AND a.nipguru='$nip' ORDER BY j.jenisujian";
		$result_jp = QueryDb($query_jp);
		while($row_jp = @mysql_fetch_row($result_jp))
		{	?>
        	<tr>
            <td height="25" style="cursor:pointer" onclick="klik('<?=$kelas?>','<?=$semester?>','<?=$row_jp[3]?>')" align="center">
            	<u><strong><?=$row_jp[1]?></strong></u>
            </td>
        	</tr>
	<?	} ?>
  			</table>
	   		<script language='JavaScript'>Tables('table<?=$cnt?>', 1, 0);</script>
    	</td>
    </tr>	
<?	} ?>
	</table> 
    </fieldset>
    </td>
</tr>
<?
  $i++;
  } 
?>
</table>  
<? 
} else { 
?>
<table width="100%" border="0" align="center">          
<tr>
    <td align="center" valign="middle" height="300">
    <font size = "2" color ="red"><b>Tidak ditemukan adanya data. <br /><br />Tambah aturan perhitungan nilai rapor yang akan diajar oleh guru <?=$_REQUEST['nama']?> di menu Aturan Perhitungan Nilai Rapor pada bagian Guru & Pelajaran. </b></font>
    </td>
</tr>
</table>
<? } ?>
</body>
<? CloseDb(); ?>
</html>