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
require_once("../include/config.php");
require_once("../include/db_functions.php");

$id = $_REQUEST['id'];
$page = $_REQUEST['page'];

OpenDb();

$sql = "SELECT b.replid AS replid, b.judul AS judul,
               DATE_FORMAT(b.tanggal, '%e %b %Y %H:%i') AS tanggal,
               b.isi, b.idpengirim
          FROM jbsvcr.beritasekolah b 
		   WHERE replid = '$id'";
$res = QueryDb($sql);
$row = mysql_fetch_array($res);

$berita = $row['isi'];
$berita = str_replace("#sq;", "'", $berita);
$berita = str_replace("../../../..", $FILESHARE_ADDR . "/../../" , $berita);

$sql = "SELECT nama FROM jbssdm.pegawai WHERE nip = '$row[idpengirim]'";
$res2 = QueryDb($sql);
$row2 = mysql_fetch_row($res2);
$nama = $row2[0];
?>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr>
<td align="left" valign="top" width="100%">
<a href="#" onclick="bs_BackToList(<?=$page?>)" style="font-weight:normal; text-decoration: underline; color: blue;">kembali</a><br><br>
<font class='bsTanggal'><?= $row['tanggal'] ?></font><br>
<font class='bsJudulIsi'><?= $row['judul'] ?></font><br>
<font class='bsPenulis'><?= $nama ?></font><br><br>
<font class='bsIsi'><?= $berita ?></font>
<br><br>
<a href="#" onclick="bs_BackToList(<?=$page?>)" style="font-weight:normal; text-decoration: underline; color: blue;">kembali</a>
</td>    
</tr>    
</table>


<br><br>

<?
CloseDb();
?>