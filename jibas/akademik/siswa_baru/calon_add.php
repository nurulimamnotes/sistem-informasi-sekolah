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

$warga = "WNI";
$urutananak = "1";
$jumlahanak = "1";

$berat = "0";
$tinggi = "0";
$penghasilanayah = "0";
$penghasilanibu = "0";

$n = JmlHari($blnlahir, $thnlahir);

$departemen=$_REQUEST['departemen'];
$proses=$_REQUEST['proses'];
$kelompok=$_REQUEST['kelompok'];

OpenDb();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../style/style.css">
<link rel="stylesheet" type="text/css" href="../style/tooltips.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JIBAS SIMAKA [Tambah Calon Siswa]</title>
<script language="javascript" src="../script/tables.js"></script>
<script language="javascript" src="../script/tools.js"></script>
<script language="javascript" src="../script/rupiah.js"></script>
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
	var file=document.getElementById("file").value;
	
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
			document.main.thnlahir.value="";
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
		if (isNaN(urutananak)) {
			alert ('Data isian anak ke harus berupa bilangan!');
			document.getElementById('urutananak').focus();
			return false;
		}
		
		if (urutananak == 0) {
			alert("Urutan Anak harus lebih besar dari 0!");
			document.getElementById('urutananak').focus();
			return false;
		}
		
		if (jumlahanak.length == 0) {
			alert("Anda harus mengisikan data untuk Jumlah Saudara!");
			document.getElementById('jumlahanak').focus();
			return false;
		}
	} else {
		alert("Anda harus mengisikan data untuk Urutan Anak!");
		document.getElementById('urutananak').focus();
		return false;
	}
	
	if (jumlahanak.length > 0){
		if(isNaN(jumlahanak)) {
			alert ('Data jumlah anak harus berupa bilangan!');		
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
			alert ('Data berat harus berupa bilangan!');
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
			alert ('Data penghasilan Ibu harus berupa bilangan');
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


function change_bln() {	
	//alert ('Masuk');
	var thn = document.getElementById('thnlahir').value;
	var bln = parseInt(document.getElementById('blnlahir').value);	
	var tgl = parseInt(document.getElementById('tgllahir').value);
	var namatgl = "tgllahir";
	var namabln = "blnlahir";
	
	if(thn.length != 0) {
    	if(isNaN(thn)) {
    		alert("Tahun lahir harus berupa angka!"); 
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
	//setTimeout("change_departemen(0)",1);
	
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
	parent.opener.refresh();
	window.close();
}

//Ajax suku ==========================================================
function suku_kiriman(suku_kiriman) {	
	suku = suku_kiriman
	//suku_kiriman2=suku_kiriman;
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
	//refresh_pendidikan(pendidikan);
	//pendidikan=pendidikan_kiriman;
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
	//refresh_pekerjaan(kerja);	
	setTimeout("refresh_pekerjaan(kerja)",1);
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

function change_tgl() {	
	var thn = document.getElementById('thnlahir').value;
	var bln = parseInt(document.getElementById('blnlahir').value);	
	var tgl = parseInt(document.main.tgllahir.value);
	
	if(thn.length == 0) {
		alert("Anda harus mengisikan data untuk Tahun Lahir!");
		document.main.blnlahir.value = "";
		document.main.thnlahir.focus();
        return false;
	} else {	
		if(isNaN(thn)) {
    		alert("Tahun lahir harus berupa angka!"); 
			document.main.thnlahir.focus();
        	return false;
		} else {	
			if (thn.length > 4 || thn.length < 4) {
            	alert("Tahun lahir tidak boleh lebih atau kurang dari 4 karakter!"); 
				document.main.thnlahir.focus();
            	return false;
			}
		}
    }
	var namatgl = "tgllahir";
	var namabln = "blnlahir";

	sendRequestText("../library/gettanggal.php", show1, "tahun="+thn+"&bulan="+bln+"&tgl="+tgl+"&namatgl="+namatgl+"&namabln="+namabln);	
}

function show1(x) {
	document.getElementById("tgl_info").innerHTML = x;
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
	/*
	var lain = new Array('nama','panggilan','tmplahir','thnlahir','urutananak','jumlahanak','bahasa','kodepos','telponsiswa','hpsiswa','emailsiswa','berat','tinggi','namaayah','namaibu','penghasilanayah1','penghasilanibu1','namawali','telponortu','hportu','emailortu','alamatsiswa','ketsekolah','kesehatan','alamatortu','alamatsurat','keterangan','tgllahir','blnlahir','suku','agama','status','kondisi','dep_asal','sekolah','Infopendidikanayah','Infopendidikanibu','Infopekerjaanayah','Infopekerjaanibu');
	
	for (i=0;i<lain.length;i++) {
		if (lain[i] == elem) {
			document.getElementById(elem).style.background='#4cff15';
		} else {
			document.getElementById(lain[i]).style.background='#FFFFFF';
		}
	}
	*/
	document.getElementById(elem).style.background='#4cff15';
}

function unfokus(elem){
	document.getElementById(elem).style.background='#FFFFFF';
}

function penghasilan_ayah(){	
	var ayah = document.getElementById("penghasilanayah1").value;
	document.getElementById("penghasilanayah").value=ayah;
}
function penghasilan_ibu(){	
	var ibu = document.getElementById("penghasilanibu1").value;
	document.getElementById("penghasilanibu").value=ibu;
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
    .: Tambah Data Calon Siswa :.
    </div>
	</td>
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_03.jpg">&nbsp;</td>
</tr>
<tr height="150">
    <td width="28" background="../<?=GetThemeDir() ?>bgpop_04a.jpg">&nbsp;</td>
    <td width="0" style="background-color:#FFFFFF">
    <!-- CONTENT GOES HERE //--->
   	<!--<form name="main" method="post" enctype="multipart/form-data" onSubmit="return validate()">-->
    <form name="main" method="post" action="calon_simpan.php" onSubmit="return validate()" enctype="multipart/form-data"><!---->
    <input type="hidden" name="proses" id="proses" value="<?=$proses?>" />
    <input type="hidden" name="kelompok" id="kelompok" value="<?=$kelompok?>" />
    <input type="hidden" name="departemen" id="departemen" value="<?=$departemen?>" />
    <input type="hidden" name="no" id="no" value="0" />
    <input type="hidden" name="tahunmasuk" id="tahunmasuk" value="<?=date(Y)?>" />
    
    <table width="100%" border="0" cellspacing="0">
    <tr>
    	<td width="45%" valign="top"><!-- Kolom Kiri-->
        <table width="100%" border="0" cellspacing="0" id="table">
        <tr>
        	<td height="30" colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Pribadi Calon Siswa</strong></font>
          	<!--hr width="300" style="line-height:1px; border-style:dashed" align="left" color="#000000" /-->
            <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>            </td>
        </tr>
        <tr>
          <td>N I S N</td>
          <td colspan="2"><input type="text" name="nisn" id="nisn" size="30" maxlength="50"  value="<?=$nisn?>" onfocus="panggil('nisn');" onKeyPress="return focusNext('nama', event)" onblur="unfokus('nisn')"/></td>
        </tr>
        <tr>
          	<td width="22%"><strong>Nama</strong></td>
          	<td colspan="2">
          	<input type="text" name="nama" id="nama" size="30" maxlength="100"  value="<?=$nama?>" onfocus="showhint('Nama Lengkap Siswa tidak boleh kosong!', this, event, '120px');panggil('nama');" onKeyPress="return focusNext('panggilan', event)" onblur="unfokus('nama')"/>          	</td>
        </tr>
        <tr>
          	<td>Panggilan</td>
          	<td colspan="2">
          	<input type="text" name="panggilan" id="panggilan" size="30" maxlength="30" onFocus="showhint('Nama Panggilan tidak boleh lebih dari 30 karakter!', this, event, '120px');panggil('panggilan');" value="<?=$panggilan?>" onKeyPress="return focusNext('kelamin', event)" onblur="unfokus('panggilan')"/>          	</td>
        </tr>
        <tr>
          	<td><strong>Jenis Kelamin</strong></td>
          	<td colspan="2"><input type="radio" name="kelamin"  id="kelamin" value="l" 
		<? if ($kelamin=="l") 
            echo "checked='checked'";
        else
            echo "checked='checked'"; 
        ?> onKeyPress="return focusNext('tmplahir', event)"/>&nbsp;Laki-laki&nbsp;&nbsp;
                    <input type="radio" name="kelamin" value="p"
        <? if ($kelamin=="p") 
            echo "checked='checked'";
        ?> onKeyPress="return focusNext('tmplahir', event)"/>&nbsp;Perempuan</td>
        </tr>
        <tr>
          	<td><strong>Tempat Lahir</strong></td>
          	<td colspan="2">
          	<input type="text" name="tmplahir" id="tmplahir" size="30" maxlength="50" onFocus="showhint('Tempat Lahir tidak boleh kosong!', this, event, '120px');panggil('tmplahir');" value="<?=$tmplahir?>" onKeyPress="return focusNext('tgllahir', event)" onblur="unfokus('tmplahir')"/>            </td>
        </tr>
        <tr>
          	<td><strong>Tanggal Lahir</strong></td>
          	<td colspan="2">
          		<table cellpadding="0" cellspacing="0" border="0">
                <tr>
                	<td>
                    <div id="tgl_info">
                    <select name="tgllahir" id="tgllahir" onKeyPress="return focusNext('blnlahir', event)" onFocus="panggil('tgllahir')" onblur="unfokus('tgllahir')">
                    <option value="">[Tgl]</option>  
                    <? 	for ($tgl=1;$tgl<=$n;$tgl++){ ?>
                        <option value="<?=$tgl?>" <?=IntIsSelected($tgllahir, $tgl)?>><?=$tgl?></option>
                    <?	}	?>
                    </select>
                    </div>                	</td>
                    <td>
                    <select name="blnlahir" id="blnlahir" onChange="change_bln()" onKeyPress="return focusNext('thnlahir', event)" onFocus="panggil('blnlahir')" onblur="unfokus('blnlahir')">
                    <option value="">[Bulan]</option>
                    <? 	for ($i=1;$i<=12;$i++) { ?>
                        <option value="<?=$i?>" <?=IntIsSelected($blnlahir, $i)?>><?=NamaBulan($i)?></option>	
                    <?	} ?>
                    </select>
                    <input type="text" name="thnlahir" id="thnlahir" size="5" maxlength="4" onFocus="showhint('Tahun Lahir tidak boleh kosong!', this, event, '120px');panggil('thnlahir');" value="<?=$thnlahir?>" onKeyPress="return focusNext('agama', event)" onblur="unfokus('thnlahir')"/>                	</td>
                </tr>
            	</table>        	</td>
        </tr>
        <tr>
          	<td><strong>Agama</strong></td>
          	<td colspan="2">
            	<div id="InfoAgama">
            	<select name="agama" id="agama" value="<?=$agama?>" class="ukuran" onKeyPress="return focusNext('suku', event)" onfocus="panggil('agama')" onblur="unfokus('agama')">
                <option value="">[Pilih Agama]</option>
                <? // Olah untuk combo agama
				$sql_agama="SELECT replid,agama,urutan FROM jbsumum.agama ORDER BY urutan";
				$result_agama=QueryDB($sql_agama);
				while ($row_agama = mysql_fetch_array($result_agama)) {
				?>
                <option value="<?=$row_agama['agama']?>"<?=StringIsSelected($row_agama[agama],$agama)?>>
                <?=$row_agama['agama']?>
                </option>
                <?
				} 
				// Akhir Olah Data agama
				?>
                </select>
              	<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            	<img src="../images/ico/tambah.png" onClick="tambah_agama();" onMouseOver="showhint('Tambah Agama!', this, event, '50px')"/>
            	<? } ?>
          		</div>          	</td>
		</tr>
        <tr>
          	<td><strong>Suku</strong></td>
          	<td colspan="2"><div id="InfoSuku">
            	<select name="suku" id="suku" class="ukuran" onKeyPress="return focusNext('status', event)" onfocus="panggil('suku')" onblur="unfokus('suku')">
              	<option value="">[Pilih Suku]</option>
                <? // Olah untuk combo suku
				$sql_suku="SELECT suku,urutan,replid FROM jbsumum.suku ORDER BY urutan";
				$result_suku=QueryDB($sql_suku);
				while ($row_suku = mysql_fetch_array($result_suku)) {
					//if($suku == "")
					//	$suku = $row_suku[suku] ;  
				?>
                <option value="<?=$row_suku['suku']?>"<?=StringIsSelected($row_suku[suku],$suku)?>>
                <?=$row_suku['suku']?>
                </option>
                <?
				} 
				// Akhir Olah Data suku
				?>
              	</select>
              	<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            	<img src="../images/ico/tambah.png" onClick="tambah_suku();" onMouseOver="showhint('Tambah Suku!', this, event, '50px')" />
            	<? } ?></div>        	</td>
   		</tr>
        <tr>
          	<td><strong>Status</strong></td>
          	<td colspan="2"><div id="InfoStatus">
              	<select name="status" id="status" class="ukuran" onKeyPress="return focusNext('kondisi', event)"onfocus="panggil('status')" onblur="unfokus('status')">
              	<option value="">[Pilih Status]</option>
                <? // Olah untuk combo status
				$sql_status="SELECT replid,status,urutan FROM jbsakad.statussiswa ORDER BY urutan";
				$result_status=QueryDB($sql_status);
				while ($row_status = mysql_fetch_array($result_status)) {
					//if ($status=="")
					//	$status=$row_status;
				?>
                <option value="<?=$row_status['status']?>"<?=StringIsSelected($row_status[status],$status)?>>
                <?=$row_status['status']?>
                </option>
                <?
				} 
				// Akhir Olah Data status
				?>
              	</select>
              	<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            	<img src="../images/ico/tambah.png" onClick="tambah_status();" onMouseOver="showhint('Tambah Status!', this, event, '50px')"/>
            	<? } ?>
          		</div></td>
		</tr>
        <tr>
          	<td><strong>Kondisi</strong></td>
          	<td colspan="2"><div id="InfoKondisi">
              	<select name="kondisi" id="kondisi" class="ukuran" onKeyPress="return focusNext('warga', event)" onfocus="panggil('kondisi')" onblur="unfokus('kondisi')">
              	<option value="">[Pilih Kondisi]</option>
                <? // Olah untuk combo kondisi
				$sql_kondisi="SELECT kondisi,urutan FROM jbsakad.kondisisiswa ORDER BY urutan";
				$result_kondisi=QueryDB($sql_kondisi);
				while ($row_kondisi = mysql_fetch_array($result_kondisi)) {
					//if ($kondisi=="")
					//	$kondisi=$row_kondisi;
				?>
                <option value="<?=$row_kondisi['kondisi']?>"<?=StringIsSelected($row_kondisi['kondisi'],$kondisi)?>>
                <?=$row_kondisi['kondisi']?>
                </option>
                <?
				} 
				// Akhir Olah Data kondisi
				?>
              	</select>
              	<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
            	<img src="../images/ico/tambah.png" onClick="tambah_kondisi();" onMouseOver="showhint('Tambah Kondisi!', this, event, '50px')"/>
            	<? } ?>
          		</div></td>
        </tr>
        <tr>
          	<td>Kewarganegaraan</td>
          	<td colspan="2">
            <input type="radio" name="warga" id="warga" value="WNI"  
			<? if ($warga=="WNI" || $warga=="") 
                echo "checked='checked'"; 
            ?> onKeyPress="return focusNext('urutananak', event)" />&nbsp;WNI&nbsp;&nbsp;
            <input type="radio" name="warga"  id="warga" value="WNA" 
            <? if ($warga=="WNA") 
            echo "checked='checked'";
            ?> onKeyPress="return focusNext('urutananak', event)"/>&nbsp;WNA</td>
      	</tr>
        <tr>
          	<td>Anak ke</td>
          	<td colspan="2">
          	<input type="text" name="urutananak" id="urutananak" size="3" maxlength="3" onFocus="showhint('Urutan anak tidak boleh lebih dari 3 angka!', this, event, '120px');panggil('urutananak');" value="<?=$urutananak?>" onKeyPress="return focusNext('jumlahanak', event)" onblur="unfokus('urutananak')"/>
            &nbsp;dari&nbsp;
            <input type="text" name="jumlahanak" id="jumlahanak" size="3" maxlength="3" onFocus="showhint('Jumlah saudara tidak boleh lebih dari 3 angka!', this, event, '120px');panggil('jumlahanak');" value="<?=$jumlahanak?>" onKeyPress="return focusNext('bahasa', event)" onblur="unfokus('jumlahanak')"/>
            &nbsp;bersaudara</td>
        </tr>
        <tr>
          	<td>Bahasa</td>
          	<td colspan="2">
          	<input type="text" name="bahasa" id="bahasa" size="30" maxlength="60" onFocus="showhint('Bahasa anak tidak boleh lebih dari 60 karakter!', this, event, '120px');panggil('bahasa')" value="<?=$bahasa?>" onKeyPress="return focusNext('alamatsiswa', event)" onblur="unfokus('bahasa')"/>          	</td>
        </tr>
        <tr>
          	<td>Foto</td>
          	<td colspan="2">
            <input type="file" id="file" name="nama_foto" style="width:215px" size="25" /></td>
        </tr>
        <tr>
          	<td valign="top">Alamat</td>
          	<td colspan="2">
          	<textarea name="alamatsiswa" id="alamatsiswa" rows="2" cols="30" onKeyUp="change_alamat()" class="Ukuranketerangan" onFocus="showhint('Alamat calon siswa tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('alamatsiswa')" onKeyPress="return focusNext('kodepos', event)" onblur="unfokus('alamatsiswa')"><?=$alamatsiswa?></textarea>          	</td>
        </tr>
        <tr>
          	<td>Kode Pos</td>
          	<td colspan="2">
          	<input type="text" name="kodepos" id="kodepos" size="5" maxlength="8" onFocus="showhint('Kodepos tidak boleh lebih dari 8 angka!', this, event, '120px');panggil('kodepos')" value="<?=$kodepos?>" onKeyPress="return focusNext('telponsiswa', event)" onblur="unfokus('kodepos')"/>          	</td>
        </tr>
        <tr>
          	<td>Telepon</td>
          	<td colspan="2">
          	<input type="text" name="telponsiswa" id="telponsiswa" class="ukuran" maxlength="20" onFocus="showhint('Nomor Telepon tidak boleh lebih dari 20 angka!', this, event, '120px');panggil('telponsiswa')" value="<?=$telponsiswa?>" onKeyPress="return focusNext('hpsiswa', event)" onblur="unfokus('telponsiswa')"/>          	</td>
        </tr>
        <tr>
          	<td>Handphone</td>
          	<td colspan="2">
				<input type="text" name="hpsiswa" id="hpsiswa" class="ukuran" maxlength="30" onfocus="showhint('Nomor ponsel tidak boleh lebih dari 20 angka!', this, event, '120px');panggil('hpsiswa')" value="<?=$hpsiswa?>" onkeypress="return focusNext('emailsiswa', event)" onblur="unfokus('hpsiswa')"/>
			</td>
        </tr>
        <tr>
          	<td>Email</td>
          	<td colspan="2">
          <input type="text" name="emailsiswa" id="emailsiswa" size="30" maxlength="100" onFocus="showhint('Alamat email tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailsiswa')" value="<?=$emailsiswa?>" onKeyPress="return focusNext('dep_asal', event)" onblur="unfokus('emailsiswa')"/>          	</td>
        </tr>
        
      	<tr>
       		<td rowspan="2" valign="top">Asal Sekolah</td>
          	<td>
            <div id="depInfo">                                
            <select name="dep_asal" id="dep_asal" onChange="change_departemen(0)" onKeyPress="return focusNext('sekolah', event)" style="width:150px;" onfocus="panggil('dep_asal')" onblur="unfokus('dep_asal')">
            	<option value="">[Pilih Departemen]</option>	
				<? // Olah untuk combo departemen    
         		$sql_departemen="SELECT DISTINCT departemen FROM jbsakad.asalsekolah ORDER BY departemen";      
				$result_departemen=QueryDB($sql_departemen);
				while ($row_departemen = mysql_fetch_array($result_departemen)) {                
               ?>
                 <option value="<?=$row_departemen['departemen']?>" <?=StringIsSelected($row_departemen['departemen'], $dep_asal)?>>
				 <?=$row_departemen['departemen']?>
                 </option>
                 <?
				} 
				// Akhir Olah Data kondisi
				?>
          	</select>
			</div>            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2">
            <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                <div id="sekolahInfo">
                <select name="sekolah" id="sekolah" onKeyPress="return focusNext('ketsekolah', event)" style="width:150px;" onfocus="panggil('sekolah')" onblur="unfokus('sekolah')">
                <option value="">[Pilih Asal Sekolah]</option>
    <? // Olah untuk combo sekolah
      	$sql_sekolah="SELECT sekolah FROM jbsakad.asalsekolah WHERE departemen='$dep_asal' ORDER BY sekolah ASC";
	   	$result_sekolah=QueryDB($sql_sekolah);
        while ($row_sekolah = mysql_fetch_array($result_sekolah)) {       
        ?>
                <option value="<?=$row_sekolah['sekolah']?>" <?=StringIsSelected($row_sekolah['sekolah'],$sekolah)?>>
                <?=$row_sekolah['sekolah']?>
                </option><?
        } 
        // Akhir Olah Data sekolah
        ?>
                </select>
              	</div></td>
              	<td valign="middle"><? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
                  <img src="../images/ico/tambah.png" onClick="tambah_asal_sekolah();" onMouseOver="showhint('Tambah Asal Sekolah!', this, event, '80px')"/>
                  <? } ?></td>
            </tr>
            </table>            </td>
        </tr>
        <tr>
          	<td valign="top">Keterangan Asal <br />
            Sekolah </td>
          	<td colspan="2"><textarea name="ketsekolah" id="ketsekolah" rows="2" cols="30"  class="Ukuranketerangan" onfocus="showhint('Keterangan sekolah asal tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('ketsekolah')" onkeypress="return focusNext('gol', event)" onblur="unfokus('ketsekolah')"><?=$ketsekolah?></textarea></td>
        </tr>
      	</table>
        <script language='JavaScript'>
	    //Tables('table', 1, 0);
		</script>              
        </td>
      	<!-- Akhir Kolom Kiri-->
      	<td width="1%" align="center" valign="middle"  style="border-left:1px dashed #333333; border-width:thin"></td>
      	<td width="*" valign="top"><!-- Kolom Kanan-->
        <table width="100%" border="0" cellspacing="0" id="table">
    	<tr>
         	<td height="30" colspan="3" valign="top"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Riwayat Kesehatan</strong></font>
            <!--hr width="375" style="line-height:1px; border-style:dashed" align="left" color="#000000" /-->
            <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>
            </td>
        </tr>
        <tr>
          	<td width="20%" valign="top" >Gol. Darah</td>
          	<td colspan="2">
            <input type="radio" name="gol" id="gol" value="A"
			<? if ($gol=="A") 
                    echo "checked";
            ?> onKeyPress="return focusNext('berat', event)"/>&nbsp;A&nbsp;&nbsp;
            <input type="radio" name="gol" id="gol" value="AB" 
            <? if ($gol=="AB") 
                    echo "checked";
            ?> onKeyPress="return focusNext('berat', event)"/>&nbsp;AB&nbsp;&nbsp;
            <input type="radio" name="gol" id="gol" value="B" 
            <? if ($gol=="B") 
                    echo "checked";
            ?> onKeyPress="return focusNext('berat', event)"/>&nbsp;B&nbsp;&nbsp;
            <input type="radio" name="gol" id="gol" value="O" 
            <? if ($gol=="O") 
                    echo "checked";
            ?> onKeyPress="return focusNext('berat', event)"/>&nbsp;O&nbsp;&nbsp;
            <input type="radio" name="gol" id="gol" value=""   
          	<? if ($gol=="") 
                    echo "checked";
            ?> onKeyPress="return focusNext('berat', event)"/>&nbsp;<em>(belum ada data)</em></td>
  		</tr>
        <tr>
          	<td>Berat</td>
          	<td colspan="2"><input name="berat" type="text" size="6" maxlength="6" id="berat" onFocus="showhint('Berat badan tidak boleh lebih dari 6 angka!', this, event, '120px');panggil('berat')" value="<?=$berat?>" onKeyPress="return focusNext('tinggi', event)" onblur="unfokus('berat')"/>
            &nbsp;kg</td>
        </tr>
        <tr>
        	<td>Tinggi</td>
          	<td colspan="2"><input name="tinggi" type="text" size="6" maxlength="6" id="tinggi" onFocus="showhint('Tinggi badan tidak boleh lebih dari 6 angka!', this, event, '120px');panggil('tinggi')" value="<?=$tinggi?>"  onKeyPress="return focusNext('kesehatan', event)" onblur="unfokus('tinggi')"/>
            &nbsp;cm</td>
        </tr>
        <tr>
            <td valign="top">Riwayat Penyakit</td>
            <td colspan="2"><textarea name="kesehatan" id="kesehatan" rows="2" cols="30" class="Ukuranketerangan" onFocus="showhint('Riwayat penyakit tidak boleh lebih dari 255 karakter!', this, event, '120px');panggil('kesehatan')"  onKeyPress="return focusNext('namaayah', event)" onblur="unfokus('kesehatan')"><?=$kesehatan?></textarea></td>
        </tr>
        <tr>
            <td height="30" colspan="3">
            <font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Orang Tua Siswa</strong></font>
            <!--hr width="375" style="line-height:1px; border-style:dashed" align="left" /-->
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
          	<td bgcolor="#DBD8F3">
            	<input name="namaayah" type="text" size="15" maxlength="100" id="namaayah" onFocus="showhint('Nama Ayah tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('namaayah')"  value="<?=$namaayah?>" class="ukuran"  onKeyPress="return focusNext('namaibu', event)" onblur="unfokus('namaayah')"/>
              	<br />
              	<input type="checkbox" name="almayah" id="almayah" value="1" title="Klik disini jika Ayah Almarhum"  
        		<? if ($almayah=="1")
				echo "checked";?> 
        		/>
                &nbsp;&nbsp;<font color="#990000" size="1">(Almarhum)</font> </td>
         	<td bgcolor="#E9AFCF">
            	<input name="namaibu" type="text" size="15" maxlength="100" id="namaibu" onFocus="showhint('Nama Ibu tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('namaibu')" value="<?=$namaibu?>" class="ukuran" onKeyPress="return focusNext('Infopendidikanayah', event)" onblur="unfokus('namaibu')"/>
                <br />
                <input type="checkbox" name="almibu" id="almibu" value="1" title="Klik disini jika Ibu Almarhumah"
        		<? if ($almibu=="1")
				echo "checked";?>/>
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
				//if ($pendidikanayah=="")
				//$pendidikanayah=$row_pend_ayah;
				?>
                          <option value="<?=$row_pend_ayah['pendidikan']?>" <?=StringIsSelected($row_pend_ayah[pendidikan],$pendidikanayah)?>>
                          <?=$row_pend_ayah['pendidikan']?>
                          </option>
                          <?
				} 
				// Akhir Olah Data sekolah
				?>
            	</select> 
                </div>            </td>
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
                    
                    //if ($pendidikanibu=="")
                    //$pendidikanibu=$row_pend_ibu;
                    ?>
                            <option value="<?=$row_pend_ibu['pendidikan']?>" <?=StringIsSelected($row_pend_ibu[pendidikan],$pendidikanibu)?>>
                            <?=$row_pend_ibu['pendidikan']?>
                            </option>
                            <?
                    } 
                    // Akhir Olah Data sekolah
                    ?>
                    </select>
                    </div>                    </td>
                    <td>
					<? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
                        <img src="../images/ico/tambah.png" onClick="tambah_pendidikan();" onMouseOver="showhint('Tambah Tingkat Pendidikan!', this, event, '80px')" />
                    <? } ?>                    </td>
          		</tr>
                </table>          	</td>
    	</tr>
        <tr> 
        	<td>Pekerjaan</td>
           	<td bgcolor="#DBD8F3">
            	<div id="pekerjaanayahInfo">
            	<select name="pekerjaanayah" id="Infopekerjaanayah" class="ukuran"  onKeyPress="return focusNext('Infopekerjaanibu', event)" onfocus="panggil('Infopekerjaanayah')" style="width:140px" onblur="unfokus('Infopekerjaanayah')">
                	<option value="">[Pilih Pekerjaan]</option>
				<? // Olah untuk combo sekolah
				$sql_kerja_ayah="SELECT pekerjaan FROM jbsumum.jenispekerjaan ORDER BY pekerjaan";
				$result_kerja_ayah=QueryDB($sql_kerja_ayah);
				while ($row_kerja_ayah = mysql_fetch_array($result_kerja_ayah)) {
				//if ($pekerjaanayah=="")
				//$pekerjaanayah=$row_kerja_ayah;
				?>
                	<option value="<?=$row_kerja_ayah['pekerjaan']?>"<?=StringIsSelected($row_kerja_ayah['pekerjaan'],$pekerjaanayah)?>>
                        <?=$row_kerja_ayah['pekerjaan']?>
                        </option>
                        <?
				} 
				// Akhir Olah Data sekolah
				?>
                </select>
                </div>            </td>
           	<td bgcolor="#E9AFCF">
            	<table cellpadding="0" cellspacing="0">
                <tr>
                	<td>
                    <div id = "pekerjaanibuInfo">
                    <select name="pekerjaanibu" id="Infopekerjaanibu"  class="ukuran"  onKeyPress="return focusNext('penghasilanayah1', event)" onfocus="panggil('Infopekerjaanibu')" style="width:140px" onblur="unfokus('Infopekerjaanibu')">
                        <option value="">[Pilih Pekerjaan]</option>
                              <? // Olah untuk combo sekolah
                    $sql_kerja_ibu="SELECT pekerjaan FROM jbsumum.jenispekerjaan ORDER BY pekerjaan";
                    $result_kerja_ibu=QueryDB($sql_kerja_ibu);
                    while ($row_kerja_ibu = mysql_fetch_array($result_kerja_ibu)) {
                    //if ($pekerjaanibu=="")
                    //$pekerjaanibu=$row_kerja_ibu;
                    ?>
                        <option value="<?=$row_kerja_ibu['pekerjaan']?>"<?=StringIsSelected($row_kerja_ibu[pekerjaan],$pekerjaanibu)?>>
                              <?=$row_kerja_ibu['pekerjaan']?>
                        </option>
                              <?
                    } 
                    // Akhir Olah Data sekolah
                    ?>
                    </select>
                   	</div>                    </td>
                    <td>
                    <? if (SI_USER_LEVEL() != $SI_USER_STAFF) { ?>
                    <img src="../images/ico/tambah.png" onClick="tambah_pekerjaan();" onMouseOver="showhint('Tambah Jenis Pekerjaan!', this, event, '80px')" />
                    <? }?>                    </td>
             	</tr>
                </table>         	</td> 
    	</tr> 
       
        <tr>
          	<td>Penghasilan</td>
          	<td bgcolor="#DBD8F3">
            	<input type="text" name="penghasilanayah1" id="penghasilanayah1"  maxlength="20" value="<?=FormatRupiah($penghasilanayah) ?>" onblur="formatRupiah('penghasilanayah1');unfokus('penghasilanayah1')" onfocus="unformatRupiah('penghasilanayah1');panggil('penghasilanayah1')" class="ukuran"  onKeyPress="return focusNext('penghasilanibu1', event)" onKeyUp="penghasilan_ayah()" >
				<input type="hidden" name="penghasilanayah" id="penghasilanayah" value="<?=$penghasilanayah?>">         	</td>
          	<td bgcolor="#E9AFCF">
            	<input type="text" name="penghasilanibu1" id="penghasilanibu1" maxlength="20" value="<?=FormatRupiah($penghasilanibu) ?>" onblur="formatRupiah('penghasilanibu1');unfokus('penghasilanibu1')" onfocus="unformatRupiah('penghasilanibu1');panggil('penghasilanibu1')" class="ukuran"  onKeyPress="return focusNext('emailayah', event)" onKeyUp="penghasilan_ibu()" />
				<input type="hidden" name="penghasilanibu" id="penghasilanibu" value="<?=$penghasilanibu?>">          	</td>
  		</tr>
       <tr>
          <td>Email Ortu</td>
          <td bgcolor="#DBD8F3"><input name="emailayah" type="text" size="15" maxlength="100" id="emailayah" onFocus="showhint('Alamat email Ayah tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailayah')" value="<?=$emailayah?>" class="ukuran" onKeyPress="return focusNext('emailibu', event)" onblur="unfokus('emailayah')" /></td>
          <td colspan="2" bgcolor="#E9AFCF"><input name="emailibu" type="text" size="15" maxlength="100" id="emailibu" onFocus="showhint('Alamat email Ibu tidak boleh lebih dari 100 karakter!', this, event, '120px');panggil('emailibu')" value="<?=$emailibu?>" class="ukuran" onKeyPress="return focusNext('namawali', event)" onblur="unfokus('emailibu')" /></td>
        </tr>
        <tr>
        	<td>Nama Wali</td>
          	<td colspan="2">
            	<input type="text" name="namawali" id="namawali" maxlength="100" value="<?=$namawali?>" size="30"  onKeyPress="return focusNext('alamatortu', event)" onfocus="panggil('namawali')" onblur="unfokus('namawali')"/></td>
        </tr>
        <tr>
          	<td valign="top">Alamat Orang Tua </td>
          	<td colspan="2">
            	<textarea name="alamatortu" id="alamatortu" rows="2" cols="30" class="Ukuranketerangan" onkeypress="return focusNext('telponortu', event)" onfocus="panggil('alamatortu')" onblur="unfokus('alamatortu')"><?=$alamatortu?></textarea></td>
      	</tr>
        <tr>
          	<td>Telepon Ortu</td>
          	<td colspan="2">
          	<input type="text" name="telponortu" id="telponortu" class="ukuran" maxlength="20" value="<?=$telponortu?>" onKeyPress="return focusNext('hportu', event)" onfocus="panggil('telponortu')" onblur="unfokus('telponortu')"/></td>
        </tr>
        <tr>
          	<td>HP Ortu #1</font></td>
          	<td align="left">
				<input type="text" name="hportu" id="hportu" class="ukuran" maxlength="20" value="<?=$hportu?>" onKeyPress="return focusNext('hportu2', event)" onfocus="panggil('hportu')" onblur="unfokus('hportu')"/>
			</td>
			<td rowspan="3" align="left" valign="top">
				<font style="color: blue; font-style: italic">tambahkan # supaya tidak digunakan di JIBAS SMS Gateway. contoh: #08123456789</font>	
			</td>
        </tr>
		<tr>
          	<td>HP Ortu #2</td>
          	<td align="left">
				<input type="text" name="hportu2" id="hportu2" class="ukuran" maxlength="20" value="<?=$hportu2?>"  onKeyPress="return focusNext('hportu3', event)" onfocus="panggil('hportu2')" onblur="unfokus('hportu2')"/>
			</td>
        </tr>
		<tr>
          	<td>HP Ortu #3</td>
          	<td align="left">
				<input type="text" name="hportu3" id="hportu3" class="ukuran" maxlength="20" value="<?=$hportu3?>"  onKeyPress="return focusNext('alamatsurat', event)" onfocus="panggil('hportu3')" onblur="unfokus('hportu3')"/>
			</td>
        </tr>
        <tr>
          	<td height="30" colspan="3">
          	<font size="2" face="Verdana, Arial, Helvetica, sans-serif" style="background-color:#ffcc66">&nbsp;</font>&nbsp;<font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="Gray"><strong>Data Lainnya</strong></font>
          	<!--hr width="375" style="line-height:1px; border-style:dashed" align="left" /-->
            <div style="border-bottom:1px dashed #666666; border-width:thinl; margin-bottom:5px; margin-top:3px;"></div>
            </td>
        </tr>
        <tr>
          	<td valign="top">Alamat Surat</td>
          	<td colspan="2">
          	<textarea name="alamatsurat" id="alamatsurat" rows="2" cols="30" class="Ukuranketerangan"  onKeyPress="return focusNext('keterangan', event)" onfocus="panggil('alamatsurat')" onblur="unfokus('alamatsurat')"><?=$alamatsurat?></textarea>            </td>
        </tr>
        <tr>
          	<td valign="top">Keterangan</td>
          	<td colspan="2">
            <textarea name="keterangan" id="keterangan" rows="2" cols="30" class="Ukuranketerangan" onKeyPress="return focusNext('sum1', event)" onfocus="panggil('keterangan')" onblur="unfokus('keterangan')"><?=$keterangan?></textarea></td>
        </tr>
      	</table>
        <script language='JavaScript'>
	    //Tables('table', 1, 0);
  		</script>
        <!-- Akhir Kolom Kanan-->
 		</td>
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
        <td width="40" align="left"><input type="text" name="sum1" id="sum1" size="10" maxlength="15" onKeyPress="return focusNext('sum2', event)" onblur="formatRupiah('sum1')" onfocus="unformatRupiah('sum1')"  /> </td>
        <td width="170" align="left">&nbsp;&nbsp;Sumbangan #2 (<?=$kdsum2?>):</td>
        <td width="40" align="left"><input type="text" name="sum2" id="sum2" size="10" maxlength="15" onKeyPress="return focusNext('ujian1', event)" onblur="formatRupiah('sum2')" onfocus="unformatRupiah('sum2')" /> </td>
    </tr>
    </table>
    <br />
    <table border="0" cellpadding="2" cellspacing="0" style="background-color:#FFFFF2">
    <tr>
        <td width="120" align="left">Ujian #1 (<?=$kdujian1?>):</td>
        <td width="30" align="left"><input type="text" name="ujian1" id="ujian1" size="5" onKeyPress="return focusNext('ujian2', event)" maxlength="5" /> </td>
        <td width="120" align="left">Ujian #2 (<?=$kdujian2?>):</td>
        <td width="30" align="left"><input type="text" name="ujian2" id="ujian2" size="5" onKeyPress="return focusNext('ujian3', event)" maxlength="5" /> </td>   
        <td width="120" align="left">Ujian #3 (<?=$kdujian3?>):</td>
        <td width="30" align="left"><input type="text" name="ujian3" id="ujian3" size="5" onKeyPress="return focusNext('ujian4', event)" maxlength="5" /> </td>   
    </tr>
    <tr>    
        <td width="120" align="left">Ujian #4 (<?=$kdujian4?>):</td>
        <td width="30" align="left"><input type="text" name="ujian4" id="ujian4" size="5" onKeyPress="return focusNext('ujian5', event)" maxlength="5" /> </td>
        <td width="120" align="left">Ujian #5 (<?=$kdujian5?>):</td>
        <td width="30" align="left"><input type="text" name="ujian5" id="ujian5" size="5" onKeyPress="return focusNext('Simpan', event)" maxlength="5" /> </td>
        <td width="120" align="left">&nbsp;</td>
        <td width="30" align="left">&nbsp;</td>
    </tr>
    </table>
    
    </td>
</tr>
<tr height="50">
  	<td valign="middle" align="right">
  	<input type="Submit" value="Simpan" name="Simpan" class="but" id="Simpan" onfocus="panggil('Simpan')" onblur="unfokus('Simpan')"/></td>
  	<td align="center" valign="middle"></td>
  	<td valign="middle"><input class="but" type="button" value="Tutup" name="Tutup"  onClick="tutup()" />
  	</td>
</tr>
</table>
</form>
<!-- END OF CONTENT //--->
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