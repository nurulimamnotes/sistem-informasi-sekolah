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

$maxitem = 4;
$page = isset($_REQUEST['page']) ? (int)$_REQUEST['page'] : 1;

OpenDb();

$sql = "SELECT COUNT(replid)
          FROM jbsvcr.beritasekolah";
$nberita = (int)FetchSingle($sql);

$npage = floor($nberita / $maxitem);
if ($nberita % $maxitem != 0)
    $npage += 1;

if ($nberita == 0)
{
    echo "<br><br><center><i>Belum ada berita sekolah</i><center>";
    CloseDb();
    exit();
}
?>
<br>
<table border="0" cellpadding="2" cellspacing="0" width="100%">
<tr>
    <td align="left">
    Halaman:
    <select id="bs_page" name="bs_page" onchange="bs_ChangePage()">
<?  for($i = 1; $i <= $npage; $i++)
    {
        $sel = ($i == $page) ? "selected" : "";
        echo "<option value='$i' $sel>$i</option>";  
    } ?>
    </select>
    dari <?= $npage ?>&nbsp;&nbsp;&bullet;&nbsp;&nbsp;Jumlah Berita: <?= $nberita ?>
    </td>    
</tr>
<tr>
    <td align="left">
    <br>
    <table border="0" cellpadding="5" cellspacing="0" width="100%">
<?
    $start = ($page - 1) * $maxitem; 
    $sql = "SELECT b.replid AS replid, b.judul AS judul,
                   DATE_FORMAT(b.tanggal, '%e %b %Y %H:%i') AS tanggal,
                   b.abstrak AS abstrak, b.idpengirim
              FROM jbsvcr.beritasekolah b 
		       ORDER BY tanggal DESC
             LIMIT $start, $maxitem";
    $res = QueryDb($sql);
    $cnt = 0;
    while($row = mysql_fetch_array($res))
    {
        $cnt += 1;
        if ($cnt == 1)
        {
            echo "<tr>";
        }
		  
		  $sql = "SELECT nama FROM jbssdm.pegawai WHERE nip = '$row[idpengirim]'";
		  $res2 = QueryDb($sql);
		  $row2 = mysql_fetch_row($res2);
		  $nama = $row2[0];
		  
		  $berita = $row['abstrak'];
		  $berita = str_replace("#sq;", "'", $berita);
		  $berita = str_replace("../../../..", $FILESHARE_ADDR . "/../../" , $berita);
        
        echo "<td align='left' valign='top' width='50%'>";
        echo "<a href='#' onclick='bs_Read(" . $row['replid'] . ", $page)'>";
        echo "<font class='bsTanggal'>" . $row['tanggal'] . "</font><br>";
        echo "<font class='bsJudul'>" . $row['judul'] . "</font><br>";
		  echo "<font class='bsPenulis'>" . $nama . "</font><br>";
        echo "<font class='bsAbstrak'>" . $berita . "</font><br>";
        echo "</a>";
        echo "</td>";
        
        if ($cnt == 2)
        {
            echo "</tr>";
            $cnt = 0;
        }
    }
    
    if ($cnt == 1)
    {
        echo "<td width='50%'>&nbsp</td></tr>";
    }
?>
    </table>        
    </td>
</tr>
</table>

<?
CloseDb();
?>