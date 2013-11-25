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
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('../include/common.php');
require_once('../script/as-diagrams.php');

$nis_awal = $_REQUEST['nis_awal'];

$departemen = 0;
if (isset($_REQUEST['departemen']))
	$departemen = $_REQUEST['departemen'];

OpenDb();
$sql = "SELECT replid, departemen, nislama FROM riwayatdeptsiswa WHERE nis = '$nis_awal'";

$result = QueryDb($sql);
$row = @mysql_fetch_array($result);
$dep[0] = array($row['departemen'], $nis_awal);

if ($row['nislama'] <> "") {
	$sql1 = "SELECT replid, departemen, nislama FROM riwayatdeptsiswa WHERE nis = '$row[nislama]'";
	$result1 = QueryDb($sql1);
	$row1 = @mysql_fetch_array($result1);	
	$dep[1] = array($row1['departemen'], $row['nislama']);
	//$no[2] = $row1['nislama'];	
	if ($row1['nislama'] <> "") {				
		$sql2 = "SELECT replid, departemen, nislama FROM riwayatdeptsiswa WHERE nis = '$row1[nislama]'";
		$result2 = QueryDb($sql2);
		$row2 = @mysql_fetch_array($result2);					
		$dep[2] = array($row2['departemen'],$row1['nislama']) ;
	}	
}		

$nis = $dep[$departemen][1];

$sql_ajaran = "SELECT DISTINCT(t.replid), t.tahunajaran FROM riwayatkelassiswa r, kelas k, tahunajaran t WHERE r.nis = '$nis' AND r.idkelas = k.replid AND k.idtahunajaran = t.replid ORDER BY t.aktif DESC";

$result_ajaran = QueryDb($sql_ajaran);
$k = 0;
while ($row_ajaran = @mysql_fetch_array($result_ajaran)) {
	$ajaran[$k] = array($row_ajaran['replid'],$row_ajaran['tahunajaran']);
	$k++;
}

$sql_kls = "SELECT DISTINCT(r.idkelas), k.kelas, t.tingkat, k.idtahunajaran FROM riwayatkelassiswa r, kelas k, tingkat t WHERE r.nis = '$nis' AND r.idkelas = k.replid AND k.idtingkat = t.replid";
$result_kls = QueryDb($sql_kls);
$j = 0;
while ($row_kls = @mysql_fetch_array($result_kls)) {
	$kls[$j] = array($row_kls['idkelas'],$row_kls['kelas'],$row_kls['tingkat'],$row_kls['idtahunajaran']);
	$j++;
}


$tahunajaran = $ajaran[0][0];
if (isset($_REQUEST['tahunajaran']))
	$tahunajaran = $_REQUEST['tahunajaran'];

$kelas = $kls[0][0];
if (isset($_REQUEST['kelas']))
	$kelas = $_REQUEST['kelas'];
?>
<body leftmargin="0" topmargin="0">
<form name="panel2" id="panel2" method="post">
<input type="hidden" name="nis" id="nis" value="<?=$nis?>">
<input type="hidden" name="nis_awal" id="nis_awal" value="<?=$nis_awal?>">

<table width="100%" cellpadding="0" cellspacing="0">    
<tr>
	<td width="0">
    <!-- CONTENT GOES HERE //--->	
    <table border="0" cellpadding="2"cellspacing="2" width="100%" style="color:#000000">
    <tr>
    	<!--<td><strong>Departemen</strong>
    	
    	</td>-->
        <td width="*"><strong>Th. Ajaran</strong>
        <select name="departemen" id="departemen" onChange="change_dep(2)" style="width:80px">
		<? for ($i=0;$i<sizeof($dep);$i++) { ?>        	
            <option value="<?=$i ?>" <?=IntIsSelected($i, $departemen) ?> > <?=$dep[$i][0] ?> </option>
		<? } ?>
		</select>
        <select name="tahunajaran" id="tahunajaran" onChange="change(2)" style="width:125px">
   		<? for($k=0;$k<sizeof($ajaran);$k++) {?>
			<option value="<?=$ajaran[$k][0] ?>" <?=IntIsSelected($ajaran[$k][0], $tahunajaran) ?> > 
			<?=$ajaran[$k][1]?> </option>
		<? } ?>
    	</select>    
		&nbsp;&nbsp;<strong>Riwayat Kelas</strong>
        <select name="kelas" id="kelas" onChange="change(2)" style="width:125px">
   		<? for ($j=0;$j<sizeof($kls);$j++) {
				if ($kls[$j][3] == $tahunajaran) {
		?>
			<option value="<?=$kls[$j][0] ?>" <?=IntIsSelected($kls[$j][0], $kelas) ?> > <?=$kls[$j][2]." - ".$kls[$j][1] ?> </option>
		<? 		}
			} ?>
    	</select>    
		</td>
        <td align="right" width="12%">
  			<a href="#" onClick="cetak(0,2)"><img src="../images/ico/print.png" width="16" height="16" border="0" />&nbsp;Cetak</a>&nbsp;
    	</td>
  	</tr>
<? if ($kelas<> "" ) { 
		$sql = "SELECT tglmulai, tglakhir FROM tahunajaran WHERE replid = '$tahunajaran'";
		$result = QueryDb($sql);
		$row = mysql_fetch_array($result);
		$tglawal = $row['tglmulai'];
		$tglakhir = $row['tglakhir'];
		
		$sql1 = "SELECT CONCAT(DATE_FORMAT(tanggal,'%b'),' ',YEAR(tanggal)) AS blnthn, SUM(IF(statushadir = 0,1,0)), SUM(IF(statushadir = 1,1,0)), SUM(IF(statushadir = 2,1,0)), SUM(IF(statushadir = 4,1,0)), SUM(IF(statushadir = 3,1,0)), MONTH(tanggal) FROM presensipelajaran p, ppsiswa pp WHERE pp.nis = '$nis' AND pp.idpp = p.replid AND p.idkelas = '$kelas' AND p.tanggal BETWEEN '$tglawal' AND '$tglakhir' GROUP BY blnthn ORDER BY YEAR(tanggal), MONTH(tanggal)";
		$result1 = QueryDb($sql1);      	
        $num = mysql_num_rows($result1);
		echo "<input type='hidden' name='num' id='num' value=$num>";
		if ($num > 0) {
?>
         <tr>
            <td colspan="3">
            <table border="0" cellpadding="2" cellspacing="2" width="100%" align="center" bgcolor="#FFFFFF">
            <tr>
                <td align="center">
            <?		
            
            
            $data_title = "<font size='4'>STATISTIK PRESENSI PELAJARAN</font>"; // title for the diagram
    
            // sample data array
            $data = array();
    
            while($row1 = mysql_fetch_row($result1)) {
                $data[] = array($row1[1],$row1[2],$row1[3],$row1[4],$row1[5]);
                $legend_x[] = $row1[0];			
            }
                    
            //$legend_x = array('Jan','Feb','Maret','April','Mei');
            $legend_y = array('Hadir','Ijin','Sakit','Alpa', 'Cuti');
    
            $graph = new CAsBarDiagram;
            $graph->bwidth = 10; // set one bar width, pixels
            $graph->bt_total = 'Total'; // 'totals' column title, if other than 'Totals'
           // $graph->showtotals = 0;  // uncomment it if You don't need 'totals' column
            $graph->precision = 1;  // decimal precision
            // call drawing function
            $graph->DiagramBar($legend_x, $legend_y, $data, $data_title);
            ?>
            </td>
        </tr>
        <tr>
        	<td>
            <table class="tab" id="table" border="1" cellpadding="2" style="border-collapse:collapse" cellspacing="2" width="100%" align="center" bordercolor="#000000">		
            <tr height="30" align="center">		
                <td width="*" class="header">Bulan</td>
                <td width="15%" class="header">Hadir</td>
                <td width="15%" class="header">Ijin</td>
                <td width="15%" class="header">Sakit</td>
                <td width="15%" class="header">Alpa</td>
                <td width="15%" class="header">Cuti</td>
            </tr>
			<? 
            
            $result2 = QueryDb($sql1);
            while ($row2 = @mysql_fetch_row($result2)) {		
                 $waktu = explode(" ",$row2[0]);
            ?>	
            <tr height="25">        			
                <td align="center"><?=NamaBulan($row2[6]).' '.$waktu[1]?></td>
                <td align="center">
				<? if ($row2[1]!=0) { ?>
                	<a href="#" onClick="view_detail_pres('<?=$row2[6]."-".$waktu[1]?>','0');">
				<? } ?>
				<?=$row2[1]?>
				<? if ($row2[1]!=0) { ?>
                	</a>
				<? } ?>
                </td>
                <td align="center">
				<? if ($row2[2]!=0) { ?>
                	<a href="#" onClick="view_detail_pres('<?=$row2[6]."-".$waktu[1]?>','1');">
				<? } ?>
				<?=$row2[2]?>
				<? if ($row2[2]!=0) { ?>
                	</a>
				<? } ?>
                </td>
                <td align="center">
				<? if ($row2[3]!=0) { ?>
                	<a href="#" onClick="view_detail_pres('<?=$row2[6]."-".$waktu[1]?>','2');">
				<? } ?>
				<?=$row2[3]?>
				<? if ($row2[3]!=0) { ?>
                	</a>
				<? } ?>
                </td>
                <td align="center">
				<? if ($row2[4]!=0) { ?>
                	<a href="#" onClick="view_detail_pres('<?=$row2[6]."-".$waktu[1]?>','4');">
				<? } ?>
				<?=$row2[4]?>
				<? if ($row2[4]!=0) { ?>
                	</a>
				<? } ?>
                </td>
                <td align="center">
				<? if ($row2[5]!=0) { ?>
                	<a href="#" onClick="view_detail_pres('<?=$row2[6]."-".$waktu[1]?>','3');">
				<? } ?>
				<?=$row2[5]?>
				<? if ($row2[5]!=0) { ?>
                	</a>
				<? } ?>
                </td>
            </tr>
			<? } ?>
            </table>
           	</td>
       	</tr>
        </table>
        </td>
  	</tr>
<? } else { ?>                 
	<tr>
		<td align="center" valign="middle" height="120" colspan="2">
    	<font size = "2" color ="red"><b>Tidak ditemukan adanya data.<br /></font>
		</td>
	</tr>
  	<? } ?>
<? } else { ?>                 
	<tr>
		<td align="center" valign="middle" height="120" colspan="2">
    	<font size = "2" color ="red"><b>Tidak ditemukan adanya data.<br /></font>
		</td>
	</tr>
<? } ?>
    </table>
     <!-- END OF CONTENT //--->
	</td>
</tr>
</table>
</form>