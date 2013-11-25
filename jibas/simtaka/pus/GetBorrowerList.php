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
require_once('../inc/config.php');
require_once('../inc/db_functions.php');
require_once('../inc/common.php');
OpenDb();
$idanggota=$_REQUEST[idanggota];
$from=$_REQUEST[from];
$to=$_REQUEST[to];
$sql = "SELECT pu.judul, p.tglpinjam, pu.replid FROM pinjam p, daftarpustaka d, pustaka pu WHERE p.tglpinjam BETWEEN '$from' AND '$to' AND p.idanggota = '$idanggota' AND p.kodepustaka=d.kodepustaka AND d.pustaka=pu.replid";
$result = QueryDb($sql);
$cnt=1;
?>
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="tab">
  <tr>
    <td height="25" align="center" class="header">No</td>
    <td height="25" align="center" class="header">Judul Pustaka</td>
    <td height="25" align="center" class="header">Tgl Pinjam</td>
    <td height="25" align="center" class="header">&nbsp;</td>
  </tr>
  <? while ($row = @mysql_fetch_row($result)) { ?>
  <tr>
    <td height="20" align="center"><?=$cnt?></td>
    <td height="20"><div style="padding-left:5px;"><?=$row[0]?></div></td>
    <td height="20" align="center"><?=LongDateFormat($row[1])?></td>
    <td height="20" align="center">
        <a href="javascript:ViewDetail('<?=$row[2]?>')"><img src="../img/ico/lihat.png" width="16" height="16" border="0" /></a>
    </td>
  </tr>
  <? $cnt++; ?>
  <? } ?>
</table>