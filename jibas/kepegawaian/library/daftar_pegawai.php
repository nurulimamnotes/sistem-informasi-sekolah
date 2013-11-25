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
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('../include/sessioninfo.php');
require_once('departemen.php');

OpenDb();
$flag = 0;
if (isset($_REQUEST['flag']))
	$flag = (int)$_REQUEST['flag'];

$bagian = $_REQUEST['bagian'];	

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

<table border="0" width="100%" cellpadding="2" cellspacing="2" align="center">
<tr>
    <td>
    <input type="hidden" name="flag" id="flag" value="<?=$flag ?>" />
    <input type="hidden" name="urut" id="urut" value="<?=$urut ?>" />
    <input type="hidden" name="urutan" id="urutan" value="<?=$urutan ?>" />
    <!--<font size="2" color="#000000"><strong>Daftar Pegawai</strong></font><br />-->
    </td>
</tr>
<tr>
	<td><font color="#000000"><strong>Bagian  </strong></font>
    <select name="bag" id="bag" onChange="change_bagian('daftar')" onKeyPress="return focusNext('pilih', event)">
    <option value="-1" <? if ($bagian=="-1") echo "selected"; ?>>(Semua Bagian)</option>
	<?  $sql_bagian="SELECT bagian FROM jbssdm.bagianpegawai ORDER BY urutan ASC";
        $result_bagian=QueryDb($sql_bagian);
        while ($row_bagian=@mysql_fetch_array($result_bagian)){
    ?>
      	<option value="<?=$row_bagian['bagian']?>" <?=StringIsSelected($row_bagian['bagian'],$bagian)?>>
      	<?=$row_bagian['bagian']?>
        </option>
      <?	}  ?>
    </select>
    <!--<input type="text" name="bagian" id="bagian" value="<?=$departemen ?>" size="20" readonly style="background-color:#CCCCCC" /> </strong>&nbsp;&nbsp;-->
   </td>
</tr>
<tr>
	<td>
    <?
	if ($bagian == -1)        
        $sql_tambahbag = "";					
    else       
        $sql_tambahbag = "AND bagian = '$bagian' "; 					
    
	OpenDb();
    
    $sql_tot = "SELECT nip, nama, bagian FROM jbssdm.pegawai WHERE aktif = 1 $sql_tambahbag GROUP BY nip ORDER BY nama";
	$result_tot = QueryDb($sql_tot);
	$total = ceil(mysql_num_rows($result_tot)/(int)$varbaris);
	$jumlah = mysql_num_rows($result_tot);
	
	$sql_pegawai = "SELECT nip, nama, bagian FROM jbssdm.pegawai WHERE aktif = 1 $sql_tambahbag GROUP BY nip ORDER BY $urut $urutan LIMIT ".(int)$page*(int)$varbaris.",$varbaris";
	//$sql = "SELECT p.nip, p.nama, p.bagian FROM jbssdm.pegawai p WHERE p.aktif = 1 $sql_tambahbag GROUP BY p.nip ORDER BY p.nama";
   	
	$akhir = ceil($jumlah/5)*5;
    $result = QueryDb($sql_pegawai);
	if (@mysql_num_rows($result)>0){

	?>
    <!--<div id="tab_daftar">-->
    <table width="100%" id="table" class="tab" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#000000">
    <tr height="30" class="header" align="center">
        <td width="7%">No</td>
        <td width="15%" onMouseOver="background='../style/formbg2agreen.gif';height=30;" onMouseOut="background='../style/formbg2.gif';height=30;" background="../style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('nip','<?=$urutan?>','daftar')">N I P <?=change_urut('nip',$urut,$urutan)?></td>
        <td onMouseOver="background='../style/formbg2agreen.gif';height=30;" onMouseOut="background='../style/formbg2.gif';height=30;" background="../style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('nama','<?=$urutan?>','daftar')">Nama <?=change_urut('nama',$urut,$urutan)?></td>
        <? if ($sql_tambahbag == "") { ?>
      	<td width="25%" onMouseOver="background='../style/formbg2agreen.gif';height=30;" onMouseOut="background='../style/formbg2.gif';height=30;" background="../style/formbg2.gif" style="cursor:pointer;" onClick="change_urut('bagian','<?=$urutan?>','daftar')">Bagian <?=change_urut('bagian',$urut,$urutan)?></td>          
        <? } ?>
        <td width="10%">&nbsp;</td>
    </tr>
    <?
    if ($page==0)
		$cnt = 0;
	else 
		$cnt = (int)$page*(int)$varbaris;
		
    while($row = mysql_fetch_row($result)) { 
	?>
    <tr height="25" onClick="pilih('<?=$row[0]?>', '<?=$row[1]?>')" style="cursor:pointer">
        <td align="center"><?=++$cnt ?></td>
        <td align="center"><?=$row[0] ?></td>
        <td><?=$row[1] ?></td>
        <? if ($sql_tambahbag == "") { ?>				
		<td align="center" width="15%"><?=$row[2]?></td> 
        <? } ?>		
        <td align="center">
        <input type="button" name="pilih" class="but" id="pilih" value="Pilih" onClick="pilih('<?=$row[0]?>', '<?=$row[1]?>')" />
        </td>
    </tr>
    <? 	} ?>
    </table>
<?  if ($page==0){ 
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
       	<td width="30%" align="left"><font color="#000000">Hal
        <select name="hal" id="hal" onChange="change_hal('daftar')">
        <?	for ($m=0; $m<$total; $m++) {?>
             <option value="<?=$m ?>" <?=IntIsSelected($hal,$m) ?>><?=$m+1 ?></option>
        <? } ?>
     	</select>
	  	dari <?=$total?> hal
		
		<? 
     	// Navigasi halaman berikutnya dan sebelumnya
        ?>
        </font></td>
    	<!--td align="center">
    	<input <?=$disback?> type="button" class="but" name="back" value=" << " onClick="change_page('<?=(int)$page-1?>','daftar')" >
		<?
		/*for($a=0;$a<$total;$a++){
			if ($page==$a){
				echo "<font face='verdana' color='red'><strong>".($a+1)."</strong></font> "; 
			} else { 
				echo "<a href='#' onClick=\"change_page('".$a."','daftar')\">".($a+1)."</a> "; 
			}
				 
	    }*/
		?>
	     <input <?=$disnext?> type="button" class="but" name="next" value=" >> " onClick="change_page('<?=(int)$page+1?>','daftar')" >
 		</td-->
        <td width="30%" align="right"><font color="#000000">Jml baris per hal
      	<select name="varbaris" id="varbaris" onChange="change_baris('daftar')">
        <? 	for ($m=5; $m <= $akhir; $m=$m+5) { ?>
        	<option value="<?=$m ?>" <?=IntIsSelected($varbaris,$m) ?>><?=$m ?></option>
        <? 	} ?>
       
      	</select></font></td>
    </tr>
    </table>
    
<? } else { ?>    		
	<table width="100%" align="center" cellpadding="2" cellspacing="0" border="0" id="table">
	<tr height="30" align="center">
		<td>
	<br /><br />	
	<font size = "2" color ="red"><b>Tidak ditemukan adanya data. <br /><br />
			Tambah data pegawai pada bagian <?=$bagian?> di menu Kepegawaian pada bagian Referensi. </b></font>	
	<br /><br />
		</td>
	</tr>
	</table>
<? } ?>
    </td>    
</tr>
<tr>
	<td align="center" height="30">
	<!--<input type="button" class="but" name="tutup" id="tutup" value="Tutup" onclick="window.close();opener.document.getElementById('urutan').focus();" style="width:80px;"/>-->
    <input type="button" class="but" name="tutup" id="tutup" value="Tutup" onclick="window.close();opener.tutup();" style="width:80px;"/>
	</td>
</tr>
</table>