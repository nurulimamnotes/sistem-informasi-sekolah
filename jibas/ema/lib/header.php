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

$replid=$_REQUEST['replid'];
$table = $_REQUEST['table'];
$field = "foto";
if (isset($_REQUEST['field']))
	$field = $_REQUEST['field'];


OpenDb();
header("Content-type: image/jpeg");
//if ($field == "") 	
	$query = "SELECT $field FROM $table WHERE replid = '$replid'";
//else
//	$query = "SELECT foto FROM jbsumum.identitas WHERE replid = 16";

//echo $query;	
$result = QueryDb($query);
$num = @mysql_num_rows($result);
if ($row = mysql_fetch_array($result)) {
    if($row[$field]) {
        echo $row[$field];
    }else {
    	$filename = "../img/nophotos.png";
        $handle = fopen($filename, "r");
        $contents = fread($handle, filesize($filename));

        echo $contents;
    }
  }
//}
CloseDb();


?>