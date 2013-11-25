<?
require_once('../include/common.php');
require_once('../include/config.php');
require_once('../include/db_functions.php');
require_once('jurnal.php');

OpenDb();

echo  "<pre>";

$idtahunbuku = 1;
$n_aktiva = 0;
$n_pasiva = 0;

$sql = "SELECT jd.koderek, SUM(jd.debet - jd.kredit) 
			 FROM jurnal j, jurnaldetail jd, rekakun ra 
		   WHERE j.replid = jd.idjurnal AND jd.koderek = ra.kode AND j.idtahunbuku = '$idtahunbuku' 
			  AND ra.kategori IN ('HARTA', 'PIUTANG', 'INVENTARIS') 
		GROUP BY jd.koderek, ra.nama ORDER BY jd.koderek";
$result = QueryDb($sql); 
while($row = mysql_fetch_row($result))
{
	$aktiva[$n_aktiva]["kode"] = $row[0];
	$aktiva[$n_aktiva]["jumlah"] = (float)$row[1];
	$n_aktiva++;
}

$sql = "SELECT jd.koderek, sum(jd.kredit - jd.debet) 
			 FROM jurnal j, jurnaldetail jd, rekakun ra 
			WHERE j.replid = jd.idjurnal AND jd.koderek = ra.kode AND j.idtahunbuku = '$idtahunbuku' 
			  AND ra.kategori = 'UTANG' 
		GROUP BY jd.koderek, ra.nama ORDER BY jd.koderek";
$result = QueryDb($sql); 
while($row = mysql_fetch_row($result))
{
	$pasiva[$n_pasiva]["kode"] = $row[0];
	$pasiva[$n_pasiva]["jumlah"] = (float)$row[1];
	$n_pasiva++;
}

$sql = "SELECT SUM(jd.kredit - jd.debet) 
		    FROM rekakun ra, jurnal j, jurnaldetail jd 
		   WHERE jd.idjurnal = j.replid AND jd.koderek = ra.kode AND j.idtahunbuku = '$idtahunbuku' 
			  AND ra.kategori IN ('PENDAPATAN', 'MODAL')";
$income = (float)FetchSingle($sql);
		
$sql = "SELECT SUM(jd.debet - jd.kredit) 
			 FROM rekakun ra, jurnal j, jurnaldetail jd 
			WHERE jd.idjurnal = j.replid AND jd.koderek = ra.kode AND j.idtahunbuku = '$idtahunbuku' 
			  AND ra.kategori='BIAYA'";
$outcome = (float)FetchSingle($sql);

$re = $income - $outcome;

//Ambil awalan dan cacah tahunbuku untuk bikin nokas;
$sql = "SELECT awalan, cacah, tanggalmulai FROM tahunbuku WHERE replid = 4";
$row2 = FetchSingleRow($sql);
$awalan = $row2[0];
$cacah = $row2[1];
$tcicilan = $row2[2];

$cacah += 1; // Increment cacah
$nokas = $awalan . rpad($cacah, "0", 6); // Form nomor kas

$success = true;
BeginTrans();

// Simpan ke jurnal
$idjurnal = 0;
if ($success)
	$success = SimpanJurnal(4, "2010-03-02", "Saldo Awal Tahun Buku 2010/2011 Dept SMA", $nokas, "", "SYSTEM", "saldoawal", $idjurnal);

// Save Aktiva
for($i = 0; $success && $i < count($aktiva); $i++)
{
	$kode = $aktiva[$i]["kode"];
	$jumlah = $aktiva[$i]["jumlah"];
	
	if ($jumlah > 0)
		$success = SimpanDetailJurnal($idjurnal, "D", $kode, $jumlah);
	else
		$success = SimpanDetailJurnal($idjurnal, "K", $kode, abs($jumlah));
}

// Save Pasiva
for($i = 0; $success && $i < count($pasiva); $i++)
{
	$kode = $pasiva[$i]["kode"];
	$jumlah = $pasiva[$i]["jumlah"];
	
	if ($jumlah > 0)
		$success = SimpanDetailJurnal($idjurnal, "K", $kode, $jumlah);
	else
		$success = SimpanDetailJurnal($idjurnal, "D", $kode, abs($jumlah));
}

// Retained Earning
if ($success)
{
	if ($re > 0)
		$success = SimpanDetailJurnal($idjurnal, "K", "313", $re);
	else
		$success = SimpanDetailJurnal($idjurnal, "D", "313", abs($re));
}

//increment cacah di tahunbuku
if ($success) 
{
	$sql = "UPDATE tahunbuku SET cacah=cacah+1, info1 = '$idjurnal' WHERE replid = 4";
	QueryDbTrans($sql, $success);
}
	
if ($success)
	CommitTrans();
else
	RollbackTrans();

if ($success)
	echo  "OKAY $idjurnal";
else
	echo  mysql_error();
				
echo  "</pre>";
CloseDb();
?>