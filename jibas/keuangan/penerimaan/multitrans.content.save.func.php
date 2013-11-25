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
require_once('../include/sessioninfo.php');
require_once('../include/rupiah.php');

function GetNoKas()
{
    global $idtahunbuku;
    
    //Ambil awalan dan cacah tahunbuku untuk bikin nokas;
    $sql = "SELECT awalan, cacah
              FROM tahunbuku
             WHERE replid = '$idtahunbuku'";
	//echo "$sql<br>";		 
    $row = FetchSingleRow($sql);
    $awalan = $row[0];
    $cacah = $row[1];
    
    $cacah += 1; // Increment cacah
    $nokas = $awalan . rpad($cacah, "0", 6); // Form nomor kas
    
    return $nokas;
}

function CountTotalPayment()
{
	global $transactions;
	
	$total = 0;
	for($i = 0; $i < count($transactions); $i++)
	{
		$total += $transactions[$i][2] - $transactions[$i][3];
	}
	echo "\r\n<input type='hidden' id='total' name='total' value='$total'>";
}

function CreateDivPrintReportCompact()
{
	global $transactions;
	
	$list = "";
	for($i = 0; $i < count($transactions); $i++)
	{
		if ($list != "")
			$list .= ", ";
		$list .= $transactions[$i][1];
	}
	echo "\r\n<input type='hidden' id='paymentlist' name='paymentlist' value='$list'>";
}

function CreateDivPrintReportDetail()
{
	global $transactions;
	
	echo "<table border='1' cellpadding='2' cellspacing='0' style='border-width: 1px; border-collapse: collapse;'>";
	echo "<tr height='25'>";
	echo "<td width='25' align='center'>No</td>";
	echo "<td width='80' align='center'>No Transaksi</td>";
	echo "<td width='200' align='center'>Transaksi</td>";
	echo "<td width='100' align='center'>Jumlah</td>";
	echo "<td width='100' align='center'>Diskon</td>";
	echo "<td width='120' align='center'>Sub Total</td>";
	echo "</tr>";
	
	$total = 0;
	for($i = 0; $i < count($transactions); $i++)
	{
		$subtotal = $transactions[$i][2] - $transactions[$i][3];
		$total += $subtotal;
		
		echo "<tr height='35'>";
		echo "<td align='center' valign='top'>" . ($i + 1) . "</td>";
		echo "<td align='center' valign='top'>" . $transactions[$i][0] . "</td>";
		echo "<td align='left' valign='top'>" . $transactions[$i][1] . "</td>";
		echo "<td align='right' valign='top'>" . FormatRupiah($transactions[$i][2]) . "</td>";
		echo "<td align='right' valign='top'>" . FormatRupiah($transactions[$i][3]) . "</td>";
		echo "<td align='right' valign='top'>" . FormatRupiah($subtotal) . "</td>";
		echo "</tr>";
	}
	
	echo "<tr height='25'>";
	echo "<td colspan='5' align='right'><strong>TOTAL</strong></td>";
	echo "<td align='right'><strong>". FormatRupiah($total) . "</strong></td>";
	echo "</tr>";
	echo "</table>";
}

function SaveIuranSukarelaSiswa($rowno)
{
	global $studentid, $studentname, $idtahunbuku;
	global $transactions;
	
	$tmp = "i_idpayment_$rowno";
    $idpayment = $_REQUEST[$tmp];
    
    $tmp = "i_jumlah_$rowno";
    $jumlah = (int)$_REQUEST[$tmp];
    
    $tmp = "i_keterangan_$rowno";
    $keterangan = $_REQUEST[$tmp];
    
    $tmp = "i_infocicilan_$rowno";
    $infocicil = $_REQUEST[$tmp];
	
	$tmp = "i_rekkas_$rowno";
    $rekkas = $_REQUEST[$tmp];
	
	//echo "Iuran Sukarela Siswa = $idpayment ------<br>";
	$success = true;
	
	 // Ambil informasi kode rekening berdasarkan jenis penerimaan
	$sql = "SELECT rekkas, rekpiutang, rekpendapatan, info1, nama
              FROM jbsfina.datapenerimaan
             WHERE replid = '$idpayment'";
	//echo "$sql<br>";		 
	$row = FetchSingleRow($sql);
	//$rekkas = $row[0];
	$rekpiutang = $row[1];
	$rekpendapatan = $row[2];
    $rekdiskon = $row[3];
	$paymentname = $row[4];
	
	$tanggal = date("Y-m-d");
	$petugas = getUserName();
	$nokas = GetNoKas();
	
	//Simpan ke jurnal
	$ketjurnal = "Pembayaran $paymentname tanggal $tanggal siswa $studentname ($studentid)";
	$idjurnal = 0;
	//echo "SimpanJurnal($idtahunbuku, $tanggal, $ketjurnal, $nokas, '', $petugas, 'penerimaaniuran', $idjurnal);<br>";
	$success = SimpanJurnal($idtahunbuku, $tanggal, $ketjurnal, $nokas, "", $petugas, "penerimaaniuran", $idjurnal);
	
	//Simpan ke jurnaldetail
	if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekkas, $jumlah);<br>";
		$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jumlah);
	}
	if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpendapatan, $jumlah);<br>";
		$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $jumlah);
	}
	
	//increment cacah di tahunbuku
	if ($success)
	{
		$sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid=$idtahunbuku";
		//echo "$sql<br>";
		QueryDbTrans($sql, $success);
	}
	
	if ($success)
	{
		$sql = "INSERT INTO penerimaaniuran
				   SET idpenerimaan='$idpayment', nis='$studentid', idjurnal='$idjurnal',
					   jumlah='$jumlah', tanggal='$tanggal', keterangan='$keterangan', petugas='$petugas'";
		//echo "$sql<br>";			   
		QueryDbTrans($sql, $success);
	}
	
	$transactions[] = array($nokas, $infocicil, $jumlah, 0);
	
	return $success;
}

function SaveIuranSukarelaCalonSiswa($rowno)
{
	global $studentid, $studentname, $idtahunbuku;
	global $transactions;
	
	$sql = "SELECT replid
			  FROM jbsakad.calonsiswa
			 WHERE nopendaftaran = '$studentid' ";
	$idcalon = FetchSingle($sql);	
	
	$tmp = "i_idpayment_$rowno";
    $idpayment = $_REQUEST[$tmp];
    
    $tmp = "i_jumlah_$rowno";
    $jumlah = (int)$_REQUEST[$tmp];
    
    $tmp = "i_keterangan_$rowno";
    $keterangan = $_REQUEST[$tmp];
    
    $tmp = "i_infocicilan_$rowno";
    $infocicil = $_REQUEST[$tmp];
	
	//echo "Iuran Sukarela Calon Siswa = $idpayment ------<br>";
	$success = true;
	
	 // Ambil informasi kode rekening berdasarkan jenis penerimaan
	$sql = "SELECT rekkas, rekpiutang, rekpendapatan, info1, nama
              FROM jbsfina.datapenerimaan
             WHERE replid = '$idpayment'";
	//echo "$sql<br>";		 
	$row = FetchSingleRow($sql);
	$rekkas = $row[0];
	$rekpiutang = $row[1];
	$rekpendapatan = $row[2];
    $rekdiskon = $row[3];
	$paymentname = $row[4];
	
	$tanggal = date("Y-m-d");
	$petugas = getUserName();
	$nokas = GetNoKas();
	
	//Simpan ke jurnal
	$ketjurnal = "Pembayaran $paymentname tanggal $tanggal calon siswa $studentname ($studentid)";
	$idjurnal = 0;
	//echo "SimpanJurnal($idtahunbuku, $tanggal, $ketjurnal, $nokas, '', $petugas, 'penerimaaniurancalon', $idjurnal);<br>";
	$success = SimpanJurnal($idtahunbuku, $tanggal, $ketjurnal, $nokas, "", $petugas, "penerimaaniurancalon", $idjurnal);
	
	//Simpan ke jurnaldetail
	if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekkas, $jumlah);<br>";
		$success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jumlah);
	}
	if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpendapatan, $jumlah);<br>";
		$success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $jumlah);
	}
	
	//increment cacah di tahunbuku
	if ($success)
	{
		$sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid=$idtahunbuku";
		//echo "$sql<br>";
		QueryDbTrans($sql, $success);
	}
	
	if ($success)
	{
		$sql = "INSERT INTO penerimaaniurancalon
				   SET idpenerimaan='$idpayment', idcalon='$idcalon', idjurnal='$idjurnal',
					   jumlah='$jumlah', tanggal='$tanggal', keterangan='$keterangan', petugas='$petugas'";
		//echo "$sql<br>";			   
		QueryDbTrans($sql, $success);
	}
	
	$transactions[] = array($nokas, $infocicil, $jumlah, 0);
	
	return $success;
}

function SaveIuranWajibSiswa($rowno)
{
    global $studentid, $studentname, $idtahunbuku;
	global $transactions;
    
    $tmp = "i_idpayment_$rowno";
    $idpayment = $_REQUEST[$tmp];
    
    $tmp = "i_idbesarjtt_$rowno";
    $idbesarjtt = (int)$_REQUEST[$tmp];
    
    $tmp = "i_tagihan_$rowno";
    $tagihan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_bcicilan_$rowno";
    $bcicilan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_ktagihan_$rowno";
    $ktagihan = $_REQUEST[$tmp];
    
    $tmp = "i_jcicilan_$rowno";
    $jcicilan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_jdiskon_$rowno";
    $jdiskon = (int)$_REQUEST[$tmp];
    
    $tmp = "i_kcicilan_$rowno";
    $kcicilan = $_REQUEST[$tmp];
	
	$tmp = "i_lunas_$rowno";
    $lunas = $_REQUEST[$tmp];
    
    $tmp = "i_infocicilan_$rowno";
    $infocicil = $_REQUEST[$tmp];
    	
	$tmp = "i_rekkas_$rowno";
    $rekkas = $_REQUEST[$tmp];
	
	//echo "idbesarjtt = $idbesarjtt ------<br>";
	$success = true;
	
	 // Ambil informasi kode rekening berdasarkan jenis penerimaan
	$sql = "SELECT rekkas, rekpiutang, rekpendapatan, info1, nama
              FROM jbsfina.datapenerimaan
             WHERE replid = '$idpayment'";
	//echo "$sql<br>";		 
	$row = FetchSingleRow($sql);
	//$rekkas = $row[0];
	$rekpiutang = $row[1];
	$rekpendapatan = $row[2];
    $rekdiskon = $row[3];
	$paymentname = $row[4];
    
    // tanggal & petugas pendata & keterangan
    $tcicilan = date("Y-m-d");	
    $petugas = getUserName();
    $jbayar = $jcicilan - $jdiskon;
        
    if ($idbesarjtt == 0)
    {
		// Besar JTT belum dimasukkan sebelmunya
        $nokas = GetNoKas();
        
        // simpan ke table jurnal
        $idjurnal = 0;
        if ($success)
		{
			$keterangan = "Pendataan besar pembayaran $paymentname siswa $studentname ($studentid)";
			//echo "SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, '', $petugas, 'penerimaanjtt', $idjurnal)<br>";
            $success = SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, "", $petugas, "penerimaanjtt", $idjurnal);
		}
            
        // simpan ke tabel besarjtt
        if ($success) 
        {
            $sql = "INSERT INTO jbsfina.besarjtt SET nis='$studentid', idpenerimaan='$idpayment', 
                    besar='$tagihan', cicilan='$bcicilan', keterangan='$kcicilan', lunas=$lunas, 
                    pengguna='$pengguna', info1='$idjurnal', info2='$idtahunbuku'";
            //echo "$sql<br>";        
            QueryDbTrans($sql, $success);
            
            $sql = "SELECT LAST_INSERT_ID()";
			//echo "$sql<br>";
			$idbesarjtt = FetchSingle($sql);
        }
    
        // simpan ke table jurnaldetail
        if ($success)
		{
			//echo "SimpanDetailJurnal($idjurnal, 'D', $rekpiutang, $tagihan);<br>";
            $success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $tagihan);
		}
        if ($success)
		{
			//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpendapatan, $tagihan)<br>";
            $success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $tagihan);
		}
            
        //increment cacah di tahunbuku
        if ($success) 
        {
            $sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid='$idtahunbuku'";
            //echo "$sql<br>";
			QueryDbTrans($sql, $success);
            //QueryDbTrans($sql, $success);
        }
    }
    
    // -- Simpan ke jurnal -----------------------------------------------
    $idjurnal = 0;
    if ($success)
	{
		$nokas = GetNoKas();
		
		$transactions[] = array($nokas, $infocicil, $jcicilan, $jdiskon);
		
		//echo "SimpanJurnal($idtahunbuku, $tcicilan, $infocicil, $nokas, '', $petugas, 'penerimaanjtt', $idjurnal)<br>";
		$success = SimpanJurnal($idtahunbuku, $tcicilan, $infocicil, $nokas, "", $petugas, "penerimaanjtt", $idjurnal);
	}
    
    //-- Simpan ke jurnaldetail ------------------------------------------
    if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekkas, $jbayar)<br>";
        $success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jbayar);
	}
    if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpiutang, $jcicilan)<br>";
        $success = SimpanDetailJurnal($idjurnal, "K", $rekpiutang, $jcicilan);
	}
    if ($jdiskon > 0 && $success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekdiskon, $jdiskon)<br>";
        $success = SimpanDetailJurnal($idjurnal, "D", $rekdiskon, $jdiskon);
	}
        
    // -- increment cacah di tahunbuku -----------------------------------
    if ($success)
    {
        $sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid='$idtahunbuku'";
        //echo "$sql<br>";
        QueryDbTrans($sql, $success);
    }
    
    // -- simpan data cicilan di penerimaanjtt ---------------------------
    if ($success)
    {
        $sql = "INSERT INTO jbsfina.penerimaanjtt
                   SET idbesarjtt='$idbesarjtt', idjurnal='$idjurnal', tanggal='$tcicilan', 
                       jumlah='$jbayar', keterangan='$kcicilan', petugas='$petugas', info1='$jdiskon'";
        //echo "$sql<br>";                    
        QueryDbTrans($sql, $success);
    }
    
    if ($lunas == 1) 
    {
        if ($success) 
        {
            $sql = "SET @DISABLE_TRIGGERS = 1;";
			//echo "$sql<br>";                    
            QueryDb($sql);
			
            $sql = "UPDATE jbsfina.besarjtt SET lunas=1 WHERE replid='$idbesarjtt'";
			//echo "$sql<br>";                    
            QueryDbTrans($sql, $success);
			
            $sql = "SET @DISABLE_TRIGGERS = NULL;";
			//echo "$sql<br>";                    
            QueryDb($sql);
        }
    }
	
	return $success;
}

function SaveIuranWajibCalonSiswa($rowno)
{
    global $studentid, $studentname, $idtahunbuku;
	global $transactions;
	
	$sql = "SELECT replid
			  FROM jbsakad.calonsiswa
			 WHERE nopendaftaran = '$studentid' ";
	$idcalon = FetchSingle($sql);	
    
    $tmp = "i_idpayment_$rowno";
    $idpayment = $_REQUEST[$tmp];
    
    $tmp = "i_idbesarjtt_$rowno";
    $idbesarjtt = (int)$_REQUEST[$tmp];
    
    $tmp = "i_tagihan_$rowno";
    $tagihan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_bcicilan_$rowno";
    $bcicilan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_ktagihan_$rowno";
    $ktagihan = $_REQUEST[$tmp];
    
    $tmp = "i_jcicilan_$rowno";
    $jcicilan = (int)$_REQUEST[$tmp];
    
    $tmp = "i_jdiskon_$rowno";
    $jdiskon = (int)$_REQUEST[$tmp];
    
    $tmp = "i_kcicilan_$rowno";
    $kcicilan = $_REQUEST[$tmp];
	
	$tmp = "i_lunas_$rowno";
    $lunas = $_REQUEST[$tmp];
    
    $tmp = "i_infocicilan_$rowno";
    $infocicil = $_REQUEST[$tmp];
    //$infocicil = $infocicil . " siswa $studentname ($studentid)";
	
	//echo "idbesarjtt = $idbesarjtt ------<br>";
	$success = true;
	
	 // Ambil informasi kode rekening berdasarkan jenis penerimaan
	$sql = "SELECT rekkas, rekpiutang, rekpendapatan, info1, nama
              FROM jbsfina.datapenerimaan
             WHERE replid = '$idpayment'";
	//echo "$sql<br>";		 
	$row = FetchSingleRow($sql);
	$rekkas = $row[0];
	$rekpiutang = $row[1];
	$rekpendapatan = $row[2];
    $rekdiskon = $row[3];
	$paymentname = $row[4];
    
    // tanggal & petugas pendata & keterangan
    $tcicilan = date("Y-m-d");	
    $petugas = getUserName();
    $jbayar = $jcicilan - $jdiskon;
        
    if ($idbesarjtt == 0)
    {
		// Besar JTT belum dimasukkan sebelmunya
        $nokas = GetNoKas();
        
        // simpan ke table jurnal
        $idjurnal = 0;
        if ($success)
		{
			$keterangan = "Pendataan besar pembayaran $paymentname calon siswa $studentname ($studentid)";
			//echo "SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, '', $petugas, 'penerimaanjttcalon', $idjurnal)<br>";
            $success = SimpanJurnal($idtahunbuku, $tcicilan, $keterangan, $nokas, "", $petugas, "penerimaanjttcalon", $idjurnal);
		}
            
        // simpan ke tabel besarjtt
        if ($success) 
        {
            $sql = "INSERT INTO jbsfina.besarjttcalon SET idcalon='$idcalon', idpenerimaan='$idpayment', 
                    besar='$tagihan', cicilan='$bcicilan', keterangan='$kcicilan', lunas=$lunas, 
                    pengguna='$pengguna', info1='$idjurnal', info2='$idtahunbuku'";
            //echo "$sql<br>";        
            QueryDbTrans($sql, $success);
            
            $sql = "SELECT LAST_INSERT_ID()";
			//echo "$sql<br>";
			$idbesarjtt = FetchSingle($sql);
        }
    
        // simpan ke table jurnaldetail
        if ($success)
		{
			//echo "SimpanDetailJurnal($idjurnal, 'D', $rekpiutang, $tagihan);<br>";
            $success = SimpanDetailJurnal($idjurnal, "D", $rekpiutang, $tagihan);
		}
        if ($success)
		{
			//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpendapatan, $tagihan)<br>";
            $success = SimpanDetailJurnal($idjurnal, "K", $rekpendapatan, $tagihan);
		}
            
        //increment cacah di tahunbuku
        if ($success) 
        {
            $sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid='$idtahunbuku'";
            //echo "$sql<br>";
			QueryDbTrans($sql, $success);
            //QueryDbTrans($sql, $success);
        }
    }
    
    // -- Simpan ke jurnal -----------------------------------------------
    $idjurnal = 0;
    if ($success)
	{
		$nokas = GetNoKas();
		
		$transactions[] = array($nokas, $infocicil, $jcicilan, $jdiskon);
		
		//echo "SimpanJurnal($idtahunbuku, $tcicilan, $infocicil, $nokas, '', $petugas, 'penerimaanjttcalon', $idjurnal)<br>";
		$success = SimpanJurnal($idtahunbuku, $tcicilan, $infocicil, $nokas, "", $petugas, "penerimaanjttcalon", $idjurnal);
	}
    
    //-- Simpan ke jurnaldetail ------------------------------------------
    if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekkas, $jbayar)<br>";
        $success = SimpanDetailJurnal($idjurnal, "D", $rekkas, $jbayar);
	}
    if ($success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'K', $rekpiutang, $jcicilan)<br>";
        $success = SimpanDetailJurnal($idjurnal, "K", $rekpiutang, $jcicilan);
	}
    if ($jdiskon > 0 && $success)
	{
		//echo "SimpanDetailJurnal($idjurnal, 'D', $rekdiskon, $jdiskon)<br>";
        $success = SimpanDetailJurnal($idjurnal, "D", $rekdiskon, $jdiskon);
	}
        
    // -- increment cacah di tahunbuku -----------------------------------
    if ($success)
    {
        $sql = "UPDATE tahunbuku SET cacah=cacah+1 WHERE replid='$idtahunbuku'";
        //echo "$sql<br>";
        QueryDbTrans($sql, $success);
    }
    
    // -- simpan data cicilan di penerimaanjtt ---------------------------
    if ($success)
    {
        $sql = "INSERT INTO jbsfina.penerimaanjttcalon
                   SET idbesarjttcalon='$idbesarjtt', idjurnal='$idjurnal', tanggal='$tcicilan', 
                       jumlah='$jbayar', keterangan='$kcicilan', petugas='$petugas', info1='$jdiskon'";
        //echo "$sql<br>";                    
        QueryDbTrans($sql, $success);
    }
    
    if ($lunas == 1) 
    {
        if ($success) 
        {
            $sql = "SET @DISABLE_TRIGGERS = 1;";
			//echo "$sql<br>";                    
            QueryDb($sql);
			
            $sql = "UPDATE jbsfina.besarjttcalon SET lunas=1 WHERE replid='$idbesarjtt'";
			//echo "$sql<br>";                    
            QueryDbTrans($sql, $success);
			
            $sql = "SET @DISABLE_TRIGGERS = NULL;";
			//echo "$sql<br>";                    
            QueryDb($sql);
        }
    }
	
	return $success;
}
?>