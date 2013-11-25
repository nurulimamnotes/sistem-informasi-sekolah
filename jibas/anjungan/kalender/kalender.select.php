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

$dept = isset($_REQUEST['dept']) ? $_REQUEST['dept'] : "";
$kalender = isset($_REQUEST['kalender']) ? (int)$_REQUEST['kalender'] : 0;

OpenDb();
?>
<br>
<table border="0" cellpadding="2" cellspacing="0">
<tr>
<td align="right">
<strong>Departemen:</strong>
</td>
<td align="left" width="300">
    
    <select id='ka_departemen' onchange='ka_ChangeDept()'>
<?  $sql = "SELECT departemen
              FROM jbsakad.departemen
             WHERE aktif = 1
             ORDER BY urutan";
    $res = QueryDb($sql);
    while($row = mysql_fetch_row($res))
    {
        if ($dept == "")
            $dept = $row[0];
        $sel = $dept == $row[0] ? "selected" : "";
        ?>
        <option value='<?=$row[0]?>' <?=$sel?> ><?=$row[0]?></option>
<?  }   ?>
    </select>
    
<?  $sql = "SELECT replid
              FROM jbsakad.tahunajaran
             WHERE departemen = '$dept'
               AND aktif = 1";
    $res = QueryDb($sql);
    $row = mysql_fetch_row($res);
    $idtahunajaran = (int)$row[0]; ?>
   
</td>
<td rowspan="2">
<a href="#" onclick="ka_ShowContent()"><img src='images/view.png' border='0'></a>    
</td>
</tr>
<tr>
    <td align="right">
    <strong>Kalender:</strong>     
    </td>
    <td align="left">
    
    <select id='ka_kalender' onchange='ka_ChangeKalender()'>
<?  $sql = "SELECT replid, kalender
              FROM jbsakad.kalenderakademik
             WHERE idtahunajaran = '$idtahunajaran'
               AND departemen = '$dept'
               AND aktif = 1
             ORDER BY kalender";
    $res = QueryDb($sql);
    while($row = mysql_fetch_row($res))
    {
        if ($kalender == 0)
            $kalender = $row[0];
        $sel = $kalender == $row[0] ? "selected" : "";
        ?>
        <option value='<?=$row[0]?>' <?=$sel?> ><?=$row[1]?></option>
<?  }   ?>
    </select>    
        
    </td>
</tr>
</table>
<?
CloseDb();
?>