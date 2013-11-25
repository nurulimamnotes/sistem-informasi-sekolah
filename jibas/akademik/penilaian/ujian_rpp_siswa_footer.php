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
$kelas=$_REQUEST['kelas'];
$semester=$_REQUEST['semester'];
$pelajaran=$_REQUEST['pelajaran'];
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Content Penentuan Nilai Rapor </TITLE>
</HEAD>
<frameset cols="18%,*" border="1">
    <frame name="menu" src="ujian_rpp_siswa_menu.php?kelas=<?=$kelas?>&semester=<?=$semester?>&pelajaran=<?=$pelajaran?>" >
    <frame name="content" src="../blank.php" style="border:1; border-left-color:#000000; border-left-style:solid">
</frameset><noframes></noframes>
</HTML>