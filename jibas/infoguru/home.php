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
require_once('include/sessioninfo.php');
require_once('include/config.php');
require_once('include/db_functions.php');
require_once("include/sessionchecker.php");

if (SI_USER_ID()!="LANDLORD" && SI_USER_ID()!="landlord"){
$x=date('G');
if ($x>=00 && $x<10)
	$salam = "Pagi";
if ($x>=10 && $x<15)
	$salam = "Siang";
if ($x>=15 && $x<18)
	$salam = "Sore";
if ($x>=18 && $x<=23)
	$salam = "Malam";

OpenDb();
$sql1="SELECT YEAR(tanggal) as thn,MONTH(tanggal) as bln,DAY(tanggal) as tgl,replid,judul,abstrak FROM jbsvcr.beritaguru ORDER BY replid DESC LIMIT 0,".$VAR_BERITA_GURU;
$result1=QueryDb($sql1);
//$row1=@mysql_fetch_array($result1);
$namabulan = array("Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","Nopember","Desember");	
$tglberita=$row1['tgl']." ".$namabulan[$row1['bln']-1]." ".$row1['thn'];
$sql2="SELECT * FROM jbsvcr.tujuanpesan t, jbsvcr.pesan p WHERE t.idpenerima='".SI_USER_ID()."' AND t.baru=1 AND t.idpesan=p.replid ORDER BY t.replid DESC";
//echo $sql2;
$result2=QueryDb($sql2);
$row2=@mysql_fetch_array($result2);
if (@mysql_num_rows($result2)>0){
$pesanbaru = "Ada <font color=\"red\">".@mysql_num_rows($result2)."</font> pesan baru yang belum dibaca !";
			 //"<br>Masuk ke Kotak Masuk";
} else {
$pesanbaru = "Tidak ada pesan baru !";
}
$sql_bs="SELECT YEAR(tanggal) as thn,MONTH(tanggal) as bln,DAY(tanggal) as tgl,replid,judul,abstrak FROM jbsvcr.beritasiswa ORDER BY replid DESC LIMIT 0,".$VAR_BERITA_SISWA;
$result_bs=QueryDb($sql_bs);



$sqlcatatan="SELECT * FROM jbsvcr.catatansiswa c, jbsakad.siswa s WHERE c.nis=s.nis ORDER BY tanggal DESC LIMIT 0,".$VAR_CATATAN_SISWA;
$result_cttan=QueryDb($sqlcatatan);

}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="script/tools.js"></script>
<style type="text/css">
<!--
.style1 {color: #666666}
.style3 {
	font-size: 14px;
	font-weight: bold;
}
.style4 {
	color: #333333;
	font-style: italic;
}
-->
</style>
<script language="javascript">
function bacaberita(replid){
	//parent.frametop.buletin();
	//document.location.href="bacaberitaguru.php?replid="+replid;
	newWindow('buletin/beritaguru/bacaberitaguru.php?replid='+replid,'BacaBeritanyaGuru',738,525,'scrollbars=1');
	
}
function bacaberitasiswa(replid){
	//parent.frametop.buletin();
	//document.location.href="buletin/beritasiswa/bacaberitasiswa.php?replid="+replid;
	newWindow('buletin/beritasiswa/bacaberitasiswa.php?replid='+replid,'BacaBeritanyaSiswa',738,525,'scrollbars=1');
	
}
function autoload(){
	//parent.frametop.buletin();
	setTimeout("get_fresh();", 180000);
	//document.location.href="buletin/beritasiswa/bacaberitasiswa.php?replid="+replid;
}
function get_fresh(){
	document.location.href="home.php";
}
</script>
</head>
<body onload="autoload();" style="background-color:#FFFFFF;">
<?
if (SI_USER_ID()!="LANDLORD" && SI_USER_ID()!="landlord"){
?>
<div>
<div align="right">
	<font color="#666666">Selamat <?=$salam?>, <?=SI_USER_NAME()?><br /></font>
</div>
</div>
<table width="100%" border="0" cellspacing="5" >
  <tr>
    <td width="46%" valign="top" scope="row">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td><div align="left" style="padding-bottom:10px"> <span style="background-color:#FF9900;color:#FF9900; font-size:18px">&nbsp;</span>&nbsp;<span style="color:#999999; font-size:14px; font-weight:bold">Pesan  Baru</span> </div>
              <div align="left"> <span style="color:#999999">
                <?=$pesanbaru?>
                </span>
                  <div align="left" style="padding-top:5px"><img src="images/ico/arr1.gif" />&nbsp;&nbsp;<a href="buletin/pesan/pesan.php" target="framecenter" class="style4" onclick="parent.frametop.buletin();">Masuk ke Kotak Pesan</a></div>
              </div></td>
      </tr>
      <tr>
        <td style="padding-top:20px">
        <div align="left" style="padding-bottom:10px"> <span style="background-color:#FF9900;color:#FF9900; font-size:18px">&nbsp;</span>&nbsp;<span style="color:#999999; font-size:14px; font-weight:bold">Berita Guru Terbaru</span> </div>
              <div align="left">
                <table cellspacing="1" cellpadding="1">
                  <?
                      while ($row1=@mysql_fetch_array($result1)){
                      $tglberita=$row1['tgl']." ".$namabulan[$row1['bln']-1]." ".$row1['thn'];
                      ?>
                  <tr>
                    <td><span class="style1"> <em>
                      <?=$tglberita?>
                      </em> <br />
                      <font color="#3C859C" size="-2">
                        <?=$row1[judul]?>
                    </font>
                      <?=$row1[abstrak]?>
                      </span>
                        <div align="right"><img src="images/ico/arr1.gif" />&nbsp;&nbsp;<a href="#" class="style4" onclick="bacaberita('<?=$row1[replid]?>')" >Baca Selengkapnya</a></div></td>
                  </tr>
                  <tr>
                    <td style="background-image:url(images/box_hr1.gif); background-repeat:repeat-x">&nbsp;</td>
                  </tr>
                  <? } ?>
                </table>
              </div></td>
      </tr>
    </table>
    </td>
    <td valign="top">
    <table>
    <tr>
        <td ><div align="left" style="padding-bottom:10px"> <span style="background-color:#FF9900;color:#FF9900; font-size:18px">&nbsp;</span>&nbsp;<span style="color:#999999; font-size:14px; font-weight:bold">
          <?=$VAR_CATATAN_SISWA?>
          Catatan Siswa Terbaru</span> </div>
              <div align="left">
                <table cellspacing="1" cellpadding="1">
                  <?
                      while ($row_cttan=@mysql_fetch_array($result_cttan)){
                      ?>
                  <tr>
                    <td><span class="style1"> <em>
                      <?=ShortDateFormat($row_cttan[tanggal])?>
                      </em> <br />
                      <font color="#022cfe" size="-2"><?=$row_cttan[nis]?> - <?=$row_cttan[nama]?>
                    </font><br />
                      <font color="#3C859C" size="-2">
                        <?=$row_cttan[judul]?>
                    </font>
                      <?=$row_cttan[catatan]?>
                    </span> </td>
                  </tr>
                  <tr>
                    <td style="background-image:url(images/box_hr1.gif); background-repeat:repeat-x">&nbsp;</td>
                  </tr>
                  <?
                      } ?>
                </table>
              </div></td>
      </tr>
      <tr>
        <td style="padding-top:20px"><div align="left" style="padding-bottom:10px"> <span style="background-color:#FF9900;color:#FF9900; font-size:18px">&nbsp;</span>&nbsp;<span style="color:#999999; font-size:14px; font-weight:bold">Berita Siswa Terbaru</span> </div>
              <div align="left">
                <table cellpadding="1" cellspacing="1" width="100%">
                  <?
                      while ($row_bs=@mysql_fetch_array($result_bs)){
                      $tglberita_bs=$row_bs['tgl']." ".$namabulan[$row_bs['bln']-1]." ".$row_bs['thn'];
                      ?>
                  <tr>
                    <td><span class="style1"> <em>
                      <?=$tglberita_bs?>
                      </em> <br />
                      <font color="#3C859C" size="-2">
                        <?=$row_bs[judul]?>
                    </font>
                      <?=$row_bs[abstrak]?>
                      </span>
                        <div align="right"><img src="images/ico/arr1.gif" />&nbsp;&nbsp;<a href="#" class="style4" onclick="bacaberitasiswa('<?=$row_bs[replid]?>')" >Baca Selengkapnya</a></div></td>
                  </tr>
                  <tr>
                    <td style="background-image:url(images/box_hr1.gif); background-repeat:repeat-x">&nbsp;</td>
                  </tr>
                  <? } ?>
                </table>
              </div></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
<? } ?>
</body>
</html>