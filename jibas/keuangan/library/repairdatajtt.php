<?
////
// INJECTION CODE
//  - untuk mengupgrade data JIBAS keuangan agar menjadi sesuai dengan versi 2.1 atau lebih
//  - this script will be removed on future release

//require_once('../include/common.php');
//require_once('../include/config.php');
//require_once('../include/db_functions.php');
//require_once('jurnal.php');

OpenDb();

$sql = "SELECT COUNT(replid) FROM besarjtt WHERE info2 IS NULL";
$n = FetchSingle($sql);
if ($n > 0)
{
	set_time_limit(1000);
	
	$sql = "SET @DISABLE_TRIGGERS = 1;";
	QueryDb($sql);

	$sql = "SELECT departemen FROM jbsakad.departemen";
	$res = QueryDb($sql);
	while($row = mysql_fetch_row($res))
	{
		$deparr[] = $row[0];
	}
	
	for($dn = 0; $dn < count($deparr); $dn++)
	{
		$departemen = $deparr[$dn];

		$sql = "SELECT replid FROM tahunbuku WHERE departemen='$departemen' ORDER BY replid";
		$res = QueryDb($sql);
		$tbarr = array();
		while ($row = mysql_fetch_row($res))
		{
			$tbarr[] = $row[0];
		}
		
		fixBesarJtt_01($departemen);
		fixBesarJtt_02($departemen);
		fixBesarJtt_03($departemen);
	}
	
	$sql = "SET @DISABLE_TRIGGERS = NULL;";
	QueryDb($sql);
}

CloseDb();

function fixBesarJtt_01($departemen)
{
	// cari tahu semua siswa yang memiliki besar pembayaran tapi belum di update
	global $tbarr;
	
	$sql = "SELECT b.replid, b.nis, b.idpenerimaan, s.nama, b.besar 
	          FROM besarjtt b, jbsakad.siswa s, jbsakad.angkatan a 
				WHERE b.nis = s.nis AND s.idangkatan = a.replid AND a.departemen = '$departemen'
				  AND b.info2 IS NULL AND b.besar <> 0 AND EXISTS(SELECT replid FROM penerimaanjtt WHERE idbesarjtt = b.replid)";
	$res = QueryDb($sql);
	
	$success = true;
	BeginTrans();
	
	while ($success && ($row = mysql_fetch_row($res)))
	{
		$idbesarjtt = $row[0];
		$nis = $row[1];
		$idpenerimaan = $row[2];
		$namasiswa = $row[3];
		$namasiswa = str_replace("'", "`", $namasiswa);
		$besarjtt = (float)$row[4];
		
		$sql = "SELECT rekkas, rekpiutang, rekpendapatan, nama FROM datapenerimaan WHERE replid = '$idpenerimaan'";
		$row2 = FetchSingleRow($sql);
		$rekkas = $row2[0];
		$rekpiutang = $row2[1];
		$rekpendapatan = $row2[2];
		$namapenerimaan = $row2[3];
		
		$sql = "SELECT j.replid, j.idtahunbuku, j.tanggal, p.jumlah
		        FROM penerimaanjtt p, jurnal j, besarjtt b
				  WHERE b.idpenerimaan = '$idpenerimaan' AND p.idbesarjtt = '$idbesarjtt' AND p.idbesarjtt = b.replid
				    AND p.idjurnal = j.replid ORDER BY j.replid LIMIT 1";
		$res2 = QueryDb($sql);
		if (mysql_num_rows($res2) > 0)
		{
			$row2 = mysql_fetch_row($res2);
			$idjurnal = $row2[0];
			$idtahunbuku = $row2[1];
			$tanggal = $row2[2];
			$jumlah = (float)$row2[3];
			
			$sql = "SELECT COUNT(replid) FROM jurnaldetail WHERE idjurnal = '$idjurnal' AND koderek IN ('$rekkas', '$rekpendapatan', '$rekpiutang')";
			$n = FetchSingle($sql);
			
			if ($n == 3)
			{
				// Perbaiki cicilan pertama yang terdiri dari 3 koderek ==> Siswa membayar cicilan pertama
				$sql = "SELECT debet FROM jurnaldetail WHERE idjurnal = '$idjurnal' AND koderek = '$rekkas'";
				$kas = FetchSingle($sql);
				
				$sql = "SELECT kredit FROM jurnaldetail WHERE idjurnal = '$idjurnal' AND koderek = '$rekpendapatan'";
				$pendapatan = FetchSingle($sql);
				
				$sql = "DELETE FROM jurnaldetail WHERE idjurnal = '$idjurnal'";
				QueryDbTrans($sql, $success);
				
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $pendapatan);			
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $pendapatan);
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $kas);			
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "K", $rekpiutang, $kas);					
				
				if ($success)
				{
					$sql = "UPDATE besarjtt SET info1 = '$idjurnal', info2 = '$idtahunbuku' WHERE replid = '$idbesarjtt'";
					QueryDbTrans($sql, $success);
				}
			}
			elseif ($n == 2)
			{
				if ($besarjtt != $jumlah)
				{
					// BUGS: Perbaiki cicilan pertama menjadi 3 koderek ==> Siswa membayar cicilan pertama
					
					$sql = "DELETE FROM jurnaldetail WHERE idjurnal = '$idjurnal'";
					QueryDbTrans($sql, $success);
					
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $besarjtt);			
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $besarjtt);
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jumlah);
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "K", $rekpiutang, $jumlah);	
				}
				
				if ($success)
				{
					$sql = "UPDATE besarjtt SET info1 = '$idjurnal', info2 = '$idtahunbuku' WHERE replid = '$idbesarjtt'";
					QueryDbTrans($sql, $success);
				}
			}
			elseif ($n == 0)
			{
				// BUGS: Perbaiki cicilan pertama
				
				$sql = "DELETE FROM jurnaldetail WHERE idjurnal = '$idjurnal'";
				QueryDbTrans($sql, $success);

				$lunas = 0;
				if ($besarjtt != $jumlah)
				{
					// jikas jumlah < besarjtt maka ini merupakan cicilan pertama
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $besarjtt);			
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $besarjtt);
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jumlah);
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "K", $rekpiutang, $jumlah);	
				}
				else
				{
					// jikas jumlah = besarjtt maka langsung pelunasan
					$lunas = 1;
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $besarjtt);
					if ($success) 
						$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $besarjtt);	
				}
				
				if ($success)
				{
					$sql = "UPDATE besarjtt SET info1 = '$idjurnal', info2 = '$idtahunbuku', lunas=$lunas WHERE replid = $idbesarjtt";
					QueryDbTrans($sql, $success);
				}
			}
		}
	}
	
	if ($success)
		CommitTrans();
	else
		RollbackTrans();
}

function fixBesarJtt_02($departemen)
{
	// cari tahu semua siswa yang TIDAK memiliki besar pembayaran tapi belum di update
	global $tbarr;
	
	$sql = "SELECT b.replid, b.nis, b.idpenerimaan, s.nama
	          FROM besarjtt b, jbsakad.siswa s, jbsakad.angkatan a 
				WHERE b.nis = s.nis AND s.idangkatan = a.replid AND a.departemen = '$departemen'
				  AND b.info2 IS NULL AND b.besar = 0 AND b.lunas = 2";
	$res = QueryDb($sql);
	
	$success = true;
	BeginTrans();
	
	while ($success && ($row = mysql_fetch_row($res)))
	{
		$idbesarjtt = $row[0];
		$nis = $row[1];
		$idpenerimaan = $row[2];
		$namasiswa = $row[3];
		$namasiswa = str_replace("'","`",$namasiswa);
		
		$sql = "SELECT rekkas, rekpiutang, rekpendapatan, nama FROM datapenerimaan WHERE replid = '$idpenerimaan'";
		$row2 = FetchSingleRow($sql);
		$rekkas = $row2[0];
		$rekpiutang = $row2[1];
		$rekpendapatan = $row2[2];
		$namapenerimaan = $row2[3];
		
		$cont = true;
		for($i = 0; $cont && $i < count($tbarr); $i++)
		{
			$idtahunbuku = $tbarr[$i];
			
			$sql = "SELECT COUNT(replid) FROM besarjtt WHERE nis = '$nis' AND idpenerimaan = '$idpenerimaan' AND info2 = '$idtahunbuku'";
			if (FetchSingle($sql) == 0)
			{
				//Ambil awalan dan cacah tahunbuku untuk bikin nokas;
				$sql = "SELECT awalan, cacah, tanggalmulai FROM tahunbuku WHERE replid = '$idtahunbuku'";
				$row2 = FetchSingleRow($sql);
				$awalan = $row2[0];
				$cacah = $row2[1];
				$tcicilan = $row2[2];
		
				$cacah += 1; // Increment cacah
				$nokas = $awalan . rpad($cacah, "0", 6); // Form nomor kas
				
				// tanggal & petugas pendata & keterangan
				$petugas = "SYSTEM";
				$keterangan = "Perbaikan data besar pembayaran $namapenerimaan siswa $namasiswa ($nis)";
		
				// simpan ke table jurnal
				$idjurnal = 0;
				if ($success)
					$success = SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, "", $petugas, "penerimaanjtt", $idjurnal);
				
				// simpan ke table jurnaldetail
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, 0);			
				if ($success) 
					$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, 0);
				
				//increment cacah di tahunbuku
				if ($success) 
				{
					$sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid = '$idtahunbuku'";
					QueryDbTrans($sql, $success);
				}
				
				if ($success)
				{
					$sql = "UPDATE besarjtt SET info1 = '$idjurnal', info2 = '$idtahunbuku' WHERE replid = '$idbesarjtt'";
					QueryDbTrans($sql, $success);
				}
				
				$cont = false;
			}
		}
	}
	
	if ($success)
		CommitTrans();
	else
		RollbackTrans();
}

function fixBesarJtt_03($departemen)
{
	// cari tahu semua siswa yang baru didata besar pembayaran tapi BELUM terjadi transaksi
	global $tbarr;
	
	$sql = "SELECT replid FROM tahunbuku WHERE departemen='$departemen' AND aktif=1";
	$idtahunbuku = FetchSingle($sql);
	
	$sql = "SELECT b.replid, b.nis, b.idpenerimaan, s.nama, b.besar
	          FROM besarjtt b, jbsakad.siswa s, jbsakad.angkatan a 
				WHERE b.nis = s.nis AND s.idangkatan = a.replid AND a.departemen = '$departemen'
				  AND b.info2 IS NULL AND b.besar <> 0 AND NOT EXISTS (SELECT replid FROM penerimaanjtt WHERE idbesarjtt = b.replid)";
	$res = QueryDb($sql);

	$success = true;
	BeginTrans();
	
	while ($success && ($row = mysql_fetch_row($res)))
	{
		$idbesarjtt = $row[0];
		$nis = $row[1];
		$idpenerimaan = $row[2];
		$namasiswa = $row[3];
		$namasiswa = str_replace("'","`",$namasiswa);
		$besarjtt = $row[4];
		
		$sql = "SELECT rekkas, rekpiutang, rekpendapatan, nama FROM datapenerimaan WHERE replid = '$idpenerimaan'";
		$row2 = FetchSingleRow($sql);
		$rekkas = $row2[0];
		$rekpiutang = $row2[1];
		$rekpendapatan = $row2[2];
		$namapenerimaan = $row2[3];
		
		//Ambil awalan dan cacah tahunbuku untuk bikin nokas;
		$sql = "SELECT awalan, cacah, tanggalmulai FROM tahunbuku WHERE replid = '$idtahunbuku'";
		$row2 = FetchSingleRow($sql);
		$awalan = $row2[0];
		$cacah = $row2[1];
		$tcicilan = $row2[2];
		
		$cacah += 1; // Increment cacah
		$nokas = $awalan . rpad($cacah, "0", 6); // Form nomor kas
				
		// tanggal & petugas pendata & keterangan
		$petugas = "SYSTEM";
		$keterangan = "Perbaikan data besar pembayaran $namapenerimaan siswa $namasiswa ($nis)";
		
		// simpan ke table jurnal
		$idjurnal = 0;
		if ($success)
			$success = SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, "", $petugas, "penerimaanjtt", $idjurnal);
				
		// simpan ke table jurnaldetail
		if ($success) 
			$success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $besarjtt);			
		if ($success) 
			$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $besarjtt);
				
		//increment cacah di tahunbuku
		if ($success) 
		{
			$sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid = '$idtahunbuku'";
			QueryDbTrans($sql, $success);
		}
				
		if ($success)
		{
			$sql = "UPDATE besarjtt SET info1 = '$idjurnal', info2 = '$idtahunbuku' WHERE replid = '$idbesarjtt'";
			QueryDbTrans($sql, $success);
		}
	}
	
	if ($success)
		CommitTrans();
	else
		RollbackTrans();
}
?>