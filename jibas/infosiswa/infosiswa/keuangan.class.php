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
class CK
{
	var $nis, $db_name_fina;
	
	private $departemen;
	private $arrdept;
	
	private $idtahunbuku;
	private $arrta;
	
	public function __construct()
	{
		$this->departemen = 0;
		if (isset($_REQUEST['departemen']))
			$this->departemen = $_REQUEST['departemen'];
			
		$this->idtahunbuku = 0;
		if (isset($_REQUEST['idtahunbuku']))
			$this->idtahunbuku = $_REQUEST['idtahunbuku'];
	}
	
	public function ShowDepartemenComboBox()
	{
		// Dapatkan nis, jenjang dan replid sekarang dan terdahuku
		$check_nis = $_REQUEST['nis'];
		do
		{
			$sql = "SELECT replid, departemen, nislama FROM riwayatdeptsiswa WHERE nis='$check_nis'";
			$result = QueryDb($sql);
			$nrow = mysql_num_rows($result);
			if ($nrow > 0)
			{
				$row = mysql_fetch_array($result);
				$this->arrdept[] = array($row['departemen'], $check_nis);
				
				$check_nis = $row['nislama'];
			}
		}
		while($nrow > 0);
		
		echo "Departemen: <select name='departemen' disabled class='cmbfrm' id='departemen' style='width:150px' onChange=\"ChangeKeuOption('departemen')\">";
 		for ($i = 0; $i < count($this->arrdept); $i++)
		{         	
			echo "<option value='$i' " . IntIsSelected($i, $this->departemen) . " > " . $this->arrdept[$i][0] . "</option>";
 		} 
		echo "</select>";
	}
	
	public function ShowTahunBukuComboBox()
	{
		$vnis = $this->arrdept[$this->departemen][1];
		$vdept = $this->arrdept[$this->departemen][0];
		
		$sql = "SELECT idtahunbuku, tahunbuku FROM
				(
				SELECT DISTINCT j.idtahunbuku, t.tahunbuku 
				  FROM jbsfina.besarjtt b, jbsfina.penerimaanjtt p, jbsfina.jurnal j, jbsfina.tahunbuku t
				 WHERE b.nis = '$vnis' AND t.departemen = '$vdept'
				   AND b.replid = p.idbesarjtt 
				   AND p.idjurnal = j.replid
				   AND j.idtahunbuku = t.replid
				 UNION
				SELECT DISTINCT j.idtahunbuku, t.tahunbuku
				  FROM jbsfina.penerimaaniuran p, jbsfina.jurnal j, jbsfina.tahunbuku t
				 WHERE p.nis = '$vnis' AND t.departemen = '$vdept'
				   AND p.idjurnal = j.replid
				   AND j.idtahunbuku = t.replid
				) AS X
				ORDER BY idtahunbuku DESC";		
		$result = QueryDb($sql);
		
		echo "Tahun Buku: <select name='idtahunbuku' disabled class='cmbfrm' id='idtahunbuku' style='width:150px' onChange=\"ChangeKeuOption('tahunbuku')\">";
		while($row = mysql_fetch_row($result))
		{
			if ($this->idtahunbuku == 0)
				$this->idtahunbuku = $row[0];
				
			echo "<option value='$row[0]' " . IntIsSelected($row[0], $this->idtahunbuku) . " > " . $row[1] . "</option>";
		}
		echo "</select>";				
	}
    
	function ShowFinanceReport()
    {
		$departemen = $this->arrdept[$this->departemen][0];
		$nis = $this->arrdept[$this->departemen][1];
		$idtahunbuku = $this->idtahunbuku;
				
		$sql =	"SELECT s.nama, k.kelas
				   FROM siswa s, kelas k
				  WHERE s.nis = '$nis' AND s.idkelas = k.replid ";
		$result = QueryDb($sql);
		$row = mysql_fetch_row($result);
		$namasiswa = $row[0];
		$kelas = $row[1]; ?>
		
		<input type="hidden" name="current_nis" id="current_nis" value="<?=$nis?>">
		<input type="hidden" name="current_dept" id="current_dept" value="<?=$departemen?>">
		<input type="hidden" name="current_tb" id="current_tb" value="<?=$idtahunbuku?>">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
		<tr>
			<td valign="top" background="" style="background-repeat:no-repeat; background-attachment:fixed">

			<table class="tab" id="table" border="1"  width="100%" align="center">
<?
			$sql =	"SELECT DISTINCT b.replid, b.besar, b.lunas, b.keterangan, d.nama
					   FROM jbsfina.besarjtt b, jbsfina.penerimaanjtt p, jbsfina.datapenerimaan d
					  WHERE p.idbesarjtt = b.replid
					    AND b.idpenerimaan = d.replid
						AND b.nis='$nis'
						AND b.info2='$idtahunbuku'
					  ORDER BY nama";
			$result = QueryDb($sql);
			while ($row = mysql_fetch_array($result))
			{
				$idbesarjtt = $row['replid'];
				$namapenerimaan = $row['nama']; 
				$besar = $row['besar'];
				$lunas = $row['lunas'];
				$keterangan = $row['keterangan'];
			
				$sql = "SELECT SUM(jumlah), SUM(info1) FROM jbsfina.penerimaanjtt WHERE idbesarjtt = '$idbesarjtt'";
				$result2 = QueryDb($sql);
				$pembayaran = 0;
				$diskon = 0;
				if (mysql_num_rows($result2))
				{
					$row2 = mysql_fetch_row($result2);
					$pembayaran = $row2[0] + $row2[1];
					$diskon = $row2[1];
				};
				$sisa = $besar - $pembayaran;
			
				$sql = "SELECT jumlah, DATE_FORMAT(tanggal, '%d-%b-%Y') AS ftanggal
						  FROM jbsfina.penerimaanjtt
						 WHERE idbesarjtt='$idbesarjtt'
						 ORDER BY tanggal DESC, replid DESC LIMIT 1";
			
				$result2 = QueryDb($sql);
				$byrakhir = 0;
				$tglakhir = "";
				if (mysql_num_rows($result2))
				{
					$row2 = mysql_fetch_row($result2);
					$byrakhir = $row2[0];
					$tglakhir = $row2[1];
				};	?>
		   
				<tr height="35">
					<td colspan="4" bgcolor="#99CC00" class="header"><font size="2"><strong><em><?=$namapenerimaan?></em></strong></font></td>
				</tr>    
				<tr height="25">
					<td width="20%" bgcolor="#CCFF66"><strong>Total Bayaran</strong> </td>
					<td width="15%" bgcolor="#FFFFFF" align="right"><?=FormatRupiah($besar) ?></td>
					<td width="22%" bgcolor="#CCFF66" align="center"><strong>Pembayaran Terakhir</strong></td>
					<td width="43%" bgcolor="#CCFF66" align="center"><strong>Keterangan</strong></td>
				</tr>
				<tr height="25">
					<td bgcolor="#CCFF66"><strong>Jumlah Besar Pembayaran</strong> </td>
					<td bgcolor="#FFFFFF" align="right"><?=FormatRupiah($pembayaran) ?></td>
					<td bgcolor="#FFFFFF" align="center" valign="top" rowspan="2"><?=FormatRupiah($byrakhir) . "<br><i>" . $tglakhir . "</i>" ?> </td>
					<td bgcolor="#FFFFFF" align="left" valign="top" rowspan="2"><?=$keterangan ?></td>
				</tr>
				<tr height="25">
					<td bgcolor="#CCFF66"><strong>Jumlah Diskon</strong> </td>
					<td bgcolor="#FFFFFF" align="right"><?=FormatRupiah($diskon) ?></td>
				</tr>
				<tr height="25">
					<td bgcolor="#CCFF66"><strong>Sisa Bayaran</strong> </td>
					<td bgcolor="#FFFFFF" align="right"><?=FormatRupiah($sisa) ?></td>
				</tr>
				<tr height="3">
					<td colspan="4" bgcolor="#E8E8E8">&nbsp;</td>
				</tr>
<? 			} //while iuran wajib
		
			$sql =	"SELECT DISTINCT p.idpenerimaan, d.nama
					   FROM jbsfina.penerimaaniuran p, jbsfina.jurnal j, jbsfina.datapenerimaan d
					  WHERE p.idpenerimaan = d.replid
					    AND p.idjurnal = j.replid
						AND j.idtahunbuku = '$idtahunbuku'
					    AND p.nis = '$nis'
					  ORDER BY nama";
			
			$result = QueryDb($sql);
			while ($row = mysql_fetch_array($result))
			{
				$idpenerimaan = $row['idpenerimaan'];
				$namapenerimaan = $row['nama'];
			
				$sql = "SELECT SUM(jumlah)
						  FROM jbsfina.penerimaaniuran
						 WHERE idpenerimaan='$idpenerimaan'
						   AND nis='$nis'";
				$result2 = QueryDb($sql);
				$pembayaran = 0;
				if (mysql_num_rows($result2))
				{
					$row2 = mysql_fetch_row($result2);
					$pembayaran = $row2[0];
				};
		
				$sql = "SELECT jumlah, DATE_FORMAT(tanggal, '%d-%b-%Y') AS ftanggal
						  FROM jbsfina.penerimaaniuran
						 WHERE idpenerimaan='$idpenerimaan'
						   AND nis='$nis'
						 ORDER BY tanggal DESC LIMIT 1";
				$result2 = QueryDb($sql);
				$byrakhir = 0;
				$tglakhir = "";
				if (mysql_num_rows($result2))
				{
					$row2 = mysql_fetch_row($result2);
					$byrakhir = $row2[0];
					$tglakhir = $row2[1];
				};	?>
				
				<tr height="35">
					<td colspan="4" bgcolor="#99CC00" class="header"><font size="2"><strong><em><?=$namapenerimaan?></em></strong></font></td>
				</tr>  
				<tr height="25">
					<td width="22%" bgcolor="#CCFF66" align="center"><strong>Total Pembayaran</strong> </td>
					<td width="22%" bgcolor="#CCFF66" align="center"><strong>Pembayaran Terakhir</strong></td>
					<td width="50%" colspan="2" bgcolor="#CCFF66" align="center"><strong>Keterangan</strong></td>
				</tr>
				<tr height="25">
					<td bgcolor="#FFFFFF" align="center"><?=FormatRupiah($pembayaran) ?></td>
					<td bgcolor="#FFFFFF" align="center"><?=FormatRupiah($byrakhir) . "<br><i>" . $tglakhir . "</i>" ?></td>
					<td colspan="2" bgcolor="#FFFFFF" align="left">&nbsp;</td>
				</tr>
				<tr height="3">
					<td colspan="4" bgcolor="#E8E8E8">&nbsp;</td>
				</tr>
<?			} //while iuran sukarela ?>
			</table>
			</tr>
		</td>
		</table>
        <?
			}
}
?>