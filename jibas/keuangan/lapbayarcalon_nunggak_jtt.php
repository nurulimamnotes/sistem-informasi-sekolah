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
require_once('include/sessionchecker.php');
require_once('include/common.php');
require_once('include/rupiah.php');
require_once('include/config.php');
require_once('include/db_functions.php');
require_once('library/jurnal.php');
require_once('library/repairdatajttcalon.php');

if (isset($_REQUEST['idtahunbuku']))
	$idtahunbuku = (int)$_REQUEST['idtahunbuku'];
	
if (isset($_REQUEST['idpenerimaan']))
	$idpenerimaan = (int)$_REQUEST['idpenerimaan'];
	
if (isset($_REQUEST['kelompok']))
	$kelompok = (int)$_REQUEST['kelompok'];
	
if (isset($_REQUEST['telat']))
	$telat = (int)$_REQUEST['telat'];
	
$tanggal = "";
if (isset($_REQUEST['tanggal']))
	$tanggal = $_REQUEST['tanggal'];
	
$tgl = MySqlDateFormat($tanggal);

$varbaris=10;
if (isset($_REQUEST['varbaris']))
	$varbaris = $_REQUEST['varbaris'];

$page=0;
if (isset($_REQUEST['page']))
	$page = $_REQUEST['page'];
	
$hal=0;
if (isset($_REQUEST['hal']))
	$hal = $_REQUEST['hal'];

$urut = "nama";	
if (isset($_REQUEST['urut']))
	$urut = $_REQUEST['urut'];	

$urutan = "ASC";	
if (isset($_REQUEST['urutan']))
	$urutan = $_REQUEST['urutan'];

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style/tooltips.css">
<title>Untitled Document</title>
<script language="javascript" src="script/tooltips.js"></script>
<script language="javascript" src="script/tables.js"></script>
<script language="javascript" src="script/tools.js"></script>
<script language="javascript">
function refresh() 
{	
	document.location.href = "lapbayarcalon_nunggak_jtt.php?idtahunbuku=<?=$idtahunbuku?>&kelompok=<?=$kelompok ?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal?>";	
}

function cetak() 
{
	var total = document.getElementById("tes").value;
	var addr = "lapbayarcalon_nunggak_jtt_cetak.php?idtahunbuku=<?=$idtahunbuku?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal ?>&kelompok=<?=$kelompok?>&urut=<?=$urut?>&urutan=<?=$urutan?>&varbaris=<?=$varbaris?>&page=<?=$page?>&total="+total;
	newWindow(addr, 'CetakLapPembayaranNunggakJttCalonSiswa','1000','580','resizable=1,scrollbars=1,status=0,toolbar=0');
}

function excel() 
{
	var total = document.getElementById("tes").value;
	var addr = "lapbayarcalon_nunggak_jtt_excel.php?idtahunbuku=<?=$idtahunbuku?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal ?>&kelompok=<?=$kelompok?>&urut=<?=$urut?>&urutan=<?=$urutan?>&varbaris=<?=$varbaris?>&page=<?=$page?>&total="+total;
	newWindow(addr, 'ExcelLapPembayaranNunggakJttCalonSiswa','1000','580','resizable=1,scrollbars=1,status=0,toolbar=0');
}

function change_urut(urut,urutan) 
{	
	var varbaris=document.getElementById("varbaris").value;
		
	if (urutan =="ASC")
	{
		urutan="DESC"
	} 
	else 
	{
		urutan="ASC"
	}
	
	document.location.href = "lapbayarcalon_nunggak_jtt.php?idtahunbuku=<?=$idtahunbuku?>&kelompok=<?=$kelompok ?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal?>&urut="+urut+"&urutan="+urutan+"&page=<?=$page?>&hal=<?=$hal?>&varbaris="+varbaris;
}

function change_page(page) 
{
	var varbaris=document.getElementById("varbaris").value;
	
	document.location.href="lapbayarcalon_nunggak_jtt.php?idtahunbuku=<?=$idtahunbuku?>&kelompok=<?=$kelompok ?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal?>&page="+page+"&hal="+page+"&urut=<?=$urut?>&urutan=<?=$urutan?>&varbaris="+varbaris;
}

function change_hal() 
{
	var hal = document.getElementById("hal").value;
	var varbaris=document.getElementById("varbaris").value;
	
	document.location.href="lapbayarcalon_nunggak_jtt.php?idtahunbuku=<?=$idtahunbuku?>&kelompok=<?=$kelompok ?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal?>&urut=<?=$urut?>&urutan=<?=$urutan?>&varbaris="+varbaris+"&page="+hal+"&hal="+hal;
}

function change_baris() 
{
	var varbaris=document.getElementById("varbaris").value;
	
	document.location.href="lapbayarcalon_nunggak_jtt.php?idtahunbuku=<?=$idtahunbuku?>&kelompok=<?=$kelompok ?>&idpenerimaan=<?=$idpenerimaan ?>&telat=<?=$telat ?>&tanggal=<?=$tanggal?>&urut=<?=$urut?>&urutan=<?=$urutan?>&varbaris="+varbaris;
}
</script>
</head>

<body topmargin="0" leftmargin="0">
<?
OpenDb();
if ($kelompok == -1) 
{
	$sql = "SELECT idbesarjttcalon, datediff('$tgl', max(tanggal)) as x 
	          FROM penerimaanjttcalon p , besarjttcalon b, jbsakad.calonsiswa c, jbsakad.prosespenerimaansiswa r 
			   WHERE p.idbesarjttcalon = b.replid AND b.lunas = 0 AND b.idpenerimaan = '$idpenerimaan' AND b.info2='$idtahunbuku'
				  AND c.replid = b.idcalon AND c.idproses = r.replid AND r.aktif = 1 
		   GROUP BY idbesarjttcalon 
		     HAVING x >= $telat";
			  /*UNION SELECT b.replid, '-' FROM besarjttcalon b, jbsakad.calonsiswa c, jbsakad.prosespenerimaansiswa r WHERE b.replid NOT IN (SELECT idbesarjttcalon FROM penerimaanjttcalon p) AND b.lunas = 0 AND c.replid = b.idcalon AND b.idpenerimaan = $idpenerimaan AND c.idproses = r.replid AND r.aktif = 1";	*/
} 
else 
{
	$sql = "SELECT idbesarjttcalon, datediff('$tgl', max(tanggal)) as x 
	          FROM penerimaanjttcalon p , besarjttcalon b, jbsakad.calonsiswa c 
				WHERE p.idbesarjttcalon = b.replid AND b.lunas = 0 AND b.info2='$idtahunbuku' AND c.replid = b.idcalon 
				  AND c.idkelompok = '$kelompok' AND b.idpenerimaan = '$idpenerimaan' 
		   GROUP BY idbesarjttcalon 
			  HAVING x >= $telat";
			  /*UNION SELECT b.replid, '-' FROM besarjttcalon b, jbsakad.calonsiswa c, jbsakad.prosespenerimaansiswa r WHERE b.replid NOT IN (SELECT idbesarjttcalon FROM penerimaanjttcalon p) AND b.lunas = 0 AND c.replid = b.idcalon AND b.idpenerimaan = $idpenerimaan AND c.idkelompok = $kelompok";	*/
} 	
//echo  $sql;
$result = QueryDb($sql);
$idstr = "";
while($row = mysql_fetch_row($result)) {
	if (strlen($idstr) > 0)
		$idstr = $idstr . ",";
	$idstr = $idstr . $row[0];
}

//Dapatkan namapenerimaan
$sql = "SELECT nama FROM datapenerimaan WHERE replid='$idpenerimaan'";
$result = QueryDb($sql);
$row = mysql_fetch_row($result);
$namapenerimaan = $row[0];
?>

<table border="0" width="100%" align="center" background="" style="background-repeat:no-repeat; background-attachment:fixed">
<!-- TABLE CENTER -->
<tr>
	<td>
<? if (strlen($idstr) > 0) { 
	$sql = "SELECT MAX(jumlah) FROM (SELECT idbesarjttcalon, count(replid) AS jumlah FROM penerimaanjttcalon WHERE idbesarjttcalon IN ($idstr) GROUP BY idbesarjttcalon) AS X";
	//echo  "$sql<br>";
	$result = QueryDb($sql);
	$row = mysql_fetch_row($result);
	$max_n_cicilan = $row[0];
	$table_width = 810 + $max_n_cicilan * 90;

?>
	<table width="100%" border="0" align="center">
    <tr>
    	<td valign="bottom">
    <a href="#" onClick="refresh()"><img src="images/ico/refresh.png" border="0" onMouseOver="showhint('Refresh!', this, event, '50px')"/>&nbsp;Refresh</a>&nbsp;
    <a href="JavaScript:cetak()"><img src="images/ico/print.png" border="0" onMouseOver="showhint('Cetak!', this, event, '50px')"/>&nbsp;Cetak</a>&nbsp;
    <a href="JavaScript:excel()"><img src="images/ico/excel.png" border="0" onMouseOver="showhint('Buka di Ms Excel!', this, event, '50px')"/>&nbsp;Excel</a>&nbsp;
    	</td>
	</tr>
	</table>
	<br />
	<table class="tab" id="table" border="1" cellpadding="5" style="border-collapse:collapse" cellspacing="0" width="<?=$table_width ?>" align="left" bordercolor="#000000">
    <tr height="30" align="center" class="header">
        <td width="30">No</td>
        <td width="80" onMouseOver="background='style/formbg2agreen.gif';height=30;" onMouseOut="background='style/formbg2.gif';height=30;" background="style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('nopendaftaran','<?=$urutan?>')">No. Reg <?=change_urut('nopendaftaran',$urut,$urutan)?></td>
        <td width="140" onMouseOver="background='style/formbg2agreen.gif';height=30;" onMouseOut="background='style/formbg2.gif';height=30;" background="style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('nama','<?=$urutan?>')">Nama <?=change_urut('nama',$urut,$urutan)?></td>
        <td width="75" onMouseOver="background='style/formbg2agreen.gif';height=30;" onMouseOut="background='style/formbg2.gif';height=30;" background="style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('kelompok','<?=$urutan?>')">Kel <?=change_urut('kelompok',$urut,$urutan)?></td>
        <? 	for($i = 0; $i < $max_n_cicilan; $i++) { 
                $n = $i + 1; ?>
                <td class="header" width="120" align="center"><?="Bayaran-$n" ?></td>	
        <?  } ?>
        <td width="80">Telat<br /><em>(hari)</em></td>
        <td width="125" onMouseOver="background='style/formbg2agreen.gif';height=30;" onMouseOut="background='style/formbg2.gif';height=30;" background="style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('besar','<?=$urutan?>')"><?=$namapenerimaan ?> <?=change_urut('besar',$urut,$urutan)?></td>
        <td width="125">Total Pembayaran</td>
        <td width="125">Total Tunggakan</td>
        <td width="200">Keterangan</td>
    </tr>
<?
$sql_tot = "SELECT c.nopendaftaran, c.nama, k.kelompok, b.replid AS id, b.besar, b.keterangan, b.lunas 
              FROM jbsakad.calonsiswa c, jbsakad.kelompokcalonsiswa k, besarjttcalon b 
				 WHERE c.replid = b.idcalon AND c.idkelompok = k.replid AND b.replid IN ($idstr) ORDER BY c.nama";

$sql = "SELECT c.nopendaftaran, c.nama, k.kelompok, b.replid AS id, b.besar, b.keterangan, b.lunas 
          FROM jbsakad.calonsiswa c, jbsakad.kelompokcalonsiswa k, besarjttcalon b 
			WHERE c.replid = b.idcalon AND c.idkelompok = k.replid AND b.replid IN ($idstr) 
		ORDER BY $urut $urutan LIMIT ".(int)$page*(int)$varbaris.",$varbaris"; 

$result_tot = QueryDb($sql_tot);
$total=ceil(mysql_num_rows($result_tot)/(int)$varbaris);
$jumlah = mysql_num_rows($result_tot);
$akhir = ceil($jumlah/5)*5;

$result = QueryDb($sql);
if ($page==0)
	$cnt = 0;
else 
	$cnt = (int)$page*(int)$varbaris;

$totalbiayaall = 0;
$totalbayarall = 0;

$totalbayarallB = 0;
$besarjttallA = 0;
$x = 1;
while ($rowA = @mysql_fetch_array($result_tot)) {
	$besarjttA = 0;
	$idbesarjttA = $rowA['id'];
	$besarjttA = $rowA['besar'];
	$sqlB = "SELECT jumlah FROM penerimaanjttcalon WHERE idbesarjttcalon = '$idbesarjttA' ";
	$resultB = QueryDb($sqlB);
	$totalbayarB = 0;
	while ($rowB = @mysql_fetch_row($resultB)) {
		$totalbayarB = $totalbayarB + $rowB[0]; 	
	}
 	$totalbayarallB += $totalbayarB;
	$besarjttallA += $besarjttA;
}

while ($row = mysql_fetch_array($result)) {
	$idbesarjtt = $row['id'];
	$besarjtt = $row['besar'];
	$ketjtt = $row['keterangan'];
	$totalbiayaall += $besarjtt;
		
?>
    <tr height="40">
        <td align="center"><?=++$cnt ?></td>
        <td align="center"><?=$row['nopendaftaran'] ?></td>
        <td><?=$row['nama'] ?></td>
        <td align="center"><?=$row['kelompok'] ?></td>
    <?
	$sql = "SELECT count(*) FROM penerimaanjttcalon WHERE idbesarjttcalon = '$idbesarjtt'";
	$result2 = QueryDb($sql);
	$row2 = mysql_fetch_row($result2);
	$nbayar = $row2[0];
	$nblank = $max_n_cicilan - $nbayar;
	$totalbayar = 0;
	
	if ($nbayar > 0) {
		$sql = "SELECT date_format(tanggal, '%d-%b-%y'), jumlah FROM penerimaanjttcalon WHERE idbesarjttcalon = '$idbesarjtt' ORDER BY tanggal";
		$result2 = QueryDb($sql);
		while ($row2 = mysql_fetch_row($result2)) {
			$totalbayar = $totalbayar + $row2[1]; ?>
            <td>
                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse" bordercolor="#000000">
                <tr height="20"><td align="center"><?=FormatRupiah($row2[1]) ?></td></tr>
                <tr height="20"><td align="center"><?=$row2[0] ?></td></tr>
                </table>
            </td>
 <?		}
 		$totalbayarall += $totalbayar;
	}	
	for ($i = 0; $i < $nblank; $i++) { ?>
	    <td>
            <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse" bordercolor="#000000">
            <tr height="20"><td align="center">&nbsp;</td></tr>
            <tr height="20"><td align="center">&nbsp;</td></tr>
            </table>
        </td>
    <? }?>
    	<td align="center">
	<?	
	$sql = "SELECT max(datediff('$tgl', tanggal)) FROM penerimaanjttcalon WHERE idbesarjttcalon = '$idbesarjtt'";
	$result2 = QueryDb($sql);
	$num2 = mysql_num_rows($result2);
	$row2 = mysql_fetch_row($result2);
	if ($num2>0)
		echo  $row2[0]; 
	else 
		echo  $telat;
	?>
        </td>
        <td align="right"><?=FormatRupiah($besarjtt) ?></td>
        <td align="right"><?=FormatRupiah($totalbayar) ?></td>
        <td align="right"><?=FormatRupiah($besarjtt - $totalbayar) ?></td>
        <td><?=$ketjtt ?></td>
    </tr>
<?
}
?>
     <input type="hidden" name="tes" id="tes" value="<?=$total?>"/>
    <? if ($page==$total-1){ ?>
	<tr height="40">
        <td align="center" colspan="<?=5 + $max_n_cicilan ?>" bgcolor="#999900"><font color="#FFFFFF"><strong>T O T A L</strong></font></td>
        <td align="right" bgcolor="#999900"><font color="#FFFFFF"><strong><?=FormatRupiah($besarjttallA) ?></strong></font></td>
        <td align="right" bgcolor="#999900"><font color="#FFFFFF"><strong><?=FormatRupiah($totalbayarallB) ?></strong></font></td>
        <td align="right" bgcolor="#999900"><font color="#FFFFFF"><strong><?=FormatRupiah($besarjttallA - $totalbayarallB) ?></strong></font></td>
        <td bgcolor="#999900">&nbsp;</td>
    </tr>
	<? } ?>
    </table>
    <script language='JavaScript'>
        Tables('table', 1, 0);
    </script>
     <?	if ($page==0){ 
		$disback="style='visibility:hidden;'";
		$disnext="style='visibility:visible;'";
		}
		if ($page<$total && $page>0){
		$disback="style='visibility:visible;'";
		$disnext="style='visibility:visible;'";
		}
		if ($page==$total-1 && $page>0){
		$disback="style='visibility:visible;'";
		$disnext="style='visibility:hidden;'";
		}
		if ($page==$total-1 && $page==0){
		$disback="style='visibility:hidden;'";
		$disnext="style='visibility:hidden;'";
		}
	?>
    </td>
</tr> 
<tr>
    <td>
    <table border="0"width="100%" align="center"cellpadding="0" cellspacing="0">	
    <tr>
       	<td width="30%" align="left">Halaman
        <select name="hal" id="hal" onChange="change_hal()">
        <?	for ($m=0; $m<$total; $m++) {?>
             <option value="<?=$m ?>" <?=IntIsSelected($hal,$m) ?>><?=$m+1 ?></option>
        <? } ?>
     	</select>
	  	dari <?=$total?> halaman
		
		<? 
     // Navigasi halaman berikutnya dan sebelumnya
        ?>
        </td>
    	<td align="center">
    <!--input <?=$disback?> type="button" class="but" name="back" value=" << " onClick="change_page('<?=(int)$page-1?>')" onMouseOver="showhint('Sebelumnya', this, event, '75px')">
		<?
		for($a=0;$a<$total;$a++){
			if ($page==$a){
				echo  "<font face='verdana' color='red'><strong>".($a+1)."</strong></font> "; 
			} else { 
				echo  "<a href='#' onClick=\"change_page('".$a."')\">".($a+1)."</a> "; 
			}
				 
	    }
		?>
	     <input <?=$disnext?> type="button" class="but" name="next" value=" >> " onClick="change_page('<?=(int)$page+1?>')" onMouseOver="showhint('Berikutnya', this, event, '75px')"-->
 		</td>
        <td width="30%" align="right">Jumlah baris per halaman
      	<select name="varbaris" id="varbaris" onChange="change_baris()">
        <? 	for ($m=5; $m <= $akhir; $m=$m+5) { ?>
        	<option value="<?=$m ?>" <?=IntIsSelected($varbaris,$m) ?>><?=$m ?></option>
        <? 	} ?>
       
      	</select></td>
    </tr>
    </table>
<? } else { ?>
    <table width="100%" border="0" align="center">          
    <tr>
        <td align="center" valign="middle" height="250">
            <font size = "2" color ="red"><b>Tidak ditemukan adanya calon siswa yang menunggak pembayaran.
            </font>
        </td>
    </tr>
    </table>  
<? } ?>
    </td>
</tr>
</table>
<? CloseDb() ?>

</body>
</html>