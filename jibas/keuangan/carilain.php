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
require_once('include/errorhandler.php');
require_once('include/sessionchecker.php');
require_once('include/common.php');
require_once('include/config.php');
require_once('include/db_functions.php');
require_once('include/theme.php');
require_once('include/sessioninfo.php');


$flag = 0;
if (isset($_REQUEST['flag']))
	$flag = (int)$_REQUEST['flag'];
	
$varbaris=10;
if (isset($_REQUEST['varbaris']))
	$varbaris = $_REQUEST['varbaris'];

$page=0;
if (isset($_REQUEST['page']))
	$page = $_REQUEST['page'];
	
$hal=0;
if (isset($_REQUEST['hal']))
	$hal = $_REQUEST['hal'];	
	
$op = $_REQUEST['op'];
if ($op == "12134892y428442323x423") {
	$sql = "DELETE FROM pemohonlain WHERE replid='$_REQUEST[id]'";
	OpenDb();
	QueryDb($sql);
	CloseDb();
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JIBAS KEU [Cari Pemohon Lainnya]</title>
<link rel="stylesheet" type="text/css" href="style/tooltips.css">
<script language="javascript" src="script/tooltips.js"></script>
<script language="javascript" src="script/tables.js"></script>
<script language="javascript" src="script/tools.js"></script>
<script language="javascript">
function refresh() {
	document.location.href = "carilain.php";	
}

function del(id) {
 	if (confirm("Apakah anda yakin akan menghapus data ini?")) 
		document.location.href = "carilain.php?op=12134892y428442323x423&id=" + id;
}

function tambah() {
	newWindow('pemohonlain_add.php', 'TambahPemohon','400','250','resizable=1, scrollbars=1, status=0, toolbar=0')
}
function ubah(id){
	newWindow('pemohonlain_edit.php?id='+id, 'UbahPemohon', '400', '250', 'resizable=1, scrollbars=1, status=0, toolbar=0');
}

function pilih(id, nama) {
	opener.acceptCari(id, nama, <?=$flag?>);
	window.close();
}

function focusNext(elemName, evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode :
        ((evt.which) ? evt.which : evt.keyCode);
    if (charCode == 13) {
		document.getElementById(elemName).focus();
        return false;
    }
    return true;
}

function change_urut(urut,urutan) {			
	var kate = document.getElementById('kategori').value;
	var varbaris=document.getElementById("varbaris").value;
	
	if (urutan =="ASC"){
		urutan="DESC"
	} else {
		urutan="ASC"
	}
	
	document.location.href = "carilain.php?flag=<?=$flag?>&urutan="+urutan+"&urut="+urut+"&page=<?=$page?>&hal=<?=$hal?>&varbaris="+varbaris;

}
</script>
</head>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" background="" style='background-color:#dfdec9'>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr height="58">
	<td width="28" background="<?=GetThemeDir() ?>bgpop_01.jpg">&nbsp;</td>
    <td width="*" background="<?=GetThemeDir() ?>bgpop_02a.jpg">
	<div align="center" style="color:#FFFFFF; font-size:16px; font-weight:bold">
    .: Pemohon Lainnya :.
    </div>
	</td>
    <td width="28" background="<?=GetThemeDir() ?>bgpop_03.jpg">&nbsp;</td>
</tr>
<tr height="150">
	<td width="28" background="<?=GetThemeDir() ?>bgpop_04a.jpg">&nbsp;</td>
    <td width="0" style="background-color:#FFFFFF" height = "500" valign="top">
    <!-- CONTENT GOES HERE //--->
<table border="0" width="100%" align="center">
<!-- TABLE CENTER -->
<tr>	
	<td align="left" valign="top">
	<input type="hidden" name="flag" id="flag" value="<?=$flag ?>" />
	
<?  OpenDb();
	$sql_tot = "SELECT replid AS id, nama, keterangan FROM pemohonlain";
	$result_tot = QueryDb($sql_tot);
	$total = ceil(mysql_num_rows($result_tot)/(int)$varbaris);
	$jumlah = mysql_num_rows($result_tot);
	
	$sql = "SELECT replid AS id, nama, keterangan FROM pemohonlain ORDER BY nama LIMIT ".(int)$page*(int)$varbaris.",$varbaris"; 
	$akhir = ceil($jumlah/5)*5;	
	$result = QueryDb($sql);
	
	if (@mysql_num_rows($result) > 0) {
	
?>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <!-- TABLE LINK -->
    <tr>
      	<td align="right">
        <a href="#" onClick="refresh()"><img src="images/ico/refresh.png" border="0" onMouseOver="showhint('Refresh!', this, event, '50px')"/>&nbsp;Refresh</a>&nbsp;&nbsp; 
        <?  if (getLevel() != 2) { ?> 
        <a href="#" onClick="JavaScript:tambah()"><img src="images/ico/tambah.png" border="0" onMouseOver="showhint('Tambah!', this, event, '50px')">Tambah Data Pemohon</a>&nbsp;
        <?  } ?>
    	</td>
    </tr>
	</table>
    </td>
</tr>
<tr>
	<td>
    <br />
    <table class="tab" id="table" border="1" style="border-collapse:collapse" width="100%" align="left" bordercolor="#000000">
	<!--<table id="table" class="tab" border="0" width="100%" background="images/bttablelong.png" style="border-collapse:collapse" width="100%" align="left" bordercolor="#000000">-->
	<tr height="30" align="center" class="header">
        <td width="7%">No</td>
        <td width="30%">Nama</td>
        <td width="*">Keterangan</td>
        <?  if (getLevel() != 2) { ?>
        <td width="12%">&nbsp;</td>
        <? } ?>
        <td width="6%">&nbsp;</td>
	</tr>
<? 	
	if ($page==0)
		$no = 0;
	else 
		$no = (int)$page*(int)$varbaris;

	while ($row = mysql_fetch_array($result)) { ?>
    <tr >
    	<td align="center"  onClick="pilih('<?=$row[id]?>','<?=$row[nama]?>')" style="cursor:pointer"><?=++$no ?></td>
        <td  onClick="pilih('<?=$row[id]?>','<?=$row[nama]?>')" style="cursor:pointer"><?=$row['nama'] ?></td>
        <td  onClick="pilih('<?=$row[id]?>','<?=$row[nama]?>')" style="cursor:pointer"><?=$row['keterangan'] ?></td>
        <?  if (getLevel() != 2) { ?>
        <td align="center">
        	<a href="#" onclick="ubah('<?=$row['id']?>')" ><img src="images/ico/ubah.png" border="0" onMouseOver="showhint('Ubah Data Pemohon!', this, event, '80px')"></a>&nbsp;
        	<a href="#" onClick="del(<?=$row['id']?>)"><img src="images/ico/hapus.png" border="0" onMouseOver="showhint('Hapus Data Pemohon!', this, event, '80px')"></a>&nbsp;
        </td>
        <? } ?>
        <td>
        <input type="button" class="but" value="Pilih" onclick="pilih(<?=$row['id'] ?>, '<?=$row['nama'] ?>')" />
        </td>
    </tr>
    
<? 	} 
	CloseDb();
?>
	 <!-- END TABLE CONTENT -->
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
    <table border="0"width="100%" align="center" cellpadding="0" cellspacing="0">	
    <tr>
       	<td width="30%" align="left">Hal
        <select name="hal" id="hal" onChange="change_hal()">
        <?	for ($m=0; $m<$total; $m++) {?>
             <option value="<?=$m ?>" <?=IntIsSelected($hal,$m) ?>><?=$m+1 ?></option>
        <? } ?>
     	</select>
	  	dari <?=$total?> hal
		
		<? 
     // Navigasi halaman berikutnya dan sebelumnya
        ?>
        </td>
    	<!--td align="center">
    <input <?=$disback?> type="button" class="but" name="back" value=" << " onClick="change_page('<?=(int)$page-1?>')" onMouseOver="showhint('Sebelumnya', this, event, '75px')">
		<?
		for($a=0;$a<$total;$a++){
			if ($page==$a){
				echo  "<font face='verdana' color='red'><strong>".($a+1)."</strong></font> "; 
			} else { 
				echo  "<a href='#' onClick=\"change_page('".$a."')\">".($a+1)."</a> "; 
			}
				 
	    }
		?>
	     <input <?=$disnext?> type="button" class="but" name="next" value=" >> " onClick="change_page('<?=(int)$page+1?>')" onMouseOver="showhint('Berikutnya', this, event, '75px')">
 		</td-->
        <td width="30%" align="right">Jml baris per hal
      	<select name="varbaris" id="varbaris" onChange="change_baris()">
        <? 	for ($m=5; $m <= $akhir; $m=$m+5) { ?>
        	<option value="<?=$m ?>" <?=IntIsSelected($varbaris,$m) ?>><?=$m ?></option>
        <? 	} ?>
       
      	</select></td>
    </tr>
    </table>
   <?	} else { ?>	
    <table width="100%" border="0" align="center">            
    <tr>
        <td align="center" valign="middle" height="200">    
           	<font size = "2" color ="red"><b>Tidak ditemukan adanya data 
			<? if (getLevel() != 2) { ?>
            <br />Klik &nbsp;<a href="JavaScript:tambah()" ><font size = "2" color ="green">di sini</font></a>&nbsp;untuk mengisi data baru. 
            <? } ?>
            </b></font>
        </td>
    </tr>
    </table>  
<? } ?>   
	</td>
</tr> 
 <tr height="26">
    <td colspan="4" align="center">
    <input type="button" value="Tutup" onclick="window.close()" class="but" />
    </td>
</tr>
</table>
<!-- END OF CONTENT //--->
    </td>
    <td width="28" background="<?=GetThemeDir() ?>bgpop_06a.jpg">&nbsp;</td>
</tr>
<tr height="28">
	<td width="28" background="<?=GetThemeDir() ?>bgpop_07.jpg">&nbsp;</td>
    <td width="*" background="<?=GetThemeDir() ?>bgpop_08a.jpg">&nbsp;</td>
    <td width="28" background="<?=GetThemeDir() ?>bgpop_09.jpg">&nbsp;</td>
</tr>
</table>
</body>
</html>