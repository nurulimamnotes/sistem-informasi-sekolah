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
require_once('include/common.php');
require_once('include/config.php');
require_once('include/db_functions.php');
require_once('include/sessioninfo.php');
require_once('library/departemen.php');

$idtahunbuku = $_REQUEST['idtahunbuku'];
$idkategori = $_REQUEST['idkategori'];
$idpenerimaan = $_REQUEST['idpenerimaan'];
$departemen = $_REQUEST['departemen'];

$status = "Siswa";
if ($idkategori == "CSWJB" || $idkategori == "CSSKR") 
	$status = "Calon Siswa";

$page = 1;
if (isset($_REQUEST['page']))
	$page = $_REQUEST['page'];

$nitem = 15;
$minno = ($page - 1) * $nitem;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="style/style.css">
<link href="script/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script src="script/SpryTabbedPanels.js" type="text/javascript"></script>
<script language="JavaScript" src="script/tables.js"></script>
<script src="script/SpryValidationTextField.js" type="text/javascript"></script>
<link href="script/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
<script src="script/SpryValidationSelect.js" type="text/javascript"></script>
<link href="script/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
<script src="script/ajax.js" type="text/javascript"></script>
<script language="javascript">

function pilih(id) 
{	
	parent.content.location.href = "pembayaran_tunggak_decide.php?id="+id+"&idkategori=<?=$idkategori?>&idpenerimaan=<?=$idpenerimaan?>&idtahunbuku=<?=$idtahunbuku?>&status=<?=$status?>&departemen=<?=$departemen?>";		
}

function change_page()
{
	page = document.getElementById('page').value;
	document.location.href = "pembayaran_tunggak_siswa.php?page="+page+"&idkategori=<?=$idkategori?>&idpenerimaan=<?=$idpenerimaan?>&idtahunbuku=<?=$idtahunbuku?>&departemen=<?=$departemen?>";	;
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background-color:#FFFFFF">
<input type="hidden" id="idtahunbuku" value="<?=$idtahunbuku ?>" />
<input type="hidden" id="idkategori" value="<?=$idkategori ?>" />
<input type="hidden" id="idpenerimaan" value="<?=$idpenerimaan ?>" />
<input type="hidden" id="departemen" value="<?=$departemen ?>" />
<input type="hidden" id="status" value="<?=$status ?>" />
<?
OpenDb();
if ($idkategori == "JTT")
{
	$sql = "SELECT COUNT(DISTINCT s.nis) 
			    FROM besarjtt b, penerimaanjtt p, jurnal j, jbsakad.siswa s
			   WHERE b.idpenerimaan = '$idpenerimaan' AND b.replid = p.idbesarjtt AND p.idjurnal = j.replid 
			     AND j.idtahunbuku = '$idtahunbuku' AND b.lunas = 0 AND b.nis = s.nis";
}
else
{
	$sql = "SELECT COUNT(DISTINCT cs.replid)  
			    FROM besarjttcalon b, penerimaanjttcalon p, jurnal j, jbsakad.calonsiswa cs
			   WHERE b.idpenerimaan = '$idpenerimaan' AND b.replid = p.idbesarjttcalon AND p.idjurnal = j.replid 
			     AND j.idtahunbuku = '$idtahunbuku' AND b.lunas = 0 AND b.idcalon = cs.replid";	
}

$ndata = FetchSingle($sql);
if ($ndata == 0)
{ ?>
	<table width="100%" align="center" cellpadding="2" cellspacing="0" border="0" id="table">
	<tr height="200" align="center"><td>   
	<br /><br />	
	<font size = "2" color ="red"><b>Tidak ditemukan adanya data</b></font>	
	<br /><br />
	</td></tr></table>
<?	
}
else
{
?>
  <h3>Data <?=$status?> Yang Memiliki Tunggakan</h3>
  <table width="95%" id="table" class="tab" align="center" border="1" bordercolor="#000000">
  	<tr height="30" class="header" align="center">
		<td width="7%">No</td>
    	<td width="15%" background="style/formbg2.gif">N I S</td>
    	<td background="style/formbg2.gif">Nama</td>
  	</tr>
<? 
	 if ($idkategori == "JTT")
	 {
			$sql = "SELECT DISTINCT b.nis, s.nama 
			 			FROM besarjtt b, penerimaanjtt p, jurnal j, jbsakad.siswa s
					   WHERE b.idpenerimaan = '$idpenerimaan' AND b.replid = p.idbesarjtt AND p.idjurnal = j.replid 
						 AND j.idtahunbuku = '$idtahunbuku' AND b.lunas = 0 AND b.nis = s.nis ORDER BY nama LIMIT $minno, $nitem";
	 }
	 else
	 {
			$sql = "SELECT DISTINCT cs.nopendaftaran, cs.nama 
						FROM besarjttcalon b, penerimaanjttcalon p, jurnal j, jbsakad.calonsiswa cs
						WHERE b.replid = p.idbesarjttcalon AND p.idjurnal = j.replid 
						 AND j.idtahunbuku = '$idtahunbuku' AND b.lunas = 0 AND b.idcalon = cs.replid ORDER BY nama LIMIT $minno, $nitem";	
	 }
	 $res = QueryDb($sql);
	 
    $cnt = $minno + 1;
	 while($row = mysql_fetch_row($res))
	 { ?>
    	<tr height="25" onClick="pilih('<?=$row[0]?>','<?=$row[1]?>')" style="cursor:pointer" id="siswapilih<?=$cnt?>">
	 		<td align="center"><?=$cnt ?></td>
			<td align="center"><?=$row[0] ?></td>
			<td align="left"><?=$row[1] ?></td>
	 	</tr>
<?		$cnt++;
	} ?>
  	</table>
	&nbsp;&nbsp;Halaman
  	<select name="page" id="page" onchange="change_page()">
  	<? 
	$npage = ceil($ndata / $nitem);
	for ($i = 1; $i <= $npage; $i++) { ?>
  		<option value="<?=$i?>" <?=IntIsSelected($page, $i)?> ><?=$i?></option>
<? } ?>		
  	</select>&nbsp;dari&nbsp;<?=$npage?>
<?  
}
CloseDb();
?>

</body>
</html>