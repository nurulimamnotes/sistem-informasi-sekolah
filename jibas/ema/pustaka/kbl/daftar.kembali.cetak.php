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
require_once('../../inc/sessioninfo.php');
require_once('../../inc/common.php');
require_once('../../inc/config.php');
require_once('../../inc/db_functions.php');
require_once('../../lib/GetHeaderCetak.php');
require_once('../../inc/rupiah.php');
OpenDb();
$departemen='yayasan';
$kriteria='all';
if (isset($_REQUEST[kriteria]))
	$kriteria=$_REQUEST[kriteria];
if ($kriteria=='nip')
	$statuspeminjam=0;
elseif ($kriteria=='nis')
	$statuspeminjam=1;
$noanggota = $_REQUEST[noanggota];
$nama = $_REQUEST[nama];
$sqlDate="SELECT DAY(now()),MONTH(now()),YEAR(now())";
$resultDate = QueryDb($sqlDate);
$rDate = @mysql_fetch_row($resultDate);
$tglAwal = $rDate[0]."-".$rDate[1]."-".$rDate[2];
$tglAkhir = $rDate[0]."-".$rDate[1]."-".$rDate[2];
if (isset($_REQUEST[tglAwal]))
	$tglAwal = $_REQUEST[tglAwal];
if (isset($_REQUEST[tglAkhir]))
	$tglAkhir = $_REQUEST[tglAkhir];	
$denda=0;
if (isset($_REQUEST[denda]))
	$denda=$_REQUEST[denda];
if ($kriteria=='all' || $kriteria==''){
	$title = "<tr><td>Berdasarkan&nbsp;:&nbsp;Semua&nbsp;Pengembalian</td></tr>";
} elseif ($kriteria=='tglpinjam') {
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;Tanggal Peminjaman</td></tr>";
	$title.= "<tr><td width='20'>Periode</td><td>&nbsp;:&nbsp;$tglAwal s.d. $tglAkhir</td></tr>";
} elseif ($kriteria=='tglkembali') {
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;Tanggal Kembali</td></tr>";
	$title.= "<tr><td width='20'>Periode</td><td>&nbsp;:&nbsp;$tglAwal s.d. $tglAkhir</td></tr>";
} elseif ($kriteria=='nip') {
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;NIP Pegawai</td></tr>";
	$title.= "<tr><td width='20'>Pegawai</td><td>&nbsp;:&nbsp;$noanggota - $nama</td></tr>";
} elseif ($kriteria=='nis') {
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;NIS Siswa</td></tr>";
	$title.= "<tr><td width='20'>Siswa</td><td>&nbsp;:&nbsp;$noanggota - $nama</td></tr>";
} elseif ($kriteria=='denda') {
	if ($denda==0)
		$besardenda = "Tanpa Denda";
	elseif ($denda==1)
		$besardenda = "Dibawah Rp 5.000";
	elseif ($denda==2)
		$besardenda = "Dibawah Rp 10.000";
	elseif ($denda==3)
		$besardenda = "Diatas Rp 5.000";
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;Denda</td></tr>";
	$title.= "<tr><td width='20'>Besarnya&nbsp;denda</td><td>&nbsp;:&nbsp;$besardenda</td></tr>";
}	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../sty/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JIBAS SimTaka [Cetak Daftar Pengembalian]</title>
</head>

<body>
<table border="0" cellpadding="10" cellspacing="5" width="780" align="left">
<tr><td align="left" valign="top">

<?=GetHeader('alls')?>

<center><font size="4"><strong>DATA PENGEMBALIAN</strong></font><br /> </center><br /><br />

<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana; font-size:12px">
<?=$title?>
</table><br>
		<?
		$sql = "SELECT DATE_FORMAT(now(),'%Y-%m-%d')";
		$result = QueryDb($sql);
		$row = @mysql_fetch_row($result);
		$now = $row[0];
		if ($kriteria=='all')
			$sql = "SELECT * FROM $db_name_perpus.pinjam WHERE status=2 ORDER BY tglpinjam";
		elseif ($kriteria=='tglpinjam')
			$sql = "SELECT *,replid FROM $db_name_perpus.pinjam WHERE status=2 AND tglpinjam BETWEEN '".MySqlDateFormat($tglAwal)."' AND '".MySqlDateFormat($tglAkhir)."' ORDER BY tglpinjam";
		elseif ($kriteria=='tglkembali')
			$sql = "SELECT *,replid FROM $db_name_perpus.pinjam WHERE status=2 AND tglkembali BETWEEN '".MySqlDateFormat($tglAwal)."' AND '".MySqlDateFormat($tglAkhir)."' ORDER BY tglpinjam";
		elseif ($kriteria=='nip' || ($kriteria=='nis'))
			$sql = "SELECT *,replid FROM $db_name_perpus.pinjam WHERE status=2 AND idanggota='$noanggota' AND tglkembali<'".$now."' ORDER BY tglpinjam";
		elseif ($kriteria=='denda'){
			if ($denda==0)
				$sql = "SELECT *,p.replid AS replid FROM $db_name_perpus.pinjam p,$db_name_perpus.denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda='0' ORDER BY p.tglpinjam";
			elseif ($denda==1)
				$sql = "SELECT *,p.replid AS replid FROM $db_name_perpus.pinjam p,$db_name_perpus.denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<5000 ORDER BY p.tglpinjam";
			elseif ($denda==2)
				$sql = "SELECT *,p.replid AS replid FROM $db_name_perpus.pinjam p,$db_name_perpus.denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<10000 ORDER BY p.tglpinjam";
			elseif ($denda==3)
				$sql = "SELECT *,p.replid AS replid FROM $db_name_perpus.pinjam p,$db_name_perpus.denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>10000 ORDER BY p.tglpinjam";			
		}
		$result = QueryDb($sql);
		$num = @mysql_num_rows($result);
		?>
		<link href="../../style/style.css" rel="stylesheet" type="text/css">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="tab" id="table">
          <tr>
            <td height="30" align="center" class="header"> Anggota</td>
            <td height="30" align="center" class="header">Kode Pustaka</td>
            <td height="30" align="center" class="header">Tgl Pinjam</td>
            <td height="30" align="center" class="header">Tgl Kembali</td>
            <td align="center" class="header"> Tanggal Pengembalian</td>
            <? if($kriteria=='denda') { ?>
            <td align="center" class="header">Denda</td>
            <? } ?>
            <td height="30" align="center" class="header">Keterangan</td>
          </tr>
          <?
		  if ($num>0){
			  while ($row=@mysql_fetch_array($result)){
			  $sqlDenda = "SELECT * FROM $db_name_perpus.denda WHERE idpinjam='$row[replid]'";
			  $resultDenda = QueryDb($sqlDenda);
			  $rowDenda = @mysql_fetch_array($resultDenda);
			  $idanggota = $row[idanggota];
				$sql1 = "SELECT nama FROM $db_name_akad.siswa WHERE nis='$idanggota'";
				$result1 = QueryDb($sql1);
				if (@mysql_num_rows($result1)>0){
					$row1 = @mysql_fetch_array($result1);
					$NamaAnggota = $row1[nama];
					//return $sql1;
				} else {
					$sql2 = "SELECT nama FROM $db_name_sdm.pegawai WHERE nip='$idanggota'";
					$result2 = QueryDb($sql2);
					if (@mysql_num_rows($result2)>0){
						$row2 = @mysql_fetch_array($result2);
						$NamaAnggota = $row2[nama];
						//return $sql2;
					} else {
						$sql3 = "SELECT nama FROM $db_name_perpus.anggota WHERE noregistrasi='$idanggota'";
						$result3 = QueryDb($sql3);
						if (@mysql_num_rows($result3)>0){
							$row3 = @mysql_fetch_array($result3);
							//return $sql3;
							$NamaAnggota = $row3[nama];
						} else {
							$NamaAnggota = "Tanpa Nama";
						}
					}
				}
			  ?>
			  <tr style="color:<?=$color?>; <?=$weight?>">
				<td height="25" align="left"><?=$row[idanggota]?> - <?=$NamaAnggota?></td>
				<td height="25" align="center"><?=$row[kodepustaka]?></td>
				<td height="25" align="center"><?=LongDateFormat($row[tglpinjam])?></td>
				<td height="25" align="center"><?=LongDateFormat($row[tglkembali])?></td>
				<td align="center"><?=LongDateFormat($row[tglditerima])?></td>
                <? if ($kriteria=='denda') { ?>
                <td align="center"><div style="padding-right:5px"><?=FormatRupiah($rowDenda[denda])?></div></td>
				<? } ?>
				<td height="25" align="center"><?=$row[keterangan]?></td>
		  </tr>
			  <?
			  }
		  } else {
		  ?>
          <tr>
            <td height="25" colspan="6" align="center" class="nodata">Tidak ada data</td>
          </tr>
		  <?
		  }
		  ?>	
        </table>

</td></tr></table>
</body>
<script language="javascript">
window.print();
</script>
</html>