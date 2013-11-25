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
require_once('../include/numbertotext.class.php');
require_once('../library/dpupdate.php');

$NTT = new NumberToText();
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
		
$depart = $dep[$departemen][0];
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


$tahunajaran = "";
if (isset($_REQUEST['tahunajaran']))
	$tahunajaran = $_REQUEST['tahunajaran'];
	
$kelas = "";
if (isset($_REQUEST['kelas']))
	$kelas = $_REQUEST['kelas'];
	
$semester = "";
if (isset($_REQUEST['semester']))
	$semester = $_REQUEST['semester'];
?>
<body leftmargin="0" topmargin="0">
<form name="panel4" id="panel4" method="post">
<input type="hidden" name="nis" id="nis" value="<?=$nis?>">
<input type="hidden" name="nis_awal" id="nis_awal" value="<?=$nis_awal?>">

<table width="100%" cellspacing="0" cellpadding="0">    
<tr>
	<td width="0">
    <!-- CONTENT GOES HERE //--->	
    <table border="0" cellpadding="2"cellspacing="2" width="100%" style="color:#000000">
     <tr>
    	<td width="18%"><strong>Departemen</strong></td>
      <td width="*"> 
    		<select name="departemen" id="departemen" onChange="change_dep(4)" style="width:150px">
			<? for ($i=0;$i<sizeof($dep);$i++) { ?>        	
         	<option value="<?=$i ?>" <?=IntIsSelected($i, $departemen) ?> > <?=$dep[$i][0] ?> </option>
			<? } ?>
			</select>
    	</td>
      <td><strong>Tahun Ajaran</strong></td>
      <td>
         <select name="tahunajaran" id="tahunajaran" onChange="change_ta(4)" style="width:150px">
   		<? for($k=0;$k<sizeof($ajaran);$k++) 
				{
					if ($tahunajaran == "")
						$tahunajaran = $ajaran[$k][0]; ?>
				<option value="<?=$ajaran[$k][0] ?>" <?=IntIsSelected($ajaran[$k][0], $tahunajaran) ?> > <?=$ajaran[$k][1]?> </option>
			<? } ?>
    		</select>    
		</td>
  	</tr>
    <tr>
		<td width="19%"><strong>Riwayat Kelas</strong></td>
      <td>
        <select name="kelas" id="kelas" onChange="change(4)" style="width:200px">
   		<? for ($j=0;$j<sizeof($kls);$j++) 
				{
					if ($kls[$j][3] == $tahunajaran) 
					{
							if ($kelas == "")
								$kelas = $kls[$j][0];	?>
						<option value="<?=$kls[$j][0] ?>" <?=IntIsSelected($kls[$j][0], $kelas) ?> > <?=$kls[$j][2]." - ".$kls[$j][1] ?> </option>
		<? 		}
			} ?>
    	</select>    
		</td>        
        <td><strong>Semester </strong></td>
        <td>
        <select name="semester" id="semester" onChange="change(4)" style="width:200px">
        <? 	$sql = "SELECT * FROM semester WHERE departemen = '$depart' ORDER BY replid";			
			$result = QueryDb($sql); 				
			while ($row = @mysql_fetch_array($result)) {
			if ($semester == "") 
				$semester = $row['replid'];		
		?>
			<option value="<?=$row['replid']?>" <?=IntIsSelected($row['replid'], $semester) ?> > 
			<?=$row['semester']?> </option>
		<? 	} ?>
    	</select>    
		</td>
    </tr>
    <tr>
      <td><?//=$_REQUEST[semester]?></td><td></td>
    </tr>
<? if ($kelas <> "" && $semester <> "") 
	{ 		
		$sql =
			"SELECT pel.replid as replid,pel.nama as nama 
			 FROM ujian uji, nilaiujian niluji, siswa sis, pelajaran pel 
			 WHERE uji.replid=niluji.idujian AND niluji.nis=sis.nis AND uji.idpelajaran=pel.replid 
			 AND uji.idsemester='$semester' AND uji.idkelas='$kelas' AND sis.nis='$nis' 
			 GROUP BY pel.nama";
 
		$result_get_pelajaran_laporan = QueryDb($sql);
			
    	$num = mysql_num_rows($result_get_pelajaran_laporan);
		echo "<input type='hidden' name='num' id='num' value=$num>";
	if ($num > 0) 
	{ ?>
    <tr>
    	<td colspan="4">
      <fieldset><legend><strong>Laporan Hasil Belajar</strong></legend>
<?		ShowRapor() ?>		
		</fieldset>
    	</td>
	</tr>
  	<tr>
    	<td colspan="4">
      <fieldset><legend><strong>Komentar Hasil Belajar</strong></legend>
<?		ShowKomentar() ?>
		</fieldset>
      </td>
  	</tr>
    </table>
        </td>
  	</tr>
<?	} else { ?>                 
	<tr>
		<td align="center" valign="middle" height="120" colspan="4">
    	<font size = "2" color ="red"><b>Tidak ditemukan adanya data.<br /></font>
		<table id="table2"></table><table id="table3"></table>
		</td>
	</tr>
  	<? } ?>
<? } else { ?>                 
	<tr>
		<td align="center" valign="middle" height="120" colspan="4">
    	<font size = "2" color ="red"><b>Tidak ditemukan adanya data.<br /></font>
		<table id="table2"></table><table id="table3"></table>
		</td>
	</tr>
<? } ?>

    </table>
     <!-- END OF CONTENT //--->
	</td>
</tr>
</table> 
</form>

<?

function ShowKomentar()
{
	global $semester, $kelas, $nis;
	?>
		<table border="1" id="table3" class="tab" width="100%">
		<tr>
            <td width="27%" height="30" align="center" class="header">Pelajaran</td>
            <td width="73%" height="30" align="center" class="header">Komentar</td>
       	</tr>
<?			$sql_get_pelajaran_komentar = 
				"SELECT pel.replid as replid,pel.nama as nama 
				 FROM infonap info, komennap komen, siswa sis, pelajaran pel 
				 WHERE info.replid=komen.idinfo AND komen.nis=sis.nis AND info.idpelajaran=pel.replid 
				 AND info.idsemester='$semester' AND info.idkelas='$kelas' AND sis.nis='$nis' 
				 GROUP BY pel.nama";
			$result_get_pelajaran_komentar = QueryDb($sql_get_pelajaran_komentar);
			$cntpel_komentar=1;
			while ($row_get_pelajaran_komentar=@mysql_fetch_array($result_get_pelajaran_komentar))
			{
				$sql_get_komentar = "SELECT k.komentar 
		          FROM jbsakad.komennap k, jbsakad.infonap i 
				 WHERE k.nis='$nis' AND i.idpelajaran='$row_get_pelajaran_komentar[replid]' AND i.replid = k.idinfo 
				   AND i.idsemester = '$semester' AND i.idkelas = '$kelas'";
				$result_get_komentar=QueryDb($sql_get_komentar);
				$row_get_komentar=@mysql_fetch_row($result_get_komentar); ?>
        <tr>
        	<td height="25"><?=$row_get_pelajaran_komentar[nama]?></td>
        	<td height="25"><?=$row_get_komentar[0]?></td>
        </tr>
	<?			$cntpel_komentar++;
			}
	?>
		</table>
<?      
}

function ShowRapor()
{
	global $semester, $kelas;
	
	$sql = "SELECT DISTINCT a.dasarpenilaian, d.keterangan
	  	      FROM infonap i, nap n, aturannhb a, dasarpenilaian d
			 WHERE i.replid = n.idinfo
			   AND i.idsemester = '$semester' 
			   AND i.idkelas = '$kelas'
			   AND n.idaturan = a.replid 	   
			   AND a.dasarpenilaian = d.dasarpenilaian";
	$res = QueryDb($sql);
	$naspek = mysql_num_rows($res); 
	
	if ($naspek > 2)
		ShowRaporRow();
	else
		ShowRaporColumn();
}

function ShowRaporColumn()
{
	global 	$semester, $kelas, $nis, $NTT;
	$sql = "SELECT DISTINCT a.dasarpenilaian, d.keterangan
		  	    FROM infonap i, nap n, aturannhb a, dasarpenilaian d
			   WHERE i.replid = n.idinfo AND n.nis = '$nis' 
			     AND i.idsemester = '$semester' 
			     AND i.idkelas = '$kelas'
			     AND n.idaturan = a.replid 	   
			     AND a.dasarpenilaian = d.dasarpenilaian";
	$res = QueryDb($sql);
	$i = 0;
	while($row = mysql_fetch_row($res))
	{
		$aspekarr[$i++] = array($row[0], $row[1]);
	} ?>  
	<table width="100%" border="1" class="tab" id="table" bordercolor="#000000">
	<tr>
		<td width="15%" rowspan="2" class="headerlong"><div align="center">Pelajaran</div></td>
		<td width="10%" rowspan="2" class="headerlong"><div align="center">KKM</div></td>
<?		for($i = 0; $i < count($aspekarr); $i++)
			echo "<td class='headerlong' colspan='3' align='center' width='18%'>" . $aspekarr[$i][1] . "</td>"; ?>
		<td width="15%" rowspan="2" class="headerlong"><div align="center">Predikat</div></td>
  	</tr>
	<tr>
<?	for($i = 0; $i < count($aspekarr); $i++)
		echo "<td class='header' align='center' width='7%'>Angka</td>
			   <td class='header' align='center' width='7%'>Huruf</td>
				<td class='header' align='center' width='20%'>Terbilang</td>"; ?>   
   </tr>
<?	$sql = "SELECT pel.replid, pel.nama
				 FROM ujian uji, nilaiujian niluji, siswa sis, pelajaran pel 
				WHERE uji.replid = niluji.idujian 
				  AND niluji.nis = sis.nis 
				  AND uji.idpelajaran = pel.replid 
				  AND uji.idsemester = '$semester'
				  AND uji.idkelas = '$kelas'
				  AND sis.nis = '$nis' 
			GROUP BY pel.nama";
	$respel = QueryDb($sql);
	while($rowpel = mysql_fetch_row($respel))
	{
		$idpel = $rowpel[0];
		$nmpel = $rowpel[1];
		
		$sql = "SELECT nilaimin 
					 FROM infonap
					WHERE idpelajaran = '$idpel'
					  AND idsemester = '$semester'
				     AND idkelas = '$kelas'";
		$res = QueryDb($sql);
		$row = mysql_fetch_row($res);
		$nilaimin = $row[0];
				
		echo "<tr height='25'>";
		echo "<td align='left'>$nmpel</td>";
		echo "<td align='center'>$nilaimin</td>";
		
		for($i = 0; $i < count($aspekarr); $i++)
		{
			$na = "";
			$nh = "";
		
			$asp = $aspekarr[$i][0];
		
			$sql = "SELECT nilaiangka, nilaihuruf
						 FROM infonap i, nap n, aturannhb a 
						WHERE i.replid = n.idinfo 
						  AND n.nis = '$nis' 
						  AND i.idpelajaran = '$idpel' 
						  AND i.idsemester = '$semester' 
						  AND i.idkelas = '$kelas'
						  AND n.idaturan = a.replid 	   
						  AND a.dasarpenilaian = '$asp'";
			$res = QueryDb($sql);
			if (mysql_num_rows($res) > 0)
			{
				$row = mysql_fetch_row($res);
				$na = $row[0];
				$nh = $row[1];
			}
			$say = $NTT->Convert($na);
			echo "<td align='center'>$na</td><td align='center'>$nh</td><td align='left'>$say</td>"; 
		} 
		
		$pred = "";
		$sql = "SELECT predikat 
				  FROM infonap i, komennap k
				 WHERE i.replid = k.idinfo
				   AND k.nis = '$nis' 
				   AND i.idpelajaran = '$idpel' 
				   AND i.idsemester = '$semester' 
				   AND i.idkelas = '$kelas'";
		$res = QueryDb($sql);
		if (mysql_num_rows($res) > 0)
		{
			$row = mysql_fetch_row($res);
			$tmp = (int)$row[0];
			
			switch ($tmp)
			{
				case 4:	$pred = "Istimewa"; break;
				case 3:	$pred = "Baik"; break;
				case 2:	$pred = "Cukup"; break;
				case 1:	$pred = "Kurang"; break;
				case 0:	$pred = "Buruk"; break;
				default:
					$pred = "Baik";
			}
		}			
		echo "<td align='left'>$pred</td>"; 
		echo "</tr>";
	}
	echo "</table>";
}

function ShowRaporRow()
{ 
	global 	$semester, $kelas, $nis, $NTT; ?>
    <table width="100%" border="1" class="tab" bordercolor="#000000">
    <tr>
        <td width="4%" rowspan="2" class="headerlong"><div align="center">No</div></td>
        <td width="12%" rowspan="2" class="headerlong"><div align="center">Pelajaran</div></td>
        <td width="7%" rowspan="2" class="headerlong"><div align="center">KKM</div></td>
        <td width="12%" rowspan="2" class="headerlong"><div align="center">Aspek<br>Penilaian</div></td>
        <td width="35%" colspan="3" class="headerlong"><div align="center">Nilai</div></td>
    </tr>
    <tr>
        <td width="7%" class="headerlong"><div align="center">Angka</div></td>
        <td width="7%" class="headerlong"><div align="center">Huruf</div></td>
        <td width="20%" class="headerlong"><div align="center">Terbilang</div></td>
    </tr>
   
<? 	$sql = "SELECT pel.replid, pel.nama
              FROM ujian uji, nilaiujian niluji, siswa sis, pelajaran pel 
             WHERE uji.replid = niluji.idujian 
               AND niluji.nis = sis.nis 
               AND uji.idpelajaran = pel.replid 
               AND uji.idsemester = '$semester'
               AND uji.idkelas = '$kelas'
               AND sis.nis = '$nis' 
         GROUP BY pel.nama";    
    $res = QueryDb($sql);
    $i = 0;
    while($row = mysql_fetch_row($res))
    {
        $pelarr[$i++] = array($row[0], $row[1]);
    }
    
    for($i = 0; $i < count($pelarr); $i++)
    {
        $idpel = $pelarr[$i][0];
        $nmpel = $pelarr[$i][1];
        
        $sql = "SELECT nilaimin 
                 FROM infonap
                WHERE idpelajaran = '$idpel'
                  AND idsemester = '$semester'
                  AND idkelas = '$kelas'";
        $res = QueryDb($sql);
        $row = mysql_fetch_row($res);
        $nilaimin = $row[0];
        
        $sql = "SELECT DISTINCT a.dasarpenilaian, d.keterangan 
                FROM infonap i, nap n, aturannhb a, dasarpenilaian d 
               WHERE i.replid = n.idinfo AND n.nis = '$nis' 
                 AND i.idpelajaran = '$idpel' 
                 AND i.idsemester = '$semester' 
                 AND i.idkelas = '$kelas' 
                 AND n.idaturan = a.replid  	   
                 AND a.dasarpenilaian = d.dasarpenilaian";	
        $res = QueryDb($sql);				 
        $aspekarr = array();				 
        $j = 0;
        while($row = mysql_fetch_row($res))
        {
            $na = "";
            $nh = "";
            $asp = $row[0];
            
            $sql = "SELECT nilaiangka, nilaihuruf
                      FROM infonap i, nap n, aturannhb a 
                     WHERE i.replid = n.idinfo 
                       AND n.nis = '$nis' 
                       AND i.idpelajaran = '$idpel' 
                       AND i.idsemester = '$semester' 
                       AND i.idkelas = '$kelas'
                       AND n.idaturan = a.replid 	   
                       AND a.dasarpenilaian = '$asp'";
            $res2 = QueryDb($sql);
            if (mysql_num_rows($res2) > 0)
            {
                $row2 = mysql_fetch_row($res2);
                $na = $row2[0];
                $nh = $row2[1];
            }
            
            $aspekarr[$j++] = array($row[0], $row[1], $na, $nh);
        } 
        $naspek = count($aspekarr);
        
        if ($naspek > 0)
        { ?>
            <tr height="20">
                <td rowspan="<?=$naspek?>" align="center"><?=$i + 1?></td>
                <td rowspan="<?=$naspek?>" align="left"><?=$nmpel?></td>
                <td rowspan="<?=$naspek?>" align="center"><?=$nilaimin?></td>
                <td align="left"><?=$aspekarr[0][1]?></td>
                <td align="center"><?=$aspekarr[0][2]?></td>
                <td align="center"><?=$aspekarr[0][3]?></td>
                <td align="left"><?=$NTT->Convert($aspekarr[0][2])?></td>
            </tr>
<?			for($k = 1; $k < $naspek; $k++)
            { ?>
                <tr height="20">
                    <td align="left"><?=$aspekarr[$k][1]?></td>
                    <td align="center"><?=$aspekarr[$k][2]?></td>
                    <td align="center"><?=$aspekarr[$k][3]?></td>
                    <td align="left"><?=$NTT->Convert($aspekarr[$k][2])?></td>
                </tr>
<?			} // end for
        } 
        else
        { ?>
            <tr height="20">
                <td align="center"><?=$i + 1?></td>
                <td align="left"><?=$nmpel?></td>
                <td align="center"><?=$nilaimin?></td>
                <td align="left">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
            </tr>		
<?		}// end if
    } ?>
    </table>

<? 
}
?>
