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
if(isset($_GET[departemen])){
	$file1 = "filter_penentuan.php?departemen=$_GET[departemen]&tingkat=$_GET[tingkat]&semester=$_GET[semester]&kelas=$_GET[kelas]";
	$file2 = "penentuan_footer.php?departemen=$_GET[departemen]&tingkat=$_GET[tingkat]&semester=$_GET[semester]&kelas=$_GET[kelas]";
}else{
	$file1 = "filter_penentuan.php";
	$file2 = "blank_penentuan.php";
}
?>
<frameset rows="80,*" border="1" frameborder="yes" framespacing="yes">
    <frame name="filter_penentuan" src="filter_penentuan.php" target="filter_penentuan"  scrolling="no" style="border:1; border-bottom-color:#000000; border-bottom-style:solid">
    <frame name="penentuan_footer" src="blank_penentuan.php">
</frameset><noframes></noframes>
</html>