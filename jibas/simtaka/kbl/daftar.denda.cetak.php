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
require_once('../inc/sessioninfo.php');
require_once('../inc/common.php');
require_once('../inc/config.php');
require_once('../inc/db_functions.php');
require_once('../lib/GetHeaderCetak.php');
require_once('../inc/rupiah.php');
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
$telat=1;
if (isset($_REQUEST[telat]) && $_REQUEST[telat]!="")
	$telat=$_REQUEST[telat];
	
if ($kriteria=='all' || $kriteria==''){
	$title = "<tr><td>Berdasarkan&nbsp;:&nbsp;Semua&nbsp;Penerimaan denda</td></tr>";
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
} elseif ($kriteria=='telat') {
	$title = "<tr><td width='20'>Berdasarkan</td><td>&nbsp;:&nbsp;Keterlambatan</td></tr>";
	$title.= "<tr><td width='20'>Terlambat</td><td>&nbsp;:&nbsp;$telat&nbsp;hari&nbsp;tanggal&nbsp;pengembalian</td></tr>";
}		
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../sty/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JIBAS SimTaka [Cetak Daftar Penerimaan Denda]</title>
</head>

<body>
<table border="0" cellpadding="10" cellpadding="5" width="780" align="left">
<tr><td align="left" valign="top">

<?=GetHeader('alls')?>

<center><font size="4"><strong>DATA PENERIMAAN DENDA</strong></font><br /> </center><br /><br />

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
			$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam ORDER BY p.tglpinjam";
		elseif ($kriteria=='tglpinjam')
			$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.tglpinjam BETWEEN '".MySqlDateFormat($tglAwal)."' AND '".MySqlDateFormat($tglAkhir)."' AND p.replid=d.idpinjam ORDER BY p.tglpinjam";
		elseif ($kriteria=='tglkembali')
			$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.tglkembali BETWEEN '".MySqlDateFormat($tglAwal)."' AND '".MySqlDateFormat($tglAkhir)."' AND p.replid=d.idpinjam ORDER BY p.tglpinjam";
		elseif ($kriteria=='nip' || ($kriteria=='nis'))
			$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.idanggota='$noanggota' AND p.tglkembali<'".$now."' AND p.replid=d.idpinjam ORDER BY p.tglpinjam";
		elseif ($kriteria=='denda'){
			if ($denda==0)
				$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda='0' ORDER BY p.tglpinjam";
			elseif ($denda==1)
				$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<5000 ORDER BY p.tglpinjam";
			elseif ($denda==2)
				$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<10000 ORDER BY p.tglpinjam";
			elseif ($denda==3)
				$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>10000 ORDER BY p.tglpinjam";			
		} elseif ($kriteria=='telat'){
			$sql = "SELECT *,d.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND DATEDIFF(p.tglditerima,p.tglkembali)='$telat' ORDER BY p.tglpinjam";
		}

		$result = QueryDb($sql);
		$num = @mysql_num_rows($result);
		?>
		<link href="../sty/style.css" rel="stylesheet" type="text/css">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="tab" id="table">
          <tr>
            <td height="30" align="center" class="header"> Anggota</td>
            <td height="30" align="center" class="header">Kode Pustaka</td>
            <td height="30" align="center" class="header">Terlambat</td>
            <td height="30" align="center" class="header">Denda</td>
            <td height="30" align="center" class="header">Keterangan</td>
          </tr>
          <?
		  if ($num>0){
			  $totaldenda=0;	
			  while ($row=@mysql_fetch_array($result)){
					$sql = "SELECT pi.idanggota, pi.kodepustaka FROM pustaka p, daftarpustaka d, pinjam pi WHERE d.pustaka=p.replid AND d.kodepustaka=pi.kodepustaka AND pi.replid='$row[idpinjam]'";
					$res = QueryDb($sql);
					$r = @mysql_fetch_row($res);
			  
					$idanggota = $r[0];
					$sql1 = "SELECT nama FROM ".get_db_name('akad').".siswa WHERE nis='$idanggota'";
					$result1 = QueryDb($sql1);
					if (@mysql_num_rows($result1)>0){
						$row1 = @mysql_fetch_array($result1);
						$NamaAnggota = $row1[nama];
						//return $sql1;
					} else {
						$sql2 = "SELECT nama FROM ".get_db_name('sdm').".pegawai WHERE nip='$idanggota'";
						$result2 = QueryDb($sql2);
						if (@mysql_num_rows($result2)>0){
							$row2 = @mysql_fetch_array($result2);
							$NamaAnggota = $row2[nama];
							//return $sql2;
						} else {
							$sql3 = "SELECT nama FROM anggota WHERE noregistrasi='$idanggota'";
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
			  
			  $totaldenda += $row[denda];
			  ?>
			  <tr style="color:<?=$color?>; <?=$weight?>">
				<td height="25" align="left"><?=$r[0]?>-<?=$NamaAnggota?></td>
				<td height="25" align="center"><?=$r[1]?></td>
				<td height="25" align="center"><?=$row[telat]?> hari</td>
				<td height="25" align="right"><div style="padding-right:5px"><?=FormatRupiah($row[denda])?></div></td>
				<td height="25" align="center"><?=$row[keterangan]?></td>
		  </tr>
		  <?
			  }
		  ?>
		  <tr style="color:<?=$color?>; <?=$weight?>">
			    <td height="25" colspan="3" align="right" bgcolor="#CCCCCC">Jumlah&nbsp;&nbsp;</td>
			    <td height="25" align="right" bgcolor="#FFFFFF"><div style="padding-right:5px"><?=FormatRupiah($totaldenda)?></div></td>
		    <td height="25" align="center" bgcolor="#CCCCCC">&nbsp;</td>
	      </tr>
		  <?
		  } else {
		  ?>
          <tr>
            <td height="25" colspan="5" align="center" class="nodata">Tidak ada data</td>
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