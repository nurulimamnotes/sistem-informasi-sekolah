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
require_once('../include/sessionchecker.php');
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');

$suku_kiriman=$_REQUEST['suku'];
?>
<select name="cbSuku" id="cbSuku" onKeyPress="return focusNext('cbNikah', event)">
<? // Olah untuk combo suku
	OpenDb();
	$sql_suku="SELECT suku,urutan,replid FROM jbsumum.suku ORDER BY urutan";
	$result_suku=QueryDB($sql_suku);
	while ($row_suku = mysql_fetch_array($result_suku))
	{ ?>
	<option value="<?=$row_suku['suku']?>" <?=StringIsSelected($row_suku['suku'], $suku_kiriman)?> ><?=$row_suku['suku']?></option>
<? 	} 
	CloseDb();?>
</select>
<img src="../images/ico/tambah.png" onclick="tambah_suku();" />