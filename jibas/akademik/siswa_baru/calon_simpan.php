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
require_once('../include/rupiah.php');
require_once('../include/imageresizer.php');
require_once('../include/db_functions.php');

$proses = $_REQUEST['proses'];

OpenDb();

$sql = "SELECT kodeawalan FROM jbsakad.prosespenerimaansiswa WHERE replid = '$proses'";	
$res = QueryDb($sql);	
$row = mysql_fetch_row($res);	
$kode_no = $row[0];
$kodelen = strlen($kode_no);
//echo "$kode_no<br>";

$sql = "SELECT MAX(LPAD(nopendaftaran, " . ($kodelen + 20) . ",'*')) FROM jbsakad.calonsiswa WHERE idproses = '$proses'";
$res = QueryDb($sql);	
$row = mysql_fetch_row($res);
$nom = $row[0];
//echo "$nom<br>";

$nom = str_replace("*", "", $nom);
//echo "$nom<br>";

$counter = (int)substr($nom, $kodelen + 2);
//echo "$counter<br>";

$thn_no = substr(date('Y'), 2);
//echo "$thn_no<br>";
do
{
    $counter += 1;
    $no = $kode_no . $thn_no . sprintf("%04d", $counter);
    
    $sql = "SELECT COUNT(replid) FROM jbsakad.calonsiswa WHERE nopendaftaran='$no'";
    //echo "$sql<br>";
    $res = QueryDb($sql);
    $row = mysql_fetch_row($res);
    $ndata = (int)$row[0];
}
while($ndata > 0);

//echo "$no is Unique<br>";
//exit();

$nisn = CQ($_REQUEST['nisn']);
$tahunmasuk = $_REQUEST['tahunmasuk'];
$nama = CQ($_REQUEST['nama']);
$panggilan=CQ($_REQUEST['panggilan']);
$kelamin=$_REQUEST['kelamin'];
$tmplahir=CQ($_REQUEST['tmplahir']);
$tgllahir=$_REQUEST['tgllahir'];
$blnlahir=$_REQUEST['blnlahir'];
$thnlahir=$_REQUEST['thnlahir'];;
$lahir=$thnlahir."-".$blnlahir."-".$tgllahir;
$suku=$_REQUEST['suku'];
$agama=$_REQUEST['agama'];
$status=$_REQUEST['status'];
$kondisi=$_REQUEST['kondisi'];
$warga=$_REQUEST['warga'];
$urutananak=$_REQUEST['urutananak'];;
if ($_REQUEST['urutananak']=="")
	$urutananak = 0;
$jumlahanak=$_REQUEST['jumlahanak'];
if ($_REQUEST['jumlahanak']=="")
	$jumlahanak = 0;
$bahasa=CQ($_REQUEST['bahasa']);
$alamatsiswa=CQ($_REQUEST['alamatsiswa']);
$kodepos=CQ($_REQUEST['kodepos']);
$kodepos_sql = "kodepossiswa = '$kodepos'";
if ($kodepos == "")
	$kodepos_sql = "kodepossiswa = NULL";
$telponsiswa=CQ($_REQUEST['telponsiswa']);
$hpsiswa=CQ(trim($_REQUEST['hpsiswa']));
$hpsiswa=str_replace(' ','',$hpsiswa);
$emailsiswa=CQ($_REQUEST['emailsiswa']);
$dep_asal=$_REQUEST['dep_asal'];
$sekolah=$_REQUEST['sekolah'];
$sekolah_sql = "asalsekolah = '$sekolah'";
if ($sekolah == "")
	$sekolah_sql = "asalsekolah = NULL";
$ketsekolah=CQ($_REQUEST['ketsekolah']);
$gol=$_REQUEST['gol'];
//$berat=$_REQUEST['berat'];
$berat = $_REQUEST['berat'];
if ($_REQUEST['berat']=="")
	$berat = 0;
$tinggi = $_REQUEST['tinggi'];
if ($_REQUEST['tinggi']=="")
	$tinggi = 0;
$kesehatan=CQ($_REQUEST['kesehatan']);
$namaayah=CQ($_REQUEST['namaayah']);
$almayah = $_REQUEST['almayah'];
if ($_REQUEST['almayah']<> "1")
	$almayah=0;
$namaibu=CQ($_REQUEST['namaibu']);
$almibu = $_REQUEST['almibu'];
if ($_REQUEST['almibu']<> "1")
	$almibu=0;
$pendidikanayah=$_REQUEST['pendidikanayah'];
$pendidikanayah_sql = "pendidikanayah = '$pendidikanayah'";
if ($pendidikanayah == "")
	$pendidikanayah_sql = "pendidikanayah = NULL";
$pendidikanibu=$_REQUEST['pendidikanibu'];
$pendidikanibu_sql = "pendidikanibu = '$pendidikanibu'";
if ($pendidikanibu == "")
	$pendidikanibu_sql = "pendidikanibu = NULL";
$pekerjaanayah=$_REQUEST['pekerjaanayah'];
$pekerjaanayah_sql = "pekerjaanayah = '$pekerjaanayah'";
if ($pekerjaanayah == "")
	$pekerjaanayah_sql = "pekerjaanayah = NULL";
$pekerjaanibu=$_REQUEST['pekerjaanibu'];
$pekerjaanibu_sql = "pekerjaanibu = '$pekerjaanibu'";
if ($pekerjaanibu == "")
	$pekerjaanibu_sql = "pekerjaanibu = NULL";
$penghasilanayah = $_REQUEST['penghasilanayah'];
if ($_REQUEST['penghasilanayah']=="")
	$penghasilanayah = 0;
$penghasilanibu = $_REQUEST['penghasilanibu'];
if ($_REQUEST['penghasilanibu']=="")
	$penghasilanibu = 0;
$namawali=CQ($_REQUEST['namawali']);
$alamatortu=CQ($_REQUEST['alamatortu']);
$telponortu=CQ($_REQUEST['telponortu']);
$hportu=CQ(trim($_REQUEST['hportu']));
$hportu=str_replace(' ','',$hportu);
$hportu2=CQ(trim($_REQUEST['hportu2']));
$hportu2=str_replace(' ','',$hportu2);
$hportu3=CQ(trim($_REQUEST['hportu3']));
$hportu3=str_replace(' ','',$hportu3);
$emailayah=CQ($_REQUEST['emailayah']);
$emailibu=CQ($_REQUEST['emailibu']);
$alamatsurat=CQ($_REQUEST['alamatsurat']);
$keterangan=CQ($_REQUEST['keterangan']);
$departemen=$_REQUEST['departemen'];
$kelompok = $_REQUEST['kelompok'];

// --- check temporary directory
$tmp_path = realpath(".") . "/../../temp";
$tmp_exists = file_exists($tmp_path) && is_dir($tmp_path);
if (!$tmp_exists)
	mkdir($tmp_path, 0755);
	
$foto = $_FILES["nama_foto"];
$uploadedfile = $foto['tmp_name'];
$uploadedtypefile = $foto['type'];
$uploadedsizefile = $foto['size'];
if ($uploadedfile != "")
{
	$filename = "$tmp_path/ad-cs-tmp.jpg";
	ResizeImage($foto, 159, 120, 100, $filename);
	
	$fh = fopen($filename, "r");
	$foto_data = addslashes(fread($fh, filesize($filename)));
	fclose($fh);
	
	$gantifoto = ", foto='$foto_data'";
} 
else 
{
	if ($_REQUEST['action'] == 'ubah') 
	{	
	   $x = @mysql_fetch_row(QueryDb("SELECT foto FROM jbsakad.calonsiswa WHERE replid='$_REQUEST[replid]'"));
	   $data = $x[0];
	   
	   $filename = "$tmp_path/ed-cs-tmp.jpg";
	   $src_img = imagecreatefromstring($data);
	   $dst_img = imagecreatetruecolor(120, 159);
	   imagecopyresampled($dst_img, $src_img, 0,0,0,0, 120, 159, imagesx($src_img), imagesy($src_img));
	   imagejpeg($dst_img, $filename, 100);
	   
	   $fh = fopen($filename, "r");
	   $foto_data = addslashes(fread($fh, filesize($filename)));
	   fclose($fh);
	   
	   $gantifoto = ", foto='$foto_data'";
	}
}

$set = "";
for($i = 1; $i <= 2; $i++)
{
	if ($set != "")
		$set .= ", ";
	$fkd = "sum$i";
	$kd = trim($_REQUEST[$fkd]);
	$kd = (strlen($kd) == 0) ? "0" : $kd;
	$kd = UnformatRupiah($kd);
	$set .= "$fkd = '$kd'";
}

for($i = 1; $i <= 5; $i++)
{
	if ($set != "")
		$set .= ", ";
	$fkd = "ujian$i";
	$kd = trim($_REQUEST[$fkd]);
	$kd = (strlen($kd) == 0) ? 0 : $kd;
	$set .= "$fkd = '$kd'";
}

if ($_REQUEST['action'] == 'ubah')
{	
	$sql = "UPDATE jbsakad.calonsiswa
			   SET nama='$nama', panggilan='$panggilan', idproses=$proses, idkelompok=$kelompok, suku='$suku',
				   agama='$agama', status='$status', kondisi='$kondisi', kelamin='$kelamin', tmplahir='$tmplahir',
				   tgllahir='$lahir', warga='$warga', anakke=$urutananak, jsaudara=$jumlahanak, bahasa='$bahasa',
				   berat=$berat, tinggi=$tinggi, darah='$gol', foto='$foto', alamatsiswa='$alamatsiswa', $kodepos_sql,
				   telponsiswa='$telponsiswa', hpsiswa='$hpsiswa', emailsiswa='$emailsiswa', kesehatan='$kesehatan', $sekolah_sql,
				   ketsekolah='$ketsekolah', namaayah='$namaayah', namaibu='$namaibu', almayah=$almayah, almibu=$almibu, $pendidikanayah_sql,
				   $pendidikanibu_sql,  $pekerjaanayah_sql, $pekerjaanibu_sql, wali='$namawali', penghasilanayah=$penghasilanayah,
				   penghasilanibu=$penghasilanibu, alamatortu='$alamatortu', telponortu='$telponortu',
				   hportu='$hportu', info1='$hportu2', info2='$hportu3', emailayah='$emailayah', emailibu='$emailibu',
				   alamatsurat='$alamatsurat', keterangan='$keterangan',nisn='$nisn', $set $gantifoto
			 WHERE replid = $_REQUEST[replid]";
}
else
{ 
	$sql = "INSERT INTO jbsakad.calonsiswa
			   SET nopendaftaran='$no', nama='$nama', panggilan='$panggilan', tahunmasuk='$tahunmasuk', idproses='$proses',
				   idkelompok='$kelompok', suku='$suku', agama='$agama', status='$status', kondisi='$kondisi', kelamin='$kelamin',
				   tmplahir='$tmplahir', tgllahir='$lahir', warga='$warga', anakke='$urutananak', jsaudara='$jumlahanak', bahasa='$bahasa',
				   berat='$berat', tinggi='$tinggi', darah='$gol', alamatsiswa='$alamatsiswa', $kodepos_sql, telponsiswa='$telponsiswa',
				   hpsiswa='$hpsiswa', emailsiswa='$emailsiswa', kesehatan='$kesehatan', $sekolah_sql, ketsekolah='$ketsekolah',
				   namaayah='$namaayah', namaibu='$namaibu', almayah='$almayah', almibu='$almibu', $pendidikanayah_sql,
				   $pendidikanibu_sql, $pekerjaanayah_sql, $pekerjaanibu_sql, wali='$namawali', penghasilanayah='$penghasilanayah',
				   penghasilanibu='$penghasilanibu', alamatortu='$alamatortu', telponortu='$telponortu', hportu='$hportu',
				   info1='$hportu2', info2='$hportu3', emailayah='$emailayah', emailibu='$emailibu', alamatsurat='$alamatsurat',
				   keterangan='$keterangan',nisn='$nisn', $set $gantifoto";
}	
//echo $sql;
//exit;
$result = QueryDb($sql);
if ($result) { ?>

<script language="javascript">
	parent.opener.refresh_simpan('<?=$departemen?>','<?=$proses?>','<?=$kelompok?>');
	window.close();
</script> 
<?  } 
//} 
//}

CloseDb();
?>

<!--</body>
</html>-->