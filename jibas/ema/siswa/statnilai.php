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
require_once('../inc/sessionchecker.php');
require_once('../inc/config.php');
require_once('../inc/getheader.php');
require_once('../inc/common.php');
require_once('../inc/db_functions.php');
require_once('../lib/dpupdate.php');

OpenDb();
$departemen = "";
if (isset($_REQUEST[departemen]))
	$departemen = $_REQUEST[departemen];
$tahunajaran = 0;
if (isset($_REQUEST[tahunajaran]))
	$tahunajaran = $_REQUEST[tahunajaran];
$tingkat = 0;
if (isset($_REQUEST[tingkat]))
	$tingkat = $_REQUEST[tingkat];
$semester = 0;
if (isset($_REQUEST[semester]))
	$semester = $_REQUEST[semester];
$pelajaran = 0;
if (isset($_REQUEST[pelajaran]))
	$pelajaran = $_REQUEST[pelajaran];
$dasarpenilaian = "";
if (isset($_REQUEST[dasarpenilaian]))
	$dasarpenilaian = $_REQUEST[dasarpenilaian];					
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../script/ajax.js"></script>
<script language="javascript" src="../script/tools.js"></script>
<script language="javascript">
function chg_dep(){
	var d = document.getElementById('departemen').value;
	document.location.href = 'statnilai.php?departemen='+d;
}
function chg(){
	var d = document.getElementById('departemen').value;
	var ta = document.getElementById('tahunajaran').value;
	var t = document.getElementById('tingkat').value;
	var s = document.getElementById('semester').value;
	var p = document.getElementById('pelajaran').value;
	var dp = document.getElementById('dasarpenilaian').value;
	document.location.href = 'statnilai.php?departemen='+d+'&tahunajaran='+ta+'&tingkat='+t+'&semester='+s+'&pelajaran='+p+'&dasarpenilaian='+dp;
}
function viewdetail(rentang,i){
	var d = document.getElementById('departemen').value;
	var ta = document.getElementById('tahunajaran').value;
	var t = document.getElementById('tingkat').value;
	var s = document.getElementById('semester').value;
	var p = document.getElementById('pelajaran').value;
	var dp = document.getElementById('dasarpenilaian').value;
	show_wait('statdetail');
	sendRequestText('get_stat_detail_nilai.php',showDetail,'departemen='+d+'&tahunajaran='+ta+'&tingkat='+t+'&semester='+s+'&pelajaran='+p+'&dasarpenilaian='+dp+'&rentang='+rentang+'&i='+i);
}
function show_wait(areaId) {
	var x = document.getElementById("waitBox").innerHTML;
	document.getElementById(areaId).innerHTML = x;
}

function showDetail(x){
	document.getElementById('statdetail').innerHTML = x;
}
function lihat_siswa(replid) {
	//var replid = document.getElementById('replid').value;
	newWindow('../lib/detail_siswa.php?replid='+replid, 'CetakDetailSiswa','800','650','resizable=1,scrollbars=1,status=0,toolbar=0')
	//newWindow('cetak_detail_siswa.php?replid='+replid, 'CetakDetailSiswa','790','650','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function cetak(){
	var d = document.getElementById('departemen').value;
	var ta = document.getElementById('tahunajaran').value;
	var t = document.getElementById('tingkat').value;
	var s = document.getElementById('semester').value;
	var p = document.getElementById('pelajaran').value;
	var dp = document.getElementById('dasarpenilaian').value;
	var addr = "statnilai_cetak.php?departemen="+d+"&tahunajaran="+ta+"&tingkat="+t+"&semester="+s+"&pelajaran="+p+"&dasarpenilaian="+dp;
	newWindow(addr, 'CetakStatistikNilai','800','650','resizable=1,scrollbars=1,status=0,toolbar=0');
}
</script>
</head>
<body>
<div id="waitBox" style="position:absolute; visibility:hidden;">
	<img src="../img/loading2.gif" border="0" />&nbsp;<span class="tab2">Please&nbsp;wait...</span>
</div>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td width="6%" class="news_content1">Departemen</td>
    <td width="7%">
    <select name="departemen" class="cmbfrm" id="departemen" onchange="chg_dep()">
	<?
	$sql = "SELECT departemen FROM departemen WHERE aktif=1 ORDER BY urutan";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($departemen == "")
		$departemen = $row[0];
	?>
    	<option value="<?=$row[0]?>" <?=StringIsSelected($departemen,$row[0])?> ><?=$row[0]?></option>
    <?
	}
	?>
    </select>    </td>
    <td width="6%"><span class="news_content1">Tahunajaran</span></td>
    <td width="7%"><select name="tahunajaran" class="cmbfrm" id="tahunajaran" onchange="chg()">
      <?
	$sql = "SELECT replid,tahunajaran FROM tahunajaran WHERE aktif=1 AND departemen='$departemen' ORDER BY tahunajaran";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($tahunajaran == "")
		$tahunajaran = $row[0];
	?>
      <option value="<?=$row[0]?>" <?=StringIsSelected($tahunajaran,$row[0])?> >
      <?=$row[1]?>
      </option>
      <?
	}
	?>
    </select></td>
    <td width="4%" class="news_content1">Pelajaran</td>
    <td width="70%"><select name="pelajaran" class="cmbfrm" id="pelajaran" onchange="chg()">
      <?
	$sql = "SELECT replid,nama FROM pelajaran WHERE aktif=1 AND departemen='$departemen' ORDER BY nama";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($pelajaran == "")
		$pelajaran = $row[0];
	?>
      <option value="<?=$row[0]?>" <?=StringIsSelected($pelajaran,$row[0])?> >
        <?=$row[1]?>
        </option>
      <?
	}
	?>
    </select></td>
  </tr>
  <tr>
    <td class="news_content1">Tingkat</td>
    <td><select name="tingkat" class="cmbfrm" id="tingkat" onchange="chg()">
      <?
	$sql = "SELECT replid,tingkat FROM tingkat WHERE aktif=1 AND departemen='$departemen' ORDER BY tingkat";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($tingkat == "")
		$tingkat = $row[0];
	?>
      <option value="<?=$row[0]?>" <?=StringIsSelected($tingkat,$row[0])?> >
        <?=$row[1]?>
        </option>
      <?
	}
	?>
    </select></td>
    <td><span class="news_content1">Semester</span></td>
    <td><select name="semester" class="cmbfrm" id="semester" onchange="chg()">
      <?
	$sql = "SELECT replid,semester FROM semester WHERE aktif=1 AND departemen='$departemen' ORDER BY semester";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($semester == "")
		$semester = $row[0];
	?>
      <option value="<?=$row[0]?>" <?=StringIsSelected($semester,$row[0])?> >
        <?=$row[1]?>
        </option>
      <?
	}
	?>
    </select></td>
    <td class="news_content1">Nilai</td>
    <td><select name="dasarpenilaian" class="cmbfrm" id="dasarpenilaian" onchange="chg()">
      <?
	$sql = "SELECT dasarpenilaian,keterangan FROM dasarpenilaian ORDER BY keterangan";
	$result = QueryDb($sql);
	while ($row = @mysql_fetch_row($result)){
	if ($dasarpenilaian == "")
		$dasarpenilaian = $row[0];
	?>
      <option value="<?=$row[0]?>" <?=StringIsSelected($dasarpenilaian,$row[0])?> >
        <?=$row[1]?>
        </option>
      <?
	}
	?>
    </select></td>
  </tr>
  <tr>
    <td colspan="6" align="center"><a href="javascript:cetak()"><img src="../img/print.png" width="16" height="16" border="0" />&nbsp;Cetak</a></td>
  </tr>
  <tr>
    <td colspan="6" align="center"><img src="<?="statimagenilai.php?departemen=$departemen&tahunajaran=$tahunajaran&tingkat=$tingkat&semester=$semester&pelajaran=$pelajaran&dasarpenilaian=$dasarpenilaian" ?>" />    </td>
  </tr>
  <tr>
    <td colspan="6">
    	<table width="100%" border="0" cellspacing="2" cellpadding="2">
          <tr>
            <td width="34%" valign="top">
					<?
                    $sql	=	"SELECT MIN(nilaiangka) as nmin, MAX(nilaiangka) AS nmax ".
                                "FROM nap n, aturannhb a, infonap i, kelas k ".
                                "WHERE n.idaturan = a.replid ".
                                "AND a.idtingkat = '$tingkat' ".
                                "AND a.idpelajaran = '$pelajaran' ".
                                "AND a.dasarpenilaian = '$dasarpenilaian' ".
                                "AND n.idinfo = i.replid ".
                                "AND i.idpelajaran = '$pelajaran' ".
                                "AND i.idsemester = '$semester' ".
                                "AND i.idkelas = k.replid ".
                                "AND k.idtahunajaran = '$tahunajaran' ".
                                "AND k.idtingkat = '$tingkat' ";	
                    //echo $sql;
                    $result=Querydb($sql);
                    $row = @mysql_fetch_array($result);
                    
                    if(($row[nmin] >= 0) AND ($row[nmax] <= 10)){
                        $dasar = '1'; //satuan
                    }else{
                        $dasar = '10'; //satuan
                    }
                    
                    $rentang = array(9*$dasar,8*$dasar,7*$dasar,6*$dasar,5*$dasar,4*$dasar,3*$dasar,2*$dasar,1*$dasar);
                    $filter = array($rentang[0],$rentang[1].'_'.$rentang[0],$rentang[2].'_'.$rentang[1],$rentang[3].'_'.$rentang[2],$rentang[4].'_'.$rentang[3],$rentang[5].'_'.$rentang[4],$rentang[6].'_'.$rentang[5],$rentang[7].'_'.$rentang[6],$rentang[8]);
					//print_r($filter);
					$query = "SELECT SUM(IF(nilaiangka >= $rentang[0],1,0)) as j1, ".
                             "SUM(IF(nilaiangka>=$rentang[1] AND nilaiangka<$rentang[0],1,0)) as j2, ".
                             "SUM(IF(nilaiangka>=$rentang[2] AND nilaiangka<$rentang[1],1,0)) as j3, ".
                             "SUM(IF(nilaiangka>=$rentang[3] AND nilaiangka<$rentang[2],1,0)) as j4, ".
                             "SUM(IF(nilaiangka>=$rentang[4] AND nilaiangka<$rentang[3],1,0)) as j5, ".
                             "SUM(IF(nilaiangka>=$rentang[5] AND nilaiangka<$rentang[4],1,0)) as j6, ".
                             "SUM(IF(nilaiangka>=$rentang[6] AND nilaiangka<$rentang[5],1,0)) as j7, ".
                             "SUM(IF(nilaiangka>=$rentang[7] AND nilaiangka<$rentang[6],1,0)) as j8, ".
                             "SUM(IF(nilaiangka<$rentang[8],1,0)) as j9 ".
                             "FROM nap n, aturannhb a, infonap i, kelas k ".
                             "WHERE n.idaturan = a.replid ".
                                "AND a.idtingkat = '$tingkat' ".
                                "AND a.idpelajaran = '$pelajaran' ".
                                "AND a.dasarpenilaian = '$dasarpenilaian' ".
                                "AND n.idinfo = i.replid ".
                                "AND i.idpelajaran = '$pelajaran' ".
                                "AND i.idsemester = '$semester' ".
                                "AND i.idkelas = k.replid ".
                                "AND k.idtahunajaran = '$tahunajaran' ".
                                "AND k.idtingkat = '$tingkat' ";	
                    //echo $query;
                    $result=Querydb($query) or die(mysql_error());
                    $lab="";
                    if(mysql_num_rows($result)==0){
                            $data[$a]=0;	
                    }else{
                        
                            $lab=array(">=90",">=80",">=70",">=60",">=50",">=40",">=30",">=20",">=10");
                            while($fetch=@mysql_fetch_array($result)){			
                                $data = array($fetch[j1],$fetch[j2],$fetch[j3],$fetch[j4],$fetch[j5],$fetch[j6],$fetch[j7],$fetch[j8],$fetch[j9]);
                            }
                        
                    }
                    
                    ?>
<table width="80%" border="1" class="tab" align="center">
                      <tr>
                        <td height="25" align="center" class="header">No.</td>
                        <td height="25" align="center" class="header">Rentang</td>
                        <td height="25" align="center" class="header">Jumlah Siswa</td>
                        <td height="25" align="center" class="header">&nbsp;</td>
                      </tr>
                      <?
                      for ($i=0;$i<count($lab);$i++){
                      ?>
                      <tr>
                        <td height="20" align="center"><?=$i+1?></td>
                        <td height="20">&nbsp;&nbsp;<?=$lab[$i]?></td>
                        <td height="20">
                        <? if ($data[$i]>0){ ?>
                        <strong>&nbsp;&nbsp;<?=$data[$i]?> siswa</strong>
                        <? } else { ?>
                        &nbsp;&nbsp;<?=$data[$i]?> siswa
                        <? } ?>            </td>
                        <td height="20" align="center">
                        <? if ($data[$i]>0){ ?>
                        <a href="javascript:viewdetail('<?=$filter[$i]?>','<?=$i?>')"><img src="../img/lihat.png" border="0" /></a></td>
                        <? } ?>
                      </tr>
                      <?
                      }
                      ?>
                    </table>			</td>
            <td width="66%" valign="top"><div id="statdetail"></div></td>
          </tr>
        </table>    	    </td>
  </tr>
</table>

</body>
</html>