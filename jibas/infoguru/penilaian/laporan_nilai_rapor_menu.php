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
//require_once('../include/errorhandler.php');
require_once('../include/sessioninfo.php');
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('../library/dpupdate.php');

OpenDb();

$urut = $_REQUEST['urut'];
if ($urut=="")
	$urut="nama";
else 
	$urut = $_REQUEST['urut'];

$urutan = $_REQUEST['urutan'];
if ($urutan=="")
	$urutan="asc";
else 
	$urutan = $_REQUEST['urutan'];

if (isset($_REQUEST['departemen']))
	$departemen = $_REQUEST['departemen'];
if (isset($_REQUEST['semester']))
	$semester = $_REQUEST['semester'];
if (isset($_REQUEST['tingkat']))
	$tingkat = $_REQUEST['tingkat'];
if (isset($_REQUEST['tahunajaran']))
	$tahunajaran = $_REQUEST['tahunajaran'];
if (isset($_REQUEST['kelas']))
	$kelas = $_REQUEST['kelas'];
if (isset($_REQUEST['harian']))
	$harian = $_REQUEST['harian'];
if (isset($_REQUEST['pelajaran']))
	$pelajaran = $_REQUEST['pelajaran'];
	
$sql1 = "SELECT kelas FROM jbsakad.kelas WHERE replid='$kelas'";
$result1 = QueryDb($sql1);
$row1 = @mysql_fetch_array($result1);	

$sql = "SELECT DISTINCT a.dasarpenilaian, d.keterangan
  	      FROM infonap i, nap n, aturannhb a, dasarpenilaian d
		 WHERE i.replid = n.idinfo
		   AND i.idsemester = '$semester' 
		   AND i.idkelas = '$kelas'
		   AND n.idaturan = a.replid 	   
		   AND a.dasarpenilaian = d.dasarpenilaian";
$res = QueryDb($sql);
$naspek = mysql_num_rows($res);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/aTR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/tooltips.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Komentar Nilai Rapor</title>
<script language="JavaScript" src="../script/tooltips.js"></script>
<script language="javascript" src="../script/tables.js"></script>
<script language="javascript" src="../script/validasi.js"></script>
<script language="javascript" src="../script/tools.js"></script>
<script language="javascript">

function refresh() 
{	
	document.location.reload();
}

function tampil(nis) 
{	
	if (<?=$naspek?> > 2)
		parent.laporan_rapor_content.location.href="laporan_nilai_content_row.php?departemen=<?=$departemen?>&semester=<?=$semester?>&prespel=<?=$pelajaran?>&harian=<?=$harian?>&tingkat=<?=$tingkat?>&tahunajaran=<?=$tahunajaran?>&kelas=<?=$kelas?>&nis="+nis;
	else		
		parent.laporan_rapor_content.location.href="laporan_nilai_content.php?departemen=<?=$departemen?>&semester=<?=$semester?>&prespel=<?=$pelajaran?>&harian=<?=$harian?>&tingkat=<?=$tingkat?>&tahunajaran=<?=$tahunajaran?>&kelas=<?=$kelas?>&nis="+nis;
}

function change_urut(urut,urutan) 
{
	if (urutan=="asc")
		urutan="desc"
	else 
		urutan="asc"
	
	document.location.href="laporan_nilai_rapor_menu.php?departemen=<?=$departemen?>&semester=<?=$semester?>&tingkat=<?=$tingkat?>&tahunajaran=<?=$tahunajaran?>&kelas=<?=$kelas?>&urut="+urut+"&urutan="+urutan;
}

function cetak_rapor_kelas() 
{
	if (<?=$naspek?> > 2)
		newWindow('cetak_rapor_kelas_row.php?departemen=<?=$departemen?>&tahunajaran=<?=$tahunajaran?>&semester=<?=$semester?>&tingkat=<?=$tingkat?>&harian=<?=$harian?>&prespel=<?=$pelajaran?>&kelas=<?=$kelas?>','CetakFormKomentarNilaiRaporSiswa',760,850,'resizable=1,scrollbars=1,status=0,toolbar=0');
	else
		newWindow('cetak_rapor_kelas.php?departemen=<?=$departemen?>&tahunajaran=<?=$tahunajaran?>&semester=<?=$semester?>&tingkat=<?=$tingkat?>&harian=<?=$harian?>&prespel=<?=$pelajaran?>&kelas=<?=$kelas?>','CetakFormKomentarNilaiRaporSiswa',760,850,'resizable=1,scrollbars=1,status=0,toolbar=0');
}
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
}
.style2 {color: #FFFF00}
.style3 {color: #FFFFFF}
-->
</style>
</head>

<body topmargin="0" leftmargin="0">
<form name="main" method="post" action="komentar_footer.php" enctype="multipart/form-data">

<input type="hidden" name="departemen" id="departemen" value="<?=$departemen ?>" />
<input type="hidden" name="semester" id="semester" value="<?=$semester ?>" />
<input type="hidden" name="tingkat" id="tingkat" value="<?=$tingkat ?>" />
<input type="hidden" name="tahunajaran" id="tahunajaran" value="<?=$tahunajaran ?>" />
<input type="hidden" name="kelas" id="kelas" value="<?=$kelas ?>" />
<? 
	$sql = "SELECT s.nis, s.nama FROM siswa s WHERE s.idkelas = '$kelas' AND s.aktif=1 AND s.alumni=0 ORDER BY s.nama ASC";
	$result = QueryDb($sql);		
	$cnt = 1;
	$jum = @mysql_num_rows($result);
	if ($jum > 0) {
?>	

<table border="0" width="100%" align="center">
<!-- TABLE CENTER -->
<tr height="30" bgcolor="#CCCCCC">
  <td align="center" colspan="2" valign="middle"><input class="but" type="button" name="cetak" id="cetak" value="Cetak Rapor Kelas <?=$row1['kelas']?>" onclick="cetak_rapor_kelas();" /></td>
</tr><br />
<tr>
    <td align="left" valign="top" colspan="2">       
	<table border="1" width="100%" id="table" class="tab" bordercolor="#000000">
		<tr>		
			<td width="3%" height="30" align="center" class="header">No</td>
			<td height="30" class="header"><div align="center" class="style1"><strong><span class="style3">Siswa</span></strong></div></td>
		</tr>
		<? while ($row = @mysql_fetch_array($result)) {	?>
        <tr>        			
			<td height="25" align="center" onclick="tampil('<?=$row[nis]?>')" style="cursor:pointer" title="Klik untuk menampilkan komentar rapor siswa ini"><?=$cnt?></td>
            
  			<td height="25" onclick="tampil('<?=$row[nis]?>')" style="cursor:pointer" title="Klik untuk menampilkan komentar rapor <?=$row['nama']?>"><?=$row['nis']?><br /><b><?=$row['nama']?></b><input type="hidden" name="replid<?=$cnt?>" value="<?=$row['replid']?>">
			<input type="hidden" name="nis<?=$cnt?>" value="<?=$row['nis']?>"></td>
        </tr>
 	<?		$cnt++;
		} 
			?>
		</table>   	 
    <!-- END TABLE CONTENT -->
      
    <script language='JavaScript'>
	   	Tables('table', 1, 0);
    </script> 
    	</td>
	</tr>
    <tr>    
    	<td align="right" colspan="2">
        </td>
	</tr>
    
<!-- END TABLE CENTER -->    
</table>
</form>
<?  } else {
	echo '<br> Belum ada data';
	}
?>

 
</body>
</html>
<?
CloseDb();
?>