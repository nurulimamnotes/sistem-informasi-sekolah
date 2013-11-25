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
require_once('../include/theme.php');
require_once('../include/config.php');
require_once('../include/rupiah.php');
require_once('../include/db_functions.php');
require_once('../library/departemen.php');
require_once('../cek.php');

$replid = $_REQUEST['replid'];

OpenDb();

$sql = "SELECT c.nopendaftaran, c.nama, c.panggilan, c.tahunmasuk, c.idproses, c.idkelompok, c.suku, c.agama,
			   c.status, c.kondisi as kondisi, c.kelamin, c.tmplahir, DAY(c.tgllahir) AS tanggal, MONTH(c.tgllahir) AS bulan,
			   YEAR(c.tgllahir) AS tahun, c.warga, c.anakke, c.jsaudara, c.bahasa, c.berat, c.tinggi, c.darah, c.foto,
			   c.alamatsiswa, c.kodepossiswa, c.telponsiswa, c.hpsiswa, c.emailsiswa, c.kesehatan, c.asalsekolah, c.ketsekolah,
			   c.namaayah, c.namaibu, c.almayah, c.almibu, c.pendidikanayah, c.pendidikanibu, c.pekerjaanayah, c.pekerjaanibu,
			   c.wali, c.penghasilanayah, c.penghasilanibu, c.alamatortu, c.telponortu, c.hportu, c.info1, c.info2, c.emailayah, c.emailibu,
			   c.alamatsurat, c.keterangan, p.replid AS proses, p.departemen, p.kodeawalan, k.replid AS kelompok,
			   c.sum1, c.sum2, c.ujian1, c.ujian2, c.ujian3, c.ujian4, c.ujian5, c.nisn
		  FROM calonsiswa c, kelompokcalonsiswa k, prosespenerimaansiswa p
		 WHERE c.replid = '$replid'
		   AND p.replid = c.idproses
		   AND k.replid = c.idkelompok
		   AND p.replid = k.idproses";

$result = QueryDB($sql);
$row_siswa = mysql_fetch_array($result); 

$departemen = $row_siswa['departemen'];
$proses = $row_siswa['proses'];
$kelompok = $row_siswa['kelompok'];
$kelompok_lama = $row_siswa['kelompok'];
$no = $row_siswa['nopendaftaran'];
$sum1 = $row_siswa['sum1'];
$sum2 = $row_siswa['sum2'];
$ujian1 = $row_siswa['ujian1'];
$ujian2 = $row_siswa['ujian2'];
$ujian3 = $row_siswa['ujian3'];
$ujian4 = $row_siswa['ujian4'];
$ujian5 = $row_siswa['ujian5'];

$tahunmasuk = $row_siswa['tahunmasuk'];
$blnlahir = (int)$row_siswa['bulan'];
$thnlahir = (int)$row_siswa['tahun'];

if ($row_siswa['asalsekolah'] <> NULL) 
{
	$query = "SELECT departemen FROM asalsekolah WHERE sekolah = '$row_siswa[asalsekolah]'";
	$hasil = QueryDb($query);	
	$row = mysql_fetch_array($hasil);
	$dep_asal = $row['departemen'];
	$sekolah = $row_siswa['asalsekolah'];
}
else 
{	
	$dep_asal = "";
	$sekolah = "";
}


if ($blnlahir == 4 || $blnlahir == 6|| $blnlahir == 9 || $blnlahir == 11 ) 
	$n = 30;
else if ($blnlahir == 2 && $thnlahir % 4 <> 0) 
	$n = 28;
else if ($blnlahir == 2 && $thnlahir % 4 == 0) 
	$n = 29;
else 
	$n = 31;

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/tooltips.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JIBAS SIMAKA [Ubah Calon Siswa]</title>
<script language="javascript" src="../script/tables.js"></script>
<script language="javascript" src="../script/rupiah.js"></script>
<script language="javascript" src="../script/tools.js"></script>
<script language="JavaScript" src="../script/tooltips.js"></script>
<script language="javascript" src="../script/ajax.js"></script>
<script language="javascript" src="../script/validasi.js"></script>
<script language="javascript">


function validate() {
	var urutananak=document.main.urutananak.value;
	var jumlahanak=document.main.jumlahanak.value;
	var kodepos=document.main.kodepos.value;
	var telponsiswa=document.main.telponsiswa.value;
	var hpsiswa=document.main.hpsiswa.value;	
	var berat=document.getElementById('berat').value;
	var tinggi=document.main.tinggi.value;
	var penghasilanayah=document.main.penghasilanayah.value;
	var penghasilanibu=document.main.penghasilanibu.value;
	var telponortu=document.main.telponortu.value;
	var hportu=document.main.hportu.value;
	var hportu2=document.main.hportu2.value;
	var hportu3=document.main.hportu3.value;
	var emailsiswa = document.main.emailsiswa.value;
	var emailayah = document.main.emailayah.value;
	var emailibu = document.main.emailibu.value;
	var tgllahir = document.getElementById("tgllahir").value;
	var blnlahir = document.getElementById("blnlahir").value;
	var thnlahir = document.getElementById("thnlahir").value;
	var nama = document.main.nama.value;
	var tmplahir = document.main.tmplahir.value;	
	var agama = document.main.agama.value;
	var suku = document.main.suku.value;
	var status = document.main.status.value;
	var kondisi = document.main.kondisi.value;	
	var kelompok = document.main.kelompok.value;
	var kel_lama = document.main.kel_lama.value;
	var file=document.getElementById("file").value;
	
	if (kelompok.length == 0) {
		alert("Kelompok Calon Siswa tidak boleh kosong!");
		document.getElementById('departemen').focus();
		return false;
	} 
		
	if (kelompok != kel_lama) {
		var kapasitas = parseInt(document.main.kapasitas.value);
		var isi = parseInt(document.main.isi.value);
		if (kapasitas <= isi) {
			alert("Kapasitas kelompok tidak mencukupi untuk menambah data calon baru!");
			document.getElementById('kelompok').focus();
			return false;	
		}
	}
	
	if (nama.length == 0) {
		alert("Anda harus mengisikan data untuk Nama!");
		document.getElementById('nama').focus();
		return false;
	}
	
	if (tmplahir.length == 0) {
		alert("Anda harus mengisikan data untuk Tempat Lahir!");
		document.getElementById('tmplahir').focus();
		return false;
	}
	
	if (tgllahir == "") {
       	alert("Anda harus mengisikan data untuk Tanggal Lahir!");
		document.main.tgllahir.focus();
        return false;
   	}
	
	if (blnlahir == "") {
       	alert("Anda harus mengisikan data untuk Bulan Lahir!");
		document.main.blnlahir.focus();
        return false;
   	}
	
	if (thnlahir == "") {
       	alert("Anda harus mengisikan data untuk Tahun Lahir!");
		document.main.thnlahir.focus();
        return false;
   	}
	
	if (thnlahir.length > 0){	
		if(isNaN(thnlahir)) {
    		alert ('Data tahun lahir harus berupa bilangan!');
			//document.main.thnlahir.value="";
			document.main.thnlahir.focus();
        	return false;
		}
		if (thnlahir.length > 4 || thnlahir.length < 4) {
        	alert("Tahun lahir tidak boleh lebih atau kurang dari 4 karakter!"); 
			document.main.thnlahir.focus();
        return false;
    	}
    }
	
	
	if(agama.length == 0) {
       	alert("Anda harus mengisikan data untuk Agama calon siswa!");
		document.main.agama.focus();
        return false;
   	}
	
	if(suku.length == 0) {
       	alert("Anda harus mengisikan data untuk Suku calon siswa!");
		document.main.suku.focus();
        return false;
   	}
	
	if(status.length == 0) {
       	alert("Anda harus mengisikan data untuk Status calon siswa!");
		document.main.status.focus();
        return false;
   	}
	
	if(kondisi.length == 0) {
       	alert("Anda harus mengisikan data untuk Kondisi calon siswa!");
		document.main.kondisi.focus();
        return false;
   	}
		
	if (urutananak.length > 0){
		if(isNaN(urutananak)) {
			alert ('Data isian anak ke harus berupa bilangan!');
			document.main.urutananak.value="";
			document.main.urutananak.focus();
			return false;
		}
		if (urutananak == 0) {
			alert("Urutan Anak harus lebih besar dari 0!");
			document.getElementById('urutananak').focus();
			return false;
		}
		if (jumlahanak.length == 0) {
			alert("Jumlah saudara tidak boleh kosong!");
			document.getElementById('jumlahanak').focus();
			return false;
		}
	} else {
		alert("Urutan Anak tidak boleh kosong!");
		document.getElementById('urutananak').focus();
		return false;
	}
	

	if (jumlahanak.length > 0){
		if(isNaN(jumlahanak)) {
			alert ('Jumlah saudara harus berupa bilangan!');
			//document.getElementById('jumlahanak').value="";
			document.getElementById('jumlahanak').focus();
			return false;
		} 		
	}

	if (parseInt(urutananak) > parseInt(jumlahanak)) {
		alert ('Urutan anak tidak boleh lebih dari jumlah saudara yang ada!');
		document.getElementById ('urutananak').focus();
		return false;
	}
		
	if (kodepos.length > 0){
		if(isNaN(kodepos)) {
			alert ('Data kodepos harus berupa bilangan!');
			//document.getElementById('kodepos').value="";
			document.getElementById('kodepos').focus();
			return false;
		}
	}	

	if (telponsiswa.length > 0){
		if(isNaN(telponsiswa)) {
			alert ('Data nomor telepon harus berupa bilangan!');
			//document.getElementById('telponsiswa').value="";
			document.getElementById('telponsiswa').focus();
			return false;
		}
	}
		
	if (hpsiswa.length > 0)
	{
		if(hpsiswa.substring(0, 1) != "#" && isNaN(hpsiswa))
		{
			alert ('Data nomor HP harus berupa bilangan!\nTidak boleh menggunakan spasi.');
			document.getElementById('hpsiswa').focus();
			return false;
		}
	}	
	
	if (berat.length > 0){
		if(isNaN(berat)) {
			alert ('Data berat harus berupa bilangan');
			//document.getElementById('berat').value=0;
			document.getElementById('berat').focus();
			return false;
		}
	}		

	if (tinggi.length > 0){
		if(isNaN(tinggi)) {
			alert ('Data tinggi harus berupa bilangan!');
			//document.getElementById('tinggi').value="";
			document.getElementById('tinggi').focus();
			return false;
		}
	}	
	
	if (penghasilanayah.length > 0){
		if(isNaN(penghasilanayah)) {
			alert ('Data penghasilan Ayah harus berupa bilangan!');
			//document.getElementById('penghasilanayah').value="";
			document.getElementById('penghasilanayah1').focus();
			return false;
		}
	}	
		
	if (penghasilanibu.length > 0){
		if(isNaN(penghasilanibu)) {
			alert ('Data penghasilan Ibu harus berupa bilangan!');
			//document.getElementById('penghasilanibu').value="";
			document.getElementById('penghasilanibu1').focus();
			return false;
		}
	}

	if (telponortu.length > 0){
		if(isNaN(telponortu)) {
			alert ('Data telepon orang tua harus berupa bilangan!');
			//document.getElementById('telponortu').value="";
			document.getElementById('telponortu').focus();
			return false;
		}
	}
	
	if (hportu.length > 0)
	{
		if (hportu.substring(0, 1) != "#" && isNaN(hportu))
		{
			alert ('Data nomor HP orang tua harus berupa bilangan!\nTidak boleh menggunakan spasi.');
			document.getElementById('hportu').focus();
			return false;
		}
	}
	
	if (hportu2.length > 0)
	{
		if (hportu2.substring(0, 1) != "#" && isNaN(hportu2))
		{
			alert ('Data nomor HP orang tua harus berupa bilangan!\nTidak boleh menggunakan spasi.');
			document.getElementById('hportu2').focus();
			return false;
		}
	}
	
	if (hportu3.length > 0)
	{
		if (hportu3.substring(0, 1) != "#" && isNaN(hportu3))
		{
			alert ('Data nomor HP orang tua harus berupa bilangan!\nTidak boleh menggunakan spasi.');
			document.getElementById('hportu3').focus();
			return false;
		}
	}
	
	if (emailsiswa.length > 0) {
		if (!validateEmail("emailsiswa") ) { 
			alert( "Email yang Anda masukkan bukan merupakan alamat email!" );
			document.main.emailsiswa.focus();
			return false;	
		}	
	}
	
	if (emailayah.length > 0) {
		if (!validateEmail("emailayah") ) { 
			alert( "Email yang Anda masukkan bukan merupakan alamat email!" );
			document.main.emailayah.focus();
			return false;	
		}	
	}
	
	if (emailibu.length > 0) {
		if (!validateEmail("emailibu") ) { 
			alert( "Email yang Anda masukkan bukan merupakan alamat email!" );
			document.main.emailibu.focus();
			return false;	
		}	
	}
		
	var namatgl = "tgllahir";
	var namabln = "blnlahir";
		
	if (thnlahir.length != 0 && blnlahir.length != 0 && tgllahir.length != 0){
		if (thnlahir % 4 == 0){
			 if (blnlahir == 2){
				  if (tgllahir>29){
					   alert ('Maaf, silahkan masukan ulang tanggal lahir!');
					   sendRequestText("../library/gettanggal.php", show1, "tahun="+thnlahir+"&bulan="+blnlahir+"&tgl="+tgllahir+"&namatgl="+namatgl+"&namabln="+namabln);	
					   document.getElementById("tgllahir").focus();
					   return false;
				  }
			 }
			 if (blnlahir == 4 || blnlahir == 6 || blnlahir == 9 || blnlahir == 11){
				  if (tgllahir>30){
					   alert ('Maaf, silahkan masukan ulang tanggal lahir!');
					   sendRequestText("../library/gettanggal.php", show1, "tahun="+thnlahir+"&bulan="+blnlahir+"&tgl="+tgllahir+"&namatgl="+namatgl+"&namabln="+namabln);	
					   document.getElementById("tgllahir").focus();
					   return false;
				  }
			 }
		}
		if (thnlahir % 4 != 0){
			 if (blnlahir == 2){
				 if (tgllahir>28){
					   alert ('Maaf, silahkan masukan ulang tanggal lahir!');
					   sendRequestText("../library/gettanggal.php", show1, "tahun="+thnlahir+"&bulan="+blnlahir+"&tgl="+tgllahir+"&namatgl="+namatgl+"&namabln="+namabln);	
					   document.getElementById("tgllahir").focus();
					   return false;
					   
				  }
			 }
			 if (blnlahir == 4 || blnlahir == 6 || blnlahir == 9 || blnlahir == 11){
				  if (tgllahir>30){
					   alert ('Maaf, silahkan masukan ulang tanggal lahir!');
					   sendRequestText("../library/gettanggal.php", show1, "tahun="+thnlahir+"&bulan="+blnlahir+"&tgl="+tgllahir+"&namatgl="+namatgl+"&namabln="+namabln);	
					   document.getElementById("tgllahir").focus();
					   return false;
					   
				  }
			 }
		}
	}
	
	if (file.length>0){
		var ext = "";
		/*
		if (file.length > 0) {
			while (i < file.length){
				if (file.charAt(i) == '.'){
					titik = i;
				}
				
				if (titik != 0){
					ext = ext + file.charAt(i);
				}
				i++;
			}	
		} */
		var x = file.split('.');
		ext = x[(x.length-1)];
		if (ext!='JPG' && ext!='jpg' && ext!='Jpg' && ext!='JPg' && ext!='JPEG' && ext!='jpeg'){
			alert ('Format Gambar harus ber-extensi jpg atau JPG !');
			document.getElementById("foto").value='';
			document.main.file.focus();
    		document.main.file.select();
			return false;
		} 
	} 
	return true;
}

function sekolah_kiriman(sekolah, dep) {	
	var dep_asal = document.getElementById("dep_asal").value;
	if (dep_asal == dep) {
		change_departemen(sekolah);
	} else {
		setTimeout("change_departemen(0)",1);
	}
}
function sekolah_kiriman2(dep) {
	show_wait("depInfo");
	sendRequestText("../siswa/siswa_add_getdepasal.php", showDep, "dep="+dep);
}
function showDep(x) {
	document.getElementById("depInfo").innerHTML = x;
	change_departemen(0);
}
function change_departemen(kode) {		
	var dep_asal = document.getElementById("dep_asal").value;
	wait_sekolah();
	if (kode==0){
		sendRequestText("../siswa/siswa_add_getsekolah.php", showSekolah, "dep_asal="+dep_asal);		
	} else {		
		sendRequestText("../siswa/siswa_add_getsekolah.php", showSekolah, "dep_asal="+dep_asal+"&sekolah="+kode);
	}
}

function wait_sekolah() {
	show_wait("sekolahInfo");
}
function show_wait(areaId) {
	var x = document.getElementById("waitBox").innerHTML;
	document.getElementById(areaId).innerHTML = x;
}
function showSekolah(x) {
	document.getElementById("sekolahInfo").innerHTML = x;
}
function refresh_delete_sekolah(){
	setTimeout("change_departemen(0)",1);
}

function tambah_suku(){
	newWindow('../library/suku.php', 'tambahSuku','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_agama(){
	newWindow('../library/agama.php', 'tambahAgama','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_status(){
	newWindow('../siswa/siswa_add_status.php', 'tambahStatus','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_kondisi(){
	newWindow('../siswa/siswa_add_kondisi.php', 'tambahKondisi','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_asal_sekolah(){
	var departemen = document.getElementById("dep_asal").value;
	newWindow('../siswa/siswa_add_asalsekolah.php?departemen='+departemen, 'tambahAsalSekolah','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_pendidikan(){
	newWindow('../siswa/siswa_add_pendidikan.php', 'tambahPendidikan','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}
function tambah_pekerjaan(){
	newWindow('../siswa/siswa_add_pekerjaan.php', 'tambahPekerjaan','500','425','resizable=1,scrollbars=1,status=0,toolbar=0')
}

function tutup(){
	var departemen = document.getElementById('departemen').value;
	var proses = document.getElementById('proses').value;	
	var kelompok = document.getElementById('kelompok').value;
	parent.opener.location.href = "calon_content.php?departemen="+departemen+"&proses="+proses+"&kelompok="+kelompok;
	window.close();
}

function ambil_alamat_ortu(){
	var alamatsiswa = document.getElementById("alamatsiswa").value;
	document.getElementById("alamatortu").value=alamatsiswa;
}

function ambil_alamat_surat(){
	var alamatsiswa = document.getElementById("alamatsiswa").value;
	document.getElementById("alamatsurat").value=alamatsiswa;
}

//Ajax suku ==========================================================
function suku_kiriman(suku_kiriman) {	
	suku = suku_kiriman
	setTimeout("refresh_suku(suku)",1);
}
function refresh_suku(kode){
	wait_suku();
	if (kode==0){
		sendRequestText("../library/getsuku.php", showSuku, "suku=");
	} else {
		sendRequestText("../library/getsuku.php", showSuku, "suku="+kode);
	}
}
function wait_suku() {
	show_wait("InfoSuku");
}
function showSuku(x) {
	document.getElementById("InfoSuku").innerHTML = x;
}
function refresh_delete(){
	setTimeout("refresh_suku(0)",1);
}
// end of Ajax Suku ====================================================

//ajax Agama============================================================
function kirim_agama(agama_kiriman){
	agama=agama_kiriman;
	setTimeout("refresh_agama(agama)",1);
}
function refresh_agama(kode){
	wait_agama();
	if (kode==0){
		sendRequestText("../library/getagama.php", showAgama, "agama=");
	} else {
		sendRequestText("../library/getagama.php", showAgama, "agama="+kode);
	}
}
function wait_agama() {
	show_wait("InfoAgama");
}
function showAgama(x) {
	document.getElementById("InfoAgama").innerHTML = x;
}
function ref_del_agama(){
	setTimeout("refresh_agama(0)",1);
}
// end of Ajax agama=====================================================

//------- Ajax Status====================================================
function status_kiriman(st){
	refresh_status(st);
	//setTimeout("refresh_status(st)",1);
}
function refresh_status(kode) {
	wait_status();
	if (kode==0) {
		sendRequestText("../siswa/siswa_add_getstatus.php", show_status,"status=");
	} else {
		sendRequestText("../siswa/siswa_add_getstatus.php", show_status,"status="+kode);
	}
}
function wait_status() {
	show_wait("InfoStatus"); //lihat div id 
}
function show_status(x) {
	document.getElementById("InfoStatus").innerHTML = x;
}
function ref_del_status(){
	setTimeout("refresh_status(0)",1);
}
// End of Ajax Status===================================================

//====== Ajax Kondisi ==================================================
function kondisi_kiriman(kondisi){	
	refresh_kondisi(kondisi);
	//setTimeout("refresh_kondisi(kon)",1);
}
function refresh_kondisi(kode) {	
	wait_kondisi();	
	if (kode==0){
		sendRequestText("../siswa/siswa_add_getkondisi.php", show_kondisi,"kondisi=");
	} else {
		sendRequestText("../siswa/siswa_add_getkondisi.php", show_kondisi,"kondisi="+kode);
	}
}
function wait_kondisi() {
	show_wait("InfoKondisi"); //lihat div id 
}
function show_kondisi(x) {
	document.getElementById("InfoKondisi").innerHTML = x;
}
function ref_del_kondisi(){
	setTimeout("refresh_kondisi(0)",1);
}
//======End of Ajax Kondisi==============================================

//====Ajax pendidikan====================================================
function pendidikan_kiriman(pendidikan){
	setTimeout("refresh_pendidikan(pendidikan)",1);
}

function refresh_pendidikan(kode_pendidikan) {		
	wait_pendidikan();
	if (kode_pendidikan==0) {
		sendRequestText("../siswa/siswa_add_getpendidikan.php", show_pendidikan,"pendidikan=");
		sendRequestText("../siswa/siswa_add_getpendidikanibu.php", show_pendidikan1,"pendidikan=");
	} else {
		sendRequestText("../siswa/siswa_add_getpendidikan.php", show_pendidikan,"pendidikan="+kode_pendidikan);
		sendRequestText("../siswa/siswa_add_getpendidikanibu.php", show_pendidikan1,"pendidikan="+kode_pendidikan);
	}
}

function show_pendidikan(x) {
	document.getElementById("pendidikanayahInfo").innerHTML = x;
}

function show_pendidikan1(x) {
	document.getElementById("pendidikanibuInfo").innerHTML = x;
}

function wait_pendidikan() {
	show_wait("pendidikanayahInfo");
	show_wait("pendidikanibuInfo");
}

function ref_del_pendidikan() {
	setTimeout("refresh_pendidikan(0)",1);
}
//=======End Of ajax pendidikan==========================================

//========Ajax Pekerjaan ================================================
function pekerjaan_kiriman(kerja){
	setTimeout("refresh_pekerjaan(pekerjaan)",1);
}

function refresh_pekerjaan(kode_pekerjaan) {
	wait_pekerjaan();
	if(kode_pekerjaan==0){
		sendRequestText("../siswa/siswa_add_getpekerjaan.php", show_pekerjaan,"pekerjaan=");
		sendRequestText("../siswa/siswa_add_getpekerjaanibu.php", show_pekerjaan1,"pekerjaan=");
	} else {
		sendRequestText("../siswa/siswa_add_getpekerjaan.php", show_pekerjaan,"pekerjaan="+kode_pekerjaan);
		sendRequestText("../siswa/siswa_add_getpekerjaanibu.php", show_pekerjaan1,"pekerjaan="+kode_pekerjaan);
	}
	
}

function wait_pekerjaan() {
	show_wait("pekerjaanayahInfo");
	show_wait("pekerjaanibuInfo");
}

function show_pekerjaan(x) {
	document.getElementById("pekerjaanayahInfo").innerHTML = x;
}

function show_pekerjaan1(x) {
	document.getElementById("pekerjaanibuInfo").innerHTML = x;
}

function ref_del_pekerjaan(){
	setTimeout("refresh_pekerjaan(0)",1);
}
//======== End Of Ajax Pekerjaan ========================================

function change_alamat(){	
	var alamatsiswa = document.getElementById("alamatsiswa").value;
	document.getElementById("alamatortu").value=alamatsiswa;
	document.getElementById("alamatsurat").value=alamatsiswa;
}
function penghasilan_ayah(){	
	var ayah = document.getElementById("penghasilanayah1").value;
	document.getElementById("penghasilanayah").value=ayah;
}
function penghasilan_ibu(){	
	var ibu = document.getElementById("penghasilanibu1").value;
	document.getElementById("penghasilanibu").value=ibu;
}


function change_bln() {	
	var thn = document.getElementById('thnlahir').value;
	var bln = parseInt(document.getElementById('blnlahir').value);	
	var tgl = parseInt(document.getElementById('tgllahir').value);
	var namatgl = "tgllahir";
	var namabln = "blnlahir";
	
	if(thn.length != 0) {
    	if(isNaN(thn)) {
    		alert("Tahun lahir harus berupa angka"); 
			document.getElementById('thnlahir').focus();
        	return false;
		} else {	
			if (thn.length > 4 || thn.length < 4) {
            	alert("Tahun lahir tidak boleh lebih atau kurang dari 4 karakter!"); 
				document.getElementById('thnlahir').focus();
            	return false;
			}
		}
    
	sendRequestText("../library/gettanggal.php", show1, "tahun="+thn+"&bulan="+bln+"&tgl="+tgl+"&namatgl="+namatgl+"&namabln="+namabln);
	
	}
}

function show1(x) {
	document.getElementById("tgl_info").innerHTML = x;
}

function tampil_kelompok() {
	var departemen = document.getElementById("departemen").value;
	var proses = document.getElementById("proses").value;
	
	newWindow('kelompok_tampil.php?departemen='+departemen+'&proses='+proses,'tampilKelompok','750','450','resizable=1,scrollbars=1,status=0,toolbar=0');
}

function kelompok_kiriman(a,b,c) {	
	var departemen = document.getElementById("departemen").value;	
	change_kelompok(a,b,c);
}

function change_kelompok(kel,pro,dep) {
	var departemen = document.getElementById("departemen").value;
	var proses = document.getElementById("proses").value;
	var kelompok = document.getElementById("kelompok").value;	
	
	if (kel == 0) {
		change_kel()
	} else {
		sendRequestText("getdepartemen.php", show_dep,"departemen="+dep);
		sendRequestText("getproses.php", show_proses,"departemen="+dep);
		sendRequestText("getkelompok.php", show_kelompok,"departemen="+dep+"&kelompok="+kel);	
		sendRequestText("getasalsekolah.php", show_asalsekolah,"departemen="+dep);
				
	}
	
}

function change_dep() {
	var departemen = document.getElementById("departemen").value;
	sendRequestText("getproses.php", show_proses,"departemen="+departemen);
	sendRequestText("getkelompok.php", show_kelompok,"departemen="+departemen);	
	sendRequestText("getasalsekolah1.php", show_asalsekolah,"departemen="+departemen);	
		
}

function showSekolah1(x) {
	document.getElementById("sekolahInfo").innerHTML = x;
}

function change_kel() {
	var kelompok = document.getElementById("kelompok").value;	
	sendRequestText("getketerangan.php", show_keterangan,"kelompok="+kelompok);
}

function show_dep(x) {
	document.getElementById("InfoDepartemen").innerHTML = x;
}
	
function show_proses(x) {
	document.getElementById("InfoProses").innerHTML = x;
}

function show_kelompok(x) {

	document.getElementById("InfoKelompok").innerHTML = x;
	change_kel();
}

function show_keterangan(x) {
	document.getElementById("InfoKeterangan").innerHTML = x;
}

function wait_asal() {
	show_wait("InfoSekolah"); //lihat div id 
}

function show_asalsekolah(x) {	
	document.getElementById("InfoSekolah").innerHTML = x;
	change_departemen(0);
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

function panggil(elem){
	document.getElementById(elem).style.background='#4cff15';
}

function unfokus(elem){
	document.getElementById(elem).style.background='#FFFFFF';
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" style="background-color:#dcdfc4" onLoad="document.getElementById('nisn').focus()">
<div id="waitBox" style="position:absolute; visibility:hidden;">
<img src="../images/movewait.gif" border="0" />Silahkan&nbsp;tunggu...
</div>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr height="58">
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_01.jpg">&nbsp;</td>
    <td width="*" background="../<?=GetThemeDir() ?>bgpop_02a.jpg">
	<div align="center" style="color:#FFFFFF; font-size:16px; font-weight:bold">
    .: Ubah Data Calon Siswa :.
    </div>
	</td>
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_03.jpg">&nbsp;</td>
</tr>
<tr height="150">
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_04a.jpg">&nbsp;</td>
    <td width="0" style="background-color:#FFFFFF">
    <!-- CONTENT GOES HERE //--->
	<form name="main" method="post" action="calon_simpan.php" onsubmit="return validate()" enctype="multipart/form-data">
	<input type="hidden" name="replid" id="replid" value="<?=$replid?>">
	<input type="hidden" name="action" id="action" value="ubah">
    <input type="hidden" name="kel_lama" id="kel_lama" value="<?=$kelompok_lama?>">

<table border="0" width="100%" align="center">
<!-- TABLE CENTER -->
<!--tr height="25">
	<td class="header" colspan="2" align="center">Ubah Data Calon Siswa</td>
</tr-->
<tr>
	<td align="left" valign="top">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td>
       	<table width="96%" border="0" >
 		<tr>
    		<td width="27%"><strong>Departemen</strong></td>
    		<td width="*"><div id="InfoDepartemen">
            <select name="departemen" id="departemen" onchange="change_dep()" style="width:280px" onKeyPress="return focusNext('kelompok',event)" onFocus="panggil('departemen')">
              <?	$dep = getDepartemen(SI_USER_ACCESS());    
				foreach($dep as $value) {
					if ($departemen == "")
						$departemen = $value; ?>
              <option value="<?=$value ?>" <?=StringIsSelected($value, $departemen) ?> >
              <?=$value ?>
              </option>
              <?	} ?>
            </select>
            </div>
            </td>          
  		</tr>
  		
        <tr>
        	<td><strong>Proses Penerimaan</strong></td>
    		<td><div id="InfoProses">
            <?	$sql = "SELECT replid,proses FROM prosespenerimaansiswa WHERE aktif=1 AND departemen='$departemen'";				
				$result = QueryDb($sql);				
				$row = mysql_fetch_array($result);
				$proses = $row['replid'];
			?>
            <input type="text" name="nama_proses" id="nama_proses" style="width:270px;" class="disabled" value="<?=$row['proses']?>" readonly />
            <input type="hidden" name="proses" id="proses"  value="<?=$proses?>" />
            	</div>            </td>
  		</tr>
  		<tr>
    		<td><strong>Kelompok Calon Siswa</strong></td>
    		<td>
            	<div id = "InfoKelompok">
            	<select name="kelompok" id="kelompok" onchange="change_kel()" style="width:280px" onKeyPress="return focusNext('nama',event)" onFocus="panggil('kelompok')">
   		 	<?	
				$sql = "SELECT replid,kelompok,kapasitas FROM kelompokcalonsiswa WHERE idproses = $proses ORDER BY kelompok";
				$result = QueryDb($sql);
				
				while ($row = @mysql_fetch_array($result)) {
					
										
					$sql1 = "SELECT COUNT(replid) FROM calonsiswa WHERE idkelompok = $row[replid] AND aktif = 1";
					$result1 = QueryDb($sql1);				
					$row1 = mysql_fetch_row($result1);
					
					if ($kelompok == "")
						$kelompok = $row['replid'];
					
			?>
    			<option value="<?=urlencode($row['replid'])?>" <?=IntIsSelected($row['replid'], $kelompok)?> ><?=$row['kelompok'].', kapasitas: '.$row['kapasitas'] .', terisi: '.$row1[0]?>
                </option>
    		<?
				//$cnt++; 
				}	
    		?>
    			</select>&nbsp;<img src="../images/ico/tambah.png" onclick="tampil_kelompok();" onMouseOver="showhint('Tambah Kelompok!', this, event, '60px')" />            	
                	
                </div>  
           	</td>
  		</tr>
  		<tr>
    		<td valign="top"><strong>Keterangan</strong></td>
    		<td>
            	<div id = "InfoKeterangan">
			<?	
				$sql = "SELECT keterangan FROM kelompokcalonsiswa WHERE replid = $kelompok";
				$result = QueryDb($sql);
				
				$row = @mysql_fetch_array($result);			
			?>
              <textarea name="keterangan1" id="keterangan1" rows="2" cols="60" readonly style="background-color:#E5F7FF" ><?=$row['keterangan'] ?>
              </textarea>
              <?
			  $sql_cek_kap="SELECT kapasitas FROM jbsakad.kelompokcalonsiswa WHERE replid=$kelompok";
			  $res_cek_kap=QueryDb($sql_cek_kap);
			  $row_cek_kap=@mysql_fetch_array($res_cek_kap);
			  
			  $sql_cek_jum = "SELECT COUNT(replid) FROM calonsiswa WHERE idkelompok = $kelompok AND aktif = 1";
			  $res_cek_jum = QueryDb($sql_cek_jum);				
			  $row_cek_jum = mysql_fetch_row($res_cek_jum);
			  ?>
			  <input type="hidden" name="kapasitas" id="kapasitas" value="<?=$row_cek_kap[kapasitas]?>" />
			  <input type="hidden" name="isi" id="isi" value="<?=$row_cek_jum[0]?>" />
              
            	</div>        	</td>
  		</tr>
		</table>  
		
      	</td>
        <td align="right"><img src="../library/gambar.php?replid=<?=$replid?>&table=calonsiswa"  border="0"/>
        </td>
  	</tr>
	</table>
	<br />
  	<table width="100%" border="0" cellspacing="0">
 	<tr>
    	<td width="45%" valign="top"><!--Kolom Kiri-->      
		<table width="100%" border="0" cellspacing="0" id="table">
  		<tr>
    		<td height="30" colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Pribadi Calon Siswa</strong></font>
             <!--hr width="300" style="line-height:1px; border-style:dashed" align="left" color="#000000" /--> 
             <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div></td>
    	</tr>
  		<tr>
    		<td width="22%"><strong>Pendaftaran</strong></td>
    		<td colspan="2">
            	<input type="text" name="kode" id="kode" size="20" class="disabled" value="<?=$no ?>" readonly />
                <input type="hidden" name="no" id="no" value="<?=$no?>" />           	</td>
  		</tr>
  		<tr>
    		<td><strong>Tahun Masuk</strong></td>
    		<td colspan="2">
            	<input type="text" name="masuk" id="masuk" size="5" maxlength="4" value="<?=$tahunmasuk?>" readonly="readonly" class="disabled"/> 
            	<input type="hidden" name="tahunmasuk" id="tahunmasuk" value="<?=$tahunmasuk?>" /></td>
  		</tr>
  		<tr>
  		  <td>N I S N</td>
  		  <td colspan="2"><input type="text" name="nisn" id="nisn" size="30" maxlength="100"  value="<?=$row_siswa['nisn']?>" onfocus="showhint('NISN tidak boleh lebih dari 50 karakter!', this, event, '120px');panggil('nisn');" onKeyPress="return focusNext('nama', event);" onblur="unfokus('nisn')"/></td>
		  </tr>
  		<tr>
    		<td><strong>Nama</strong></td>
    		<td colspan="2">
            <input type="text" name="nama" id="nama" size="30" maxlength="100"  value="<?=$row_siswa['nama']?>" onfocus="showhint('Nama Lengkap Siswa tidak boleh kosong!', this, event, '120px');panggil('nama');" onKeyPress="return focusNext('panggilan', event);" onblur="unfokus('nama')"/>            </td>
  		</tr>
  		<tr>
    		<td>Panggilan</td>
    		<td colspan="2">
            <input type="text" name="panggilan" id="panggilan" size="30" maxlength="30" onFocus="showhint('Nama Panggilan tidak boleh lebih dari 30 karakter!', this, event, '120px');panggil('panggilan');" value="<?=$row_siswa['panggilan']?>" onKeyPress="return focusNext('kelamin', event)" onblur="unfokus('panggilan')"/>            </td>
  		</tr>
  		<tr>
    		<td><strong>Jenis Kelamin</strong></td>
    		<td colspan="3">
    		<input type="radio" id="kelamin" name="kelamin" value="l"
			<? if ($row_siswa['kelamin']=="l") 
				echo "checked='checked'";
			?>
			 onKeyPress="return focusNext('tmplahir', event)" />&nbsp;Laki-laki&nbsp;&nbsp;
        	<input type="radio" id="kelamin" name="kelamin" value="p" 
        	<? if ($row_siswa['kelamin']=="p") 
				echo "checked ='checked'";
			?>
			 onKeyPress="return focusNext('tmplahir', event)" />&nbsp;Perempuan			</td>
		</tr>
  		<tr>
  		  <td><strong>Tempat Lahir</strong></td>
		  <td colspan="2"><input type="text" name="tmplahir" id="tmplahir" size="30" maxlength="50" onFocus="showhint('Tempat Lahir tidak boleh kosong!', this, event, '120px');panggil('tmplahir')" value="<?=$row_siswa['tmplahir']?>"  onKeyPress="return focusNext('tgllahir', event)" onblur="unfokus('tmplahir')" /></td>
  		</tr>
  		<tr>
    		<td><strong>Tanggal Lahir</strong></td>
    		<td colspan="2">
            	<table cellpadding="0" cellspacing="0" border="0">
                <tr>
                	<td>
                    <div id="tgl_info">
                    <select name="tgllahir" id="tgllahir" onKeyPress="return focusNext('blnlahir', event)" onfocus="panggil('tgllahir')" onblur="unfokus('tgllahir')" >                              
                    <option value="">[Tgl]</option>
                    <? 	for ($tgl=1;$tgl<=$n;$tgl++){ ?>
                        <option value="<?=$tgl?>" <?=IntIsSelected($tgl, $row_siswa['tanggal'])?>><?=$tgl?></option>
                    <?	}	?>
                    </select>
                    </div>                    </td>
                    <td>
                    <select name="blnlahir" id="blnlahir" onKeyPress="return focusNext('thnlahir', event)" onChange="change_bln()" onfocus="panggil('blnlahir')" onblur="unfokus('blnlahir')" />
                     <option value="">[Bln]</option>
                    <? 	for ($i=1;$i<=12;$i++) { ?>
                        <option value="<?=$i?>" <?=IntIsSelected($i, $row_siswa['bulan'] )?>><?=NamaBulan($i)?></option>	
                    <?	} ?>
                    </select>
                    <input type="text" name="thnlahir" id="thnlahir" size="5" maxlength="4" onFocus="showhint('Tahun Lahir tidak boleh kosong!', this, event, '120px');panggil('thnlahir')" value="<?=$row_siswa['tahun']?>" onKeyPress="return focusNext('agama', event)" onblur="unfokus('thnlahir')"/>                    </td>
             	</tr>
                </table>          	</td>
  		</tr>
        <tr>
    		<td><strong>Agama</strong></td>
    		<td colspan="2">
    		<div id="InfoAgama">
    		<select name="agama" id="agama" class="ukuran"  onKeyPress="return focusNext('suku', event)" onfocus="panggil('agama')" onblur="unfokus('agama')">
    		<option value="">[Pilih Agama]</option>
			<? // Olah untuk combo agama
			$sql_agama="SELECT replid,agama,urutan FROM jbsumum.agama ORDER BY urutan";
			$result_agama=QueryDB($sql_agama);
			while ($row_agama = mysql_fetch_array($result_agama)) {
			?>
			<option value="<?=$row_agama['agama']?>" <?=StringIsSelected($row_agama['agama'], $row_siswa['agama'])?>><?=$row_agama['agama']?></option>
			<?
    		} 
			// Akhir Olah Data agama
			?>
    		</select>
            <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            <img src="../images/ico/tambah.png" onclick="tambah_agama();"  onMouseOver="showhint('Tambah Agama!', this, event, '50px')"/>
            <? } ?>
            </div>            </td>
  		</tr>
  		<tr>
    		<td><strong>Suku</strong></td>
    		<td colspan="2">
    		<div id="InfoSuku">
    		<select name="suku" id="suku" class="ukuran" onKeyPress="return focusNext('status', event)" onfocus="panggil('suku')" onblur="unfokus('suku')">            
    		<option value="">[Pilih Suku]</option>
			<? // Olah untuk combo suku
			$sql_suku="SELECT suku,urutan,replid FROM jbsumum.suku ORDER BY urutan";
			$result_suku=QueryDB($sql_suku);
			while ($row_suku = mysql_fetch_array($result_suku)) {				
			?>
			<option value="<?=$row_suku['suku']?>" <?=StringIsSelected($row_suku['suku'], $row_siswa['suku'])?>><?=$row_suku['suku']?></option>
			<?
    		} 
			// Akhir Olah Data suku
			?>
    		</select>
            <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            <img src="../images/ico/tambah.png" onclick="tambah_suku();"  onMouseOver="showhint('Tambah Suku!', this, event, '50px')"/>
            <? } ?></div></td>
  		</tr>
  		
  		<tr>
    		<td><strong>Status</strong></td>
    		<td colspan="2">
    		<div id="InfoStatus">
    		<select name="status" id="status" class="ukuran"  onKeyPress="return focusNext('kondisi', event)" onfocus="panggil('status')" onblur="unfokus('status')">
    		<option value="">[Pilih Status]</option>
			<? // Olah untuk combo status
			$sql_status="SELECT replid,status,urutan FROM jbsakad.statussiswa ORDER BY urutan";
			$result_status=QueryDB($sql_status);
			while ($row_status = mysql_fetch_array($result_status)) {
			?>
			<option value="<?=$row_status['status']?>" <?=StringIsSelected($row_status['status'], $row_siswa['status'])?>><?=$row_status['status']?></option>
			<?
    		} 
			// Akhir Olah Data status
			?>
    		</select>
            <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            <img src="../images/ico/tambah.png" onclick="tambah_status();"  onMouseOver="showhint('Tambah Status!', this, event, '50px')"/>
            <? } ?>
            </div>  </td>
 		</tr>
  		<tr>
    		<td><strong>Kondisi</strong></td>
    		<td colspan="2">
    		<div id="InfoKondisi">
    		<select name="kondisi" id="kondisi" class="ukuran"  onKeyPress="return focusNext('warga', event)" onfocus="panggil('kondisi')" onblur="unfokus('kondisi')">
            <option value="">[Pilih Kondisi]</option>
                <? // Olah untuk combo kondisi
			$sql_kondisi="SELECT kondisi,urutan FROM jbsakad.kondisisiswa ORDER BY urutan";
			$result_kondisi=QueryDB($sql_kondisi);
			while ($row_kondisi = mysql_fetch_array($result_kondisi)) {
			?>
                <option value="<?=$row_kondisi['kondisi']?>" <?=StringIsSelected($row_kondisi['kondisi'], $row_siswa['kondisi'])?>>
                  <?=$row_kondisi['kondisi']?>
                  </option>
                <?
    		} 
			// Akhir Olah Data kondisi
			?>
            </select>
            <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
    		<img src="../images/ico/tambah.png" onclick="tambah_kondisi();" onMouseOver="showhint('Tambah Kondisi!', this, event, '50px')"/>
            <? } ?>
            </div></td>
  		</tr>
  		<tr>
    		<td>Kewarganegaraan</td>
    		<td colspan="2">
    		<input type="radio" name="warga" id="warga" value="WNI"
			<? if ($row_siswa['warga']=="WNI") 
				echo "checked='checked'";
			?>
			 onKeyPress="return focusNext('urutananak', event)" />&nbsp;WNI&nbsp;&nbsp;
    		<input type="radio" name="warga" id="warga" value="WNA" 
			<? if ($row_siswa['warga']=="WNA") 
				echo "checked='checked'";
			?>
			 onKeyPress="return focusNext('urutananak', event)" />&nbsp;WNA</td>
  		</tr>
  		<tr>
    		<td>Anak ke</td>
    		<td colspan="2"><input type="text" name="urutananak" id="urutananak" size="3" maxlength="3" onFocus="showhint('Urutan anak tidak boleh lebih dari 3 angka!', this, event, '120px');panggil('urutananak')" value="<?=$row_siswa['anakke']?>" onKeyPress="return focusNext('jumlahanak', event)" onblur="unfokus('urutananak')" />
			&nbsp;dari&nbsp;<input type="text" name="jumlahanak" id="jumlahanak" size="3" maxlength="3" onFocus="showhint('Jumlah saudara tidak boleh lebih dari 3 angka!', this, event, '120px');panggil('jumlahanak')" value="<?=$row_siswa['jsaudara'];?>" onKeyPress="return focusNext('bahasa', event)" onblur="unfokus('jumlahanak')" />&nbsp;bersaudara</td>
  		</tr>
  		<tr>
    		<td>Bahasa</td>
    		<td colspan="2"><input type="text" name="bahasa" id="bahasa" size="30" maxlength="60" onFocus="showhint('Bahasa anak tidak boleh lebih dari 60 karakter!', this, event, '120px');panggil('bahasa')" value="<?=$row_siswa['bahasa']?>" class="ukuran"  onKeyPress="return focusNext('alamatsiswa', event)" onblur="unfokus('bahasa')" /></td>
  		</tr>
  		<tr>
    		<td>Foto</td>
    		<td colspan="2"><input type="file" name="nama_foto" id="file" size="25" /></td>
  		</tr>
  		<tr>
    		<td>Alamat</td>
    		<td colspan="2"><textarea name="alamatsiswa" id="alamatsiswa" rows="2" cols="30" onFocus="showhint('Alamat siswa tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('alamatsiswa')" class="Ukuranketerangan" onKeyUp="change_alamat()"  onKeyPress="return focusNext('kodepos', event)" onblur="unfokus('alamatsiswa')" ><?=$row_siswa['alamatsiswa']?></textarea></td>
  		</tr>
  		<tr>
    		<td>Kode Pos</td>
    		<td colspan="2"><input type="text" name="kodepos" id="kodepos" size="5" maxlength="8" onFocus="showhint('Kodepos tidak boleh lebih dari 8 angka!', this, event, '120px');panggil('kodepos')" value="<?=$row_siswa['kodepossiswa'];?>"  onKeyPress="return focusNext('telponsiswa', event)"  onblur="unfokus('kodepos')"/></td>
  		</tr>
  		<tr>
    		<td>Telepon</td>
    		<td colspan="2"><input type="text" name="telponsiswa" id="telponsiswa" size="20" maxlength="25" onFocus="showhint('Nomor Telepon tidak boleh lebih dari 20 angka!', this, event, '120px');panggil('telponsiswa')" value="<?=$row_siswa['telponsiswa'];?>" class="ukuran"  onKeyPress="return focusNext('hpsiswa', event)" onblur="unfokus('telponsiswa')" /></td>
  		</tr>
  		<tr>
    		<td>Handphone</td>
    		<td colspan="2"><input type="text" name="hpsiswa" id="hpsiswa" size="20" maxlength="25" onFocus="showhint('Nomor ponsel tidak boleh lebih dari 20 angka!', this, event, '120px');panggil('hpsiswa');" value="<?=$row_siswa['hpsiswa'];?>" class="ukuran"  onKeyPress="return focusNext('emailsiswa', event)" onblur="unfokus('hpsiswa')" />      	</td>
  		</tr>
  		<tr>
    		<td>Email</td>
    		<td colspan="2"><input type="text" name="emailsiswa" id="emailsiswa" size="30" maxlength="100" onFocus="showhint('Alamat email tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailsiswa')" value="<?=$row_siswa['emailsiswa']?>"  onKeyPress="return focusNext('dep_asal', event)" onblur="unfokus('emailsiswa')" /></td>
  		</tr>
  		<tr>
    		<td rowspan="2" valign="top">Asal Sekolah</td>
    		<td><!--<div id = "InfoSekolah">-->
			<div id="depInfo">
    		<select name="dep_asal" id="dep_asal" onchange="change_departemen(0)" onKeyPress="return focusNext('sekolah', event)"  style="width:150px;" onfocus="panggil('dep_asal')" onblur="unfokus('dep_asal')">
    		<option value="">[Pilih Departemen]</option>	
			<? // Olah untuk combo departemen
			$sql_departemen="SELECT DISTINCT departemen FROM jbsakad.asalsekolah ORDER BY departemen";   			
			$result_departemen=QueryDB($sql_departemen);
			//$row_departemen = @mysql_fetch_array($result_departemen);
			//$dep_asal = $row_departemen['departemen'];
			//if ($dep_asal == "") 
			//	$dep_asal = $row_departemen['departemen'];
			while ($row_departemen = mysql_fetch_array($result_departemen)) {			
							
			?>
			<option value="<?=$row_departemen['departemen']?>" <?=StringIsSelected($row_departemen['departemen'], $dep_asal)?>><?=$row_departemen['departemen']?></option>
			<? 	} 
			// Akhir Olah Data kondisi
			?>
    		</select></div>            </td>
    		<td></td>
  		</tr>
  		<tr>
        	<td colspan="2">
            <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                <div id="sekolahInfo">
                <select name="sekolah" id="sekolah"  onKeyPress="return focusNext('ketsekolah', event)"  style="width:150px;" onfocus="panggil('sekolah')" onblur="unfokus('sekolah')">
                <option value="">[Pilih Asal Sekolah]</option>	
                <? // Olah untuk combo sekolah
                $sql_sekolah="SELECT sekolah FROM jbsakad.asalsekolah WHERE departemen='$dep_asal' ORDER BY sekolah";
                $result_sekolah=QueryDB($sql_sekolah);
                while ($row_sekolah = mysql_fetch_array($result_sekolah)) {
                     //if ($sekolah=="")
                        //$sekolah=$row_sekolah['sekolah'];
                ?>
                <option value="<?=$row_sekolah['sekolah']?>" <?=StringIsSelected($row_sekolah['sekolah'], $sekolah)?>>
                <?=$row_sekolah['sekolah']?>
                </option>
                <? } 
                // Akhir Olah Data sekolah
                ?>
                </select> </div>                </td>
                <td valign="middle">
                <img src="../images/ico/tambah.png" onclick="tambah_asal_sekolah();" onMouseOver="showhint('Tambah Asal Sekolah!', this, event, '80px')"/>                </td>
            </tr>
            </table>            </td>
		</tr>
 		<tr>
    		<td valign="top">Keterangan Asal <br />Sekolah      </td>
    		<td colspan="2"><textarea name="ketsekolah" id="ketsekolah" onFocus="showhint('Keterangan sekolah asal tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('ketsekolah')" class="Ukuranketerangan"  onKeyPress="return focusNext('gol', event)" onblur="unfokus('ketsekolah')" ><?=$row_siswa['ketsekolah']?></textarea></td>
  		</tr>
		</table>    
		<script language='JavaScript'>
	    	//Tables('table', 1, 0);
		</script>
		</td><!-- Akhir Kolom Kiri-->
    	<td width="1%" align="center" valign="middle"  style="border-left:1px dashed #333333; border-width:thin"></td>
    	<td width="*" valign="top"><!-- Kolom Kanan-->
    	<table width="100%" border="0" cellspacing="0" id="table">
  		<tr>
    		<td height="30" colspan="3" valign="top"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Riwayat Kesehatan</strong></font>
        	<!--hr width="375" style="line-height:1px; border-style:dashed" align="left" color="#000000"/--> 
            <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>
            </td>
    	</tr>
  		<tr>
    		<td width="20%" valign="top">Gol. Darah</td>
    		<td colspan="2">
                <input type="radio" name="gol" id="gol" value="A" <? 
                if ($row_siswa['darah']=="A")
                echo "checked='checked'";
                ?> onKeyPress="return focusNext('berat', event)" />&nbsp;A&nbsp;&nbsp;
                <input type="radio" name="gol" id="gol" value="AB" <? 
                if ($row_siswa['darah']=="AB")
                echo "checked='checked'";
                ?> onKeyPress="return focusNext('berat', event)" />&nbsp;AB&nbsp;&nbsp;
                <input type="radio" name="gol" id="gol" value="B" <? 
                if ($row_siswa['darah']=="B")
                echo "checked='checked'";
                ?> onKeyPress="return focusNext('berat', event)" />&nbsp;B&nbsp;&nbsp;
                <input type="radio" name="gol" id="gol" value="O" <? 
                if ($row_siswa['darah']=="O")
                echo "checked='checked'";
                ?> onKeyPress="return focusNext('berat', event)" />&nbsp;O&nbsp;&nbsp;	
                <input type="radio" name="gol" id="gol" value="" <? 
                if ($row_siswa['darah']=="")
                echo "checked='checked'";
                ?> onKeyPress="return focusNext('berat', event)" />&nbsp;<em>(belum ada data)</em>&nbsp;         	
           	</td>
 		</tr>
  		<tr>
    		<td>Berat</td>
    		<td colspan="2">
            <input name="berat" id="berat" type="text" size="6" maxlength="6" onFocus="showhint('Berat badan tidak boleh lebih dari 6 angka!', this, event, '120px');panggil('berat')" value="<?=$row_siswa['berat']?>" onKeyPress="return focusNext('tinggi', event)" onblur="unfokus('berat')" />&nbsp;kg</td>
  		</tr>
        <tr>
        	<td>Tinggi</td>
          	<td colspan="2"><input name="tinggi" id="tinggi" type="text" size="6" maxlength="6" onFocus="showhint('Tinggi badan tidak boleh lebih dari 6 angka!', this, event, '120px');panggil('tinggi')" value="<?=$row_siswa['tinggi']?>"  onKeyPress="return focusNext('kesehatan', event)" onblur="unfokus('tinggi')"/>
            &nbsp;cm</td>
        </tr>
        <tr>
            <td valign="top">Riwayat Penyakit</td>
            <td colspan="2"><textarea name="kesehatan" id="kesehatan" rows="2" cols="30" class="Ukuranketerangan" onFocus="showhint('Riwayat penyakit tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('kesehatan')"  onKeyPress="return focusNext('namaayah', event)" onblur="unfokus('kesehatan')"><?=$row_siswa['kesehatan']?></textarea></td>
        </tr>
  		<tr>
    		<td height="30" colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Orang Tua</strong></font>
            <!--hr width="375" style="line-height:1px; border-style:dashed" align="left" color="#000000" /-->
            <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>
            </td>
    	</tr>
  		<tr>
    		<td>&nbsp;</td>
    		<td align="center" valign="middle" bgcolor="#DBD8F3"><strong>Ayah</strong></td>
    		<td align="center" valign="middle" bgcolor="#E9AFCF"><strong>Ibu</strong></td>
  		</tr>
  		<tr>
            <td valign="top">Nama</td>
            <td bgcolor="#DBD8F3"><input name="namaayah" type="text" size="15" maxlength="100" id="namaayah" onFocus="showhint('Nama Ayah tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('namaayah')"  value="<?=$row_siswa['namaayah']?>" class="ukuran"  onKeyPress="return focusNext('namaibu', event)" onblur="unfokus('namaayah')" />
            	<br />
                <input type="checkbox" name="almayah" id="almayah" value="1" title="Klik disini jika Ayah Almarhum"  
        		<? if ($row_siswa['almayah']=="1") echo "checked";?> />
                &nbsp;&nbsp;<font color="#990000" size="1">(Almarhum)</font> </td>
          	<td colspan="2" bgcolor="#E9AFCF"><input name="namaibu" type="text" size="15" maxlength="100" id="namaibu" onFocus="showhint('Nama Ibu tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('namaibu')" value="<?=$row_siswa['namaibu']?>" class="ukuran"  onKeyPress="return focusNext('Infopendidikanayah', event)" onblur="unfokus('namaibu')" />
            	<br />
                <input type="checkbox" name="almibu" id="almibu" value="1" title="Klik disini jika Ibu Almarhumah"
        		<? if ($row_siswa['almibu']=="1") echo "checked";?>/>
                &nbsp;&nbsp;<font color="#990000" size="1">(Almarhumah)</font> </td>
        </tr>
  		<tr>
    		<td>Pendidikan</td>
    		<td bgcolor="#DBD8F3">
            <div id = "pendidikanayahInfo">			
			<select name="pendidikanayah" id="Infopendidikanayah" class="ukuran"  onKeyPress="return focusNext('Infopendidikanibu', event)" onfocus="panggil('Infopendidikanayah')" style="width:140px" onblur="unfokus('Infopendidikanayah')">
      		<option value="">[Pilih Pendidikan]</option>
			<? // Olah untuk combo pendidikan ayah
			$sql_pend_ayah="SELECT pendidikan FROM jbsumum.tingkatpendidikan ORDER BY pendidikan";
			$result_pend_ayah=QueryDB($sql_pend_ayah);
			while ($row_pend_ayah = mysql_fetch_array($result_pend_ayah)) {
			?>
      		<option value="<?=$row_pend_ayah['pendidikan']?>" <?=StringIsSelected($row_pend_ayah['pendidikan'], $row_siswa['pendidikanayah'])?>><?=$row_pend_ayah['pendidikan']?></option>
      		<?
    		} 
			// Akhir Olah Data sekolah
			?>
    		</select>
            </div>
            </td>
    		<td bgcolor="#E9AFCF">	
            <table cellpadding="0" cellspacing="0">
            	<tr>
                	<td>
                    <div id = "pendidikanibuInfo">		
                    <select name="pendidikanibu" id="Infopendidikanibu" class="ukuran"  onKeyPress="return focusNext('Infopekerjaanayah', event)" onfocus="panggil('Infopendidikanibu')" style="width:140px" onblur="unfokus('Infopendidikanibu')">
                    <option value="">[Pilih Pendidikan]</option>
                    <? // Olah untuk combo sekolah
                    $sql_pend_ibu="SELECT pendidikan FROM jbsumum.tingkatpendidikan ORDER BY pendidikan";
                    $result_pend_ibu=QueryDB($sql_pend_ibu);
                    while ($row_pend_ibu = mysql_fetch_array($result_pend_ibu)) {
                    ?>
                    <option value="<?=$row_pend_ibu['pendidikan']?>" <?=StringIsSelected($row_pend_ibu['pendidikan'], $row_siswa['pendidikanibu'])?>><?=$row_pend_ibu['pendidikan']?></option>
                    <?
                    } 
                    // Akhir Olah Data sekolah
                    ?>
                    </select>
                    </div>
                    </td>
                    <td>
					<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
                    <img src="../images/ico/tambah.png" onclick="tambah_pendidikan();" onMouseOver="showhint('Tambah Tingkat Pendidikan!', this, event, '80px')" />
                    <? } ?>
                    </td>
             	</tr>
                </table>
            </td>
  		</tr>
  		<tr>
    		<td>Pekerjaan</td>
    		<td bgcolor="#DBD8F3">
			<div id = "pekerjaanayahInfo">
			<select name="pekerjaanayah" id="Infopekerjaanayah" class="ukuran"  onKeyPress="return focusNext('Infopekerjaanibu', event)" onfocus="panggil('Infopekerjaanayah')" style="width:140px" onblur="unfokus('Infopekerjaanayah')">
      		<option value="">[Pilih Pekerjaan]</option>
			<? // Olah untuk combo sekolah
			$sql_kerja_ayah="SELECT pekerjaan FROM jbsumum.jenispekerjaan ORDER BY pekerjaan";
			$result_kerja_ayah=QueryDB($sql_kerja_ayah);
			while ($row_kerja_ayah = mysql_fetch_array($result_kerja_ayah)) {
			?>
      		<option value="<?=$row_kerja_ayah['pekerjaan']?>" <?=StringIsSelected($row_kerja_ayah['pekerjaan'], $row_siswa['pekerjaanayah'])?>><?=$row_kerja_ayah['pekerjaan']?></option>
      		<?
    		} 
			// Akhir Olah Data sekolah
			?>
   		 	</select>
            </div>
            </td>
    		<td bgcolor="#E9AFCF">
            <table cellpadding="0" cellspacing="0">
            	<tr>
                	<td>
                    <div id = "pekerjaanibuInfo">			
                    <select name="pekerjaanibu" id="Infopekerjaanibu" class="ukuran"  onKeyPress="return focusNext('penghasilanayah1', event)" onfocus="panggil('Infopekerjaanibu')" style="width:140px" onblur="unfokus('Infopekerjaanibu')">
                    <option value="">[Pilih Pekerjaan]</option>
                    <? // Olah untuk combo sekolah
                    $sql_kerja_ibu="SELECT pekerjaan FROM jbsumum.jenispekerjaan ORDER BY pekerjaan";
                    $result_kerja_ibu=QueryDB($sql_kerja_ibu);
                    while ($row_kerja_ibu = mysql_fetch_array($result_kerja_ibu)) {
                    ?>
                    <option value="<?=$row_kerja_ibu['pekerjaan']?>" <?=StringIsSelected($row_kerja_ibu['pekerjaan'], $row_siswa['pekerjaanibu'])?>><?=$row_kerja_ibu['pekerjaan']?></option>
                    <?
                    } 
                    // Akhir Olah Data sekolah
                    ?>
                    </select>
                    </div>
                    </td>
                    <td>
					 <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
                    <img src="../images/ico/tambah.png" onclick="tambah_pekerjaan();" onMouseOver="showhint('Tambah Jenis Pekerjaan!', this, event, '80px')" />
                    <? } ?>
                    </td>
              	</tr>
                </table>
            </td>
  		</tr>
  		<tr>
    		<td>Penghasilan</td>
    		<td bgcolor="#DBD8F3">
			<input type="text" name="penghasilanayah1" id="penghasilanayah1" size="15" maxlength="20" value="<?=FormatRupiah($row_siswa['penghasilanayah'])?>" onblur="formatRupiah('penghasilanayah1');unfokus('penghasilanayah1')" onfocus="unformatRupiah('penghasilanayah1');panggil('penghasilanayah1')" class="ukuran"  onKeyPress="return focusNext('penghasilanibu1', event)" onKeyUp="penghasilan_ayah()">
			<input type="hidden" name="penghasilanayah" id="penghasilanayah" value = "<?=$row_siswa['penghasilanayah'] ?>">
			</td>
    		<td bgcolor="#E9AFCF">
			<input type="text" name="penghasilanibu1" id="penghasilanibu1" size="15" maxlength="20" value="<?=FormatRupiah($row_siswa['penghasilanibu']) ?>" onblur="formatRupiah('penghasilanibu1');unfokus('penghasilanibu1')" onfocus="unformatRupiah('penghasilanibu1');panggil('penghasilanibu1')" class="ukuran"  onKeyPress="return focusNext('emailayah', event)" onKeyUp="penghasilan_ibu()" />
			<input type="hidden" name="penghasilanibu" id="penghasilanibu" value="<?=$row_siswa['penghasilanibu'] ?>"  >
			</td>
  		</tr>
        <tr>
          <td>Email Ortu</td>
          <td bgcolor="#DBD8F3"><input name="emailayah" type="text" size="15" maxlength="100" id="emailayah" onFocus="showhint('Alamat email Ayah tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailayah')" value="<?=$row_siswa['emailayah']?>" class="ukuran" onKeyPress="return focusNext('emailibu', event)" onblur="unfokus('emailayah')" /></td>
          <td colspan="2" bgcolor="#E9AFCF"><input name="emailibu" type="text" size="15" maxlength="100" id="emailibu" onFocus="showhint('Alamat email Ibu tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailibu')" value="<?=$row_siswa['emailibu']?>" class="ukuran" onKeyPress="return focusNext('namawali', event)" onblur="unfokus('emailibu')" /></td>
        </tr>
  		<tr>
    		<td>Nama Wali</td>
    		<td colspan="2">
            <input type="text" name="namawali" id="namawali" size="30" maxlength="100" value="<?=$row_siswa['wali']?>"  onKeyPress="return focusNext('alamatortu', event)" onfocus="panggil('namawali')" onblur="unfokus('namawali')" ></td>
  		</tr>
  		<tr>
    		<td valign="top">Alamat Ortu</td>
    		<td colspan="2">
            <textarea name="alamatortu" id="alamatortu" size="25" maxlength="100" class="Ukuranketerangan"  onKeyPress="return focusNext('telponortu', event)" onfocus="panggil('alamatortu')" onblur="unfokus('alamatortu')" ><?=$row_siswa['alamatortu']?></textarea><br /></td>
  		</tr>
  		<tr>
    		<td>Telepon Ortu</td>
    		<td colspan="2">
            <input type="text" name="telponortu" id="telponortu" class="ukuran" maxlength="20" value="<?=$row_siswa['telponortu']?>"  onKeyPress="return focusNext('hportu', event)" onfocus="panggil('telponortu')" onblur="unfokus('telponortu')"/>
            </td>
  		</tr>
  		<tr>
    		<td>HP Ortu #1</td>
    		<td align="left">
				<input type="text" name="hportu" id="hportu" class="ukuran" maxlength="20" value="<?=$row_siswa['hportu']?>"  onKeyPress="return focusNext('hportu2', event)" onfocus="panggil('hportu')" onblur="unfokus('hportu')" />
            </td>
			<td rowspan="3" align="left" valign="top">
				<font style="color: blue; font-style: italic">tambahkan # supaya tidak digunakan di JIBAS SMS Gateway. contoh: #08123456789</font>	
			</td>
  		</tr>
		<tr>
    		<td>HP Ortu #2</td>
    		<td align="left">
				<input type="text" name="hportu2" id="hportu2" class="ukuran" maxlength="20" value="<?=$row_siswa['info1']?>"  onKeyPress="return focusNext('hportu3', event)" onfocus="panggil('hportu2')" onblur="unfokus('hportu2')" />
            </td>
  		</tr>
		<tr>
    		<td>HP Ortu #3</td>
    		<td align="left">
				<input type="text" name="hportu3" id="hportu3" class="ukuran" maxlength="20" value="<?=$row_siswa['info2']?>"  onKeyPress="return focusNext('alamatsurat', event)" onfocus="panggil('hportu3')" onblur="unfokus('hportu3')" />
            </td>
  		</tr>
  		<tr>
    		<td height="30" colspan="3"><font size="3" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="3" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Lainnya</strong></font>
             <!--hr width="375" style="line-height:1px; border-style:dashed" align="left" color="#000000" /-->
             <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>
             </td>
    	</tr>
  		<tr>
    		<td valign="top">Alamat Surat</td>
    		<td colspan="2"><textarea name="alamatsurat" id="alamatsurat" size="35" maxlength="100" class="Ukuranketerangan"  onKeyPress="return focusNext('keterangan', event)" onfocus="panggil('alamatsurat')" onblur="unfokus('alamatsurat')"><?=$row_siswa['alamatsurat']?></textarea></td>
  		<tr>
    		<td valign="top">Keterangan</td>
    		<td colspan="2"><textarea name="keterangan" id="keterangan" rows="2" cols="30" class="Ukuranketerangan" onKeyPress="return focusNext('sum1', event)" onfocus="panggil('keterangan')" onblur="unfokus('keterangan')"><?=$row_siswa['keterangan']?></textarea></td>
  		</tr>
		</table>    
		<script language='JavaScript'>
	    	//Tables('table', 1, 0);
		</script>
		</td><!-- Akhir Kolom Kanan-->	
    </tr>
    <tr>
    <td colspan="3" align="left">
    
    <?
	$sqlset = "SELECT COUNT(replid) FROM settingpsb WHERE idproses = $proses";
	$resset = QueryDb($sqlset);
	$rowset = mysql_fetch_row($resset);
	$ndata = $rowset[0];
	
	if ($ndata > 0)
	{
		$sqlset = "SELECT * FROM settingpsb WHERE idproses = $proses";
		$resset = QueryDb($sqlset);
		$rowset = mysql_fetch_array($resset);
		
		$kdsum1 = $rowset['kdsum1']; //$nmsum1 = $rowset['nmsum1'];
		$kdsum2 = $rowset['kdsum2']; //$nmsum2 = $rowset['nmsum2'];
		$kdujian1 = $rowset['kdujian1']; //$nmujian1 = $rowset['nmujian1'];
		$kdujian2 = $rowset['kdujian2']; //$nmujian2 = $rowset['nmujian2'];
		$kdujian3 = $rowset['kdujian3']; //$nmujian3 = $rowset['nmujian3'];
		$kdujian4 = $rowset['kdujian4']; //$nmujian4 = $rowset['nmujian4'];
		$kdujian5 = $rowset['kdujian5']; //$nmujian5 = $rowset['nmujian5'];
	}
?>
    
    <br />
    <table border="0" cellpadding="2" cellspacing="0" style="background-color:#FFFFF2">
    <tr>
    	<td width="170" align="left">Sumbangan #1 (<?=$kdsum1?>):</td>
        <td width="40" align="left">
        <input type="text" name="sum1" id="sum1" size="10" maxlength="15"
	        value="<?= FormatRupiah($sum1) ?>" onblur="formatRupiah('sum1')" onKeyPress="return focusNext('sum2', event)" onfocus="unformatRupiah('sum1')" /> </td>
        <td width="170" align="left">Sumbangan #2 (<?=$kdsum2?>):</td>
        <td width="40" align="left"><input type="text" name="sum2" id="sum2" onKeyPress="return focusNext('ujian1', event)" size="10" maxlength="15"
	        value="<?= FormatRupiah($sum2) ?>" onblur="formatRupiah('sum2')" onfocus="unformatRupiah('sum2')" /> </td>
    </tr>
    </table>
    <br />
    <table border="0" cellpadding="2" cellspacing="0" style="background-color:#FFFFF2">
    <tr>
        <td width="120" align="left">Ujian #1 (<?=$kdujian1?>):</td>
        <td width="30" align="left"><input type="text" name="ujian1" id="ujian1" onKeyPress="return focusNext('ujian2', event)" value="<?=$ujian1?>" size="5" maxlength="5" /> </td>
        <td width="120" align="left">Ujian #2 (<?=$kdujian2?>):</td>
        <td width="30" align="left"><input type="text" name="ujian2" id="ujian2" onKeyPress="return focusNext('ujian3', event)" value="<?=$ujian2?>" size="5" maxlength="5" /> </td>   
        <td width="120" align="left">Ujian #3 (<?=$kdujian3?>):</td>
        <td width="30" align="left"><input type="text" name="ujian3" id="ujian3" onKeyPress="return focusNext('ujian4', event)" value="<?=$ujian3?>" size="5" maxlength="5" /> </td>   
    </tr>
    <tr>    
        <td width="120" align="left">Ujian #4 (<?=$kdujian4?>):</td>
        <td width="30" align="left"><input type="text" name="ujian4" id="ujian4" onKeyPress="return focusNext('ujian5', event)" value="<?=$ujian4?>" size="5" maxlength="5" /> </td>
        <td width="120" align="left">Ujian #5 (<?=$kdujian5?>):</td>
        <td width="30" align="left"><input type="text" name="ujian5" id="ujian5" onKeyPress="return focusNext('Simpan', event)" value="<?=$ujian5?>" size="5" maxlength="5" /> </td>
        <td width="120" align="left">&nbsp;</td>
        <td width="30" align="left">&nbsp;</td>
    </tr>
    </table>
    
    </td>
    </tr>
	<tr height="50">	
		<td valign="middle" align="right">     
        <input type="Submit" value="Simpan" name="Simpan" class="but" onfocus="panggil('Simpan')" onblur="unfokus('Simpan')" />
       <!-- <input type="button" value="Simpan" name="Simpan" class="but" onfocus="panggil('Simpan')" />-->
        </td>
  		<td align="center" valign="middle"></td>
  		<td valign="middle"><input class="but" type="button" value="Tutup" name="Tutup"  onClick="tutup()" />
  		</td>           
	</tr>
	</table>
	
   	</td>
</tr>
</table>
</form>
  	</td>
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_06a.jpg">&nbsp;</td>
</tr>
<tr height="28">
	<td width="28" background="../<?=GetThemeDir() ?>bgpop_07.jpg">&nbsp;</td>
    <td width="*" background="../<?=GetThemeDir() ?>bgpop_08a.jpg">&nbsp;</td>
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_09.jpg">&nbsp;</td>
</tr>
</table>
</body>
</html>
<?
CloseDb();
?>