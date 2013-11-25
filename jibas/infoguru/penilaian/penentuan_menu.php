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

if(isset($_REQUEST["tahun"]))
	$tahun = $_REQUEST["tahun"];
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

$warna=array('fcf5ca','d5fcca','cafcf3','cae6fc','facafc');

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../style/style.css">
<script language="JavaScript" src="../script/tables.js"></script>
<script language="JavaScript">

function klik(idpelajaran,aspek,aspekket,kelas,semester,nip,tingkat,departemen,tahun){

	parent.penentuan_content.location.href="penentuan_content.php?pelajaran="+idpelajaran+"&aspek="+aspek+"&aspekket="+aspekket+"&kelas="+kelas+"&semester="+semester+"&nip="+nip+"&tingkat="+tingkat+"&departemen="+departemen+"&tahun="+tahun;
}
//function klik(departemen,tingkat,idpelajaran,kelas,semester,nip){
//	parent.penentuan_content.location.href="penentuan_content.php?departemen="+departemen+"&tingkat="+tingkat+"&pelajaran="+idpelajaran+"&kelas="+kelas+"&semester="+semester+"&nip="+nip;
//}
</script>
</head>
<body topmargin="0" leftmargin="0">
<?
OpenDb();
$query_aturan = "SELECT DISTINCT aturannhb.idpelajaran, pelajaran.nama 
				   FROM jbsakad.aturannhb aturannhb, jbsakad.pelajaran pelajaran 
				  WHERE aturannhb.nipguru = '$nip' AND idpelajaran=pelajaran.replid 
				  	AND pelajaran.departemen='$departemen' AND aturannhb.idtingkat='$tingkat' AND aturannhb.aktif = 1 ORDER BY pelajaran.nama";

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
if (!mysql_num_rows($result_aturan)==0){ ?>

<table class="tab" id="table" border="1" style="border-collapse:collapse" width="100%" align="left" bordercolor="#000000">
<!-- TABLE CONTENT -->
    
<tr height="30">    	
    <td width="100%" class="header" align="center">Pelajaran</td>
</tr>	
<?  $cnt = 0;
	while ($row_aturan=@mysql_fetch_array($result_aturan)) 
	{
		$idpelajaran = $row_aturan['idpelajaran'];
		$sql = "SELECT DISTINCT a.dasarpenilaian, dp.keterangan
				  FROM aturannhb a, dasarpenilaian dp
				 WHERE a.dasarpenilaian = dp.dasarpenilaian 
				   AND a.nipguru = '$nip' AND a.idpelajaran = '$idpelajaran'
				   AND a.idtingkat = '$tingkat' AND a.aktif = 1
			  ORDER BY keterangan";	
		$res = QueryDb($sql); ?>
<tr>   	
    <td align="left" height="25">
    <b><font style="font-size:14px; font-family:Arial;"><?=$row_aturan['nama']?></font>:</b><br />
<?		while($row = mysql_fetch_array($res)) 
		{ ?>
		<a href="#" onclick="klik('<?=$row_aturan['idpelajaran']?>','<?=$row['dasarpenilaian']?>','<?=$row['keterangan']?>','<?=$kelas?>','<?=$semester?>','<?=$nip?>','<?=$tingkat?>','<?=$departemen?>','<?=$tahun?>')"><font color="#0000FF"><strong><?=$row['keterangan']?></strong></font></a><br />
<?		} ?>	
    </td>
</tr>
<!-- END TABLE CONTENT -->
<?
 	} // while
?>	
</table>
<script language='JavaScript'>
	Tables('table', 1, 0);
</script>
<? 
} 
else 
{ 
?>
<table width="100%" border="0" align="center">          
<tr>
    <td align="center" valign="middle" height="300">
    <font size = "2" color ="red"><b>Tidak ditemukan adanya data. <br /><br />Tambah aturan perhitungan grading nilai pelajaran yang akan diajar oleh guru <?=$_REQUEST['nama']?> di menu Aturan Perhitungan Grading Nilai pada bagian Guru & Pelajaran. </b></font>
    </td>
</tr>
</table> 
<? 
} 
?> 
</body>
<? CloseDb(); ?>
</html>