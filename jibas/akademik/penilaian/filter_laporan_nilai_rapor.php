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
require_once('../include/theme.php');
require_once('../include/db_functions.php');
require_once('../library/departemen.php');

if(isset($_POST["departemen"])){
	$departemen = $_POST["departemen"];
}elseif(isset($_GET["departemen"])){
	$departemen = $_GET["departemen"];
}
if(isset($_POST["tingkat"])){
	$tingkat = $_POST["tingkat"];
}elseif(isset($_GET["tingkat"])){
	$tingkat = $_GET["tingkat"];
}
if(isset($_POST["kelas"])){
	$kelas = $_POST["kelas"];
}elseif(isset($_GET["kelas"])){
	$kelas = $_GET["kelas"];
}
if(isset($_POST["tahunajaran"])){
	$tahunajaran = $_POST["tahunajaran"];
}elseif(isset($_GET["tahunajaran"])){
	$tahunajaran = $_GET["tahunajaran"];
}
if(isset($_POST["semester"])){
	$semester = $_POST["semester"];
}elseif(isset($_GET["semester"])){
	$semester = $_GET["semester"];
}
?>

<html>
<head>
<title>Laporan Akhir Rapor Siswa</title>
<script src="../script/SpryValidationSelect.js" type="text/javascript"></script>
<link href="../script/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/tooltips.css">
<script language="JavaScript" src="../script/tooltips.js"></script>
<script language="JavaScript">
function change_sel(){
    var departemen = document.filter_laporan_rapor.departemen.value;
    document.location.href="filter_laporan_nilai_rapor.php?departemen="+departemen;
    parent.footer.location.href = "blank_laporan_rapor.php";
}
function change_sel2() {
    var departemen = document.filter_laporan_rapor.departemen.value;
    var tingkat = document.filter_laporan_rapor.tingkat.value;
    document.location.href="filter_laporan_nilai_rapor.php?tingkat="+tingkat+"&departemen="+departemen;
    parent.footer.location.href = "blank_laporan_rapor.php";
}
function change_sel3() {
    parent.footer.location.href = "blank_nilai_pelajaran.php";
}
function change_sel4() {
    parent.footer.location.href = "blank_nilai_pelajaran.php";
}
function change_sel5() {
    parent.footer.location.href = "blank_nilai_pelajaran.php";
}

function show(){
	var pelajaran = document.filter_laporan_rapor.pelajaran.checked;
	var harian = document.filter_laporan_rapor.harian.checked;
    var departemen = document.filter_laporan_rapor.departemen.value;
    var tingkat = document.filter_laporan_rapor.tingkat.value;
    var tahun = document.filter_laporan_rapor.idtahun.value;
    var semester = document.filter_laporan_rapor.semester.value;
    var kelas = document.filter_laporan_rapor.kelas.value;
   // var nip = document.filter_laporan_rapor.nip.value;	
    
    if(departemen.length == 0) {
        alert("Departemen tidak boleh kosong");
        document.filter_laporan_rapor.departemen.value = "";
        document.filter_laporan_rapor.departemen.focus();
        return false;
    }
    else if(tingkat.length == 0) {
        alert("Tingkat tidak boleh kosong");
        document.filter_laporan_rapor.tingkat.value = "";
        document.filter_laporan_rapor.tingkat.focus();
        return false;
    }
    else if(tahun.length == 0) {
        alert("Tahun Ajaran tidak boleh kosong");
        document.filter_laporan_rapor.tahun.value = "";
        document.filter_laporan_rapor.tahun.focus();
        return false;
    }
    else if(semester.length == 0) {
        alert("Semester tidak boleh kosong");
        document.filter_laporan_rapor.semester.value = "";
        document.filter_laporan_rapor.semester.focus();
        return false;
    }
    else if(kelas.length == 0) {
        alert("Kelas tidak boleh kosong");
        document.filter_laporan_rapor.kelas.value = "";
        document.filter_laporan_rapor.kelas.focus();
        return false;
    }
	/*else if(nip.length == 0) {
        alert("Guru tidak boleh kosong");
        document.filter_laporan_rapor.nip.value = "";
        document.filter_laporan_rapor.nip.focus();
        return false;
    }*/
    else {
	//alert ('HARIAN='+harian+' PEL='+pelajaran);
        parent.footer.location.href="laporan_nilai_rapor_footer.php?departemen="+departemen+"&tingkat="+tingkat+"&tahunajaran="+tahun+"&semester="+semester+"&kelas="+kelas+"&harian="+harian+"&pelajaran="+pelajaran;//+"&nip="+nip;
    }
}
</script>
</head>
<body class="filter" topmargin="0" leftmargin="0">
<?
OpenDb();
if (!isset($_POST['lihat'])) {
?>
<form action="filter_laporan_nilai_rapor.php" method="post" name="filter_laporan_rapor"
    target="footer">
    <table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
        <tr>
            <td width="97"><strong>Departemen</strong></td>
            <td width="158">
            <select name="departemen" id="departemen"  style="width:150px;" onChange="change_sel();">
              <?	$dep = getDepartemen(SI_USER_ACCESS());    
	foreach($dep as $value) {
		if ($departemen == "")
			$departemen = $value; ?>
                <option value="<?=$value ?>" <?=StringIsSelected($value, $departemen) ?> > 
                  <?=$value ?> 
                  </option>
              <?	} ?>
              </select>			</td>
			
            <td width="78"><strong>Semester</strong></td>
            <td width="186">
<?

            $query_s = "SELECT replid, semester FROM jbsakad.semester ".
                        "WHERE departemen = '$departemen' AND aktif = '1' ORDER BY semester ASC";
            $result_s = QueryDb($query_s);

            $row_s = @mysql_fetch_array($result_s);
                
            ?>
            <input type="hidden" name="semester" value="<?=$row_s[replid]?>">
			<input type="text" size="21" value="<?=$row_s[semester]?>" readonly class="disabled">			</td>
            <td align="left" valign="bottom" width="72" rowspan="3"><img src="../images/view.png" width="48" height="48" border="0" onClick="show()" style="cursor:pointer;"></td>
          <td align="right" valign="top" width="398" rowspan="3">
          <font size="4" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="4" face="Verdana, Arial, Helvetica, sans-serif" color="Gray">Nilai Rapor Siswa</font><br />
            <a href="../penilaian.php?flag=1" target="content"> <font size="1" color="#000000"><b>Penilaian</b></font></a>&nbsp>&nbsp <font size="1" color="#000000"><b>Nilai Rapor Siswa</b></font>          </td>
        </tr>
        <tr>
            <td><strong>Tingkat</strong></td>
            <td><select name="tingkat" id="tingkat" size="1" style="width:150px;" onChange="change_sel2();">
<?

            $query_t = "SELECT replid, tingkat FROM jbsakad.tingkat ".
                        "WHERE departemen = '$departemen' AND aktif = '1' ORDER BY urutan ASC";
            $result_t = QueryDb($query_t);

            $i = 0;
            while ($row_t = @mysql_fetch_array($result_t)) {
                if($tingkat == "") {
                    $tingkat = $row_t[replid];
                    $sel[$i] = "selected";
                }
                elseif($tingkat == $row_t[replid]) {
				    $sel[$i] = "selected";
                }else {
                    $sel[$i] = "";
                }
                echo "
                    <option value='$row_t[replid]' $sel[$i]>$row_t[tingkat]</option>
                ";
                $i++;
            }
            ?>
            </select>			</td>
			
			<td><strong>Kelas</strong></td>
            <td><select name="kelas" id="kelas" size="1" style="width:150px;" onChange="change_sel4()">
            <?
            $query_th = "SELECT replid, tahunajaran FROM jbsakad.tahunajaran ".
                        "WHERE departemen = '$departemen' AND aktif = '1' ";
            $result_th = QueryDb($query_th);
            $row_th = @mysql_fetch_array($result_th);
            $tahun = $row_th[tahunajaran];
            $replid = $row_th[replid];

            $query_k = "SELECT replid, kelas FROM jbsakad.kelas ".
                        "WHERE idtingkat = '$tingkat' ".
                        "AND idtahunajaran = '$replid' ORDER BY replid";
            $result_k = QueryDb($query_k);

            $i = 0;
            while ($row_k = @mysql_fetch_array($result_k)) {
                if($kelas == "") {
                    $kelas = $row_k[replid];
                    $sel[$i] = "selected";
                }
                elseif($kelas == $row_k[replid]) {
				    $sel[$i] = "selected";
                }else {
                    $sel[$i] = "";
                }
                echo "
                    <option value='$row_k[replid]' $sel[$i]>$row_k[kelas]</option>
                ";
                $i++;
            }
            ?>
            </select>		</td>
        </tr>
        <tr>
            <td><strong>Tahun Ajaran</strong></td>
            <td>
                <input type="hidden" name="idtahun" value="<?=$replid;?>">
                <input type="text" name="tahun" size="22" value="<?=$tahun;?>" readonly class="disabled">            </td>
            <td><strong>Presensi</strong></td>
			<td><input type="checkbox" name="harian" id="harian" >			  Harian&nbsp;			  <input type="checkbox" name="pelajaran" id="pelajaran" >Pelajaran</td>
          </tr>
    </table>
    </form>

<?
}
CloseDb();
?>
</body>
</html>
<script language="javascript">
	var spryselect1 = new Spry.Widget.ValidationSelect("departemen");
	var spryselect3 = new Spry.Widget.ValidationSelect("tingkat");
	var spryselect4 = new Spry.Widget.ValidationSelect("kelas");
</script>