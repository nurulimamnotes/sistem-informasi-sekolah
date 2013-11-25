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
function GetThemeDir() 
{
	OpenDb();
	
	$sql_tema="Select theme from jbsuser.hakakses where login='".SI_USER_ID()."' AND modul='KEUANGAN' ";
	$hasil=QueryDb($sql_tema);
	$row_tema=mysql_fetch_array($hasil);
	$row_tema2=mysql_num_rows($hasil);
	
	if ($row_tema2==0)
		$theme=3;
	else
		$theme=$row_tema['theme'];

	CloseDb();
	
	if ($theme == 1) {
		return "../keuangan/theme/green/";
	} elseif ($theme == 2) {
		return "../keuangan/theme/pink/";
	} elseif ($theme == 3) {
		return "../keuangan/images/default/";
	} elseif ($theme == 4) {
		return "../keuangan/theme/apple/";
	} elseif ($theme == 5) {
		return "../keuangan/theme/vista/";
	} elseif ($theme == 6) {
		return "../keuangan/theme/kopi/";
	} elseif ($theme == 7) {
		return "../keuangan/theme/wood/";
	} elseif ($theme == 8) {
		return "../keuangan/theme/gold/";
	} elseif ($theme == 9) {
		return "../keuangan/theme/granite/";
	}
}
?>