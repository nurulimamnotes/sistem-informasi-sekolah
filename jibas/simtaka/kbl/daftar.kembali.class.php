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
class CDaftarKembali{
	function OnStart(){
		$op=$_REQUEST[op];
		if ($op=="del"){
			$sql = "DELETE FROM format WHERE replid='$_REQUEST[id]'";
			QueryDb($sql);
		}
		$this->kriteria='all';
		if (isset($_REQUEST[kriteria]))
			$this->kriteria=$_REQUEST[kriteria];
		if ($this->kriteria=='nip')
			$this->statuspeminjam=0;
		elseif ($this->kriteria=='nis')
			$this->statuspeminjam=1;
		$this->noanggota = $_REQUEST[noanggota];
		$this->nama = $_REQUEST[nama];
		$sqlDate="SELECT DAY(now()),MONTH(now()),YEAR(now())";
		$resultDate = QueryDb($sqlDate);
		$rDate = @mysql_fetch_row($resultDate);
		$this->tglAwal = $rDate[0]."-".$rDate[1]."-".$rDate[2];
		$this->tglAkhir = $rDate[0]."-".$rDate[1]."-".$rDate[2];
		if (isset($_REQUEST[tglAwal]))
			$this->tglAwal = $_REQUEST[tglAwal];
		if (isset($_REQUEST[tglAkhir]))
			$this->tglAkhir = $_REQUEST[tglAkhir];	
		$this->denda=0;
		if (isset($_REQUEST[denda]))
			$this->denda=$_REQUEST[denda];
	}
	function OnFinish(){
		?>
		<script language='JavaScript'>
			Tables('table', 1, 0);
		</script>
		<?
    }
    function Content(){
		$sql = "SELECT DATE_FORMAT(now(),'%Y-%m-%d')";
		$result = QueryDb($sql);
		$row = @mysql_fetch_row($result);
		$now = $row[0];
		if ($this->kriteria=='all')
			$sql = "SELECT * FROM pinjam WHERE status=2 ORDER BY tglditerima DESC";
		elseif ($this->kriteria=='tglpinjam')
			$sql = "SELECT *,replid FROM pinjam WHERE status=2 AND tglpinjam BETWEEN '".MySqlDateFormat($this->tglAwal)."' AND '".MySqlDateFormat($this->tglAkhir)."' ORDER BY tglditerima DESC";
		elseif ($this->kriteria=='tglkembali')
			$sql = "SELECT *,replid FROM pinjam WHERE status=2 AND tglkembali BETWEEN '".MySqlDateFormat($this->tglAwal)."' AND '".MySqlDateFormat($this->tglAkhir)."' ORDER BY tglditerima DESC";
		elseif ($this->kriteria=='nip' || ($this->kriteria=='nis'))
			$sql = "SELECT *,replid FROM pinjam WHERE status=2 AND idanggota='$this->noanggota' AND tglkembali<='".$now."' ORDER BY tglditerima DESC";
		elseif ($this->kriteria=='denda'){
			if ($this->denda==0)
				$sql = "SELECT *,p.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda='0' ORDER BY p.tglditerima DESC";
			elseif ($this->denda==1)
				$sql = "SELECT *,p.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<5000 ORDER BY p.tglditerima DESC";
			elseif ($this->denda==2)
				$sql = "SELECT *,p.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>0 AND d.denda<10000 ORDER BY p.tglditerima DESC";
			elseif ($this->denda==3)
				$sql = "SELECT *,p.replid AS replid FROM pinjam p,denda d WHERE p.status=2 AND p.replid=d.idpinjam AND d.denda>10000 ORDER BY p.tglditerima DESC";			
		}
		$result = QueryDb($sql);
		$num = @mysql_num_rows($result);
		?>
		<link href="../sty/style.css" rel="stylesheet" type="text/css">
        <div class="filter">
        <table width="100%" border="0" cellpadding="2" cellspacing="2">
          <tr>
            <td width="9%">Tampilkan&nbsp;berdasarkan</td>
            <td width="91%">
            <select name="kriteria" id="kriteria" onchange="chgKrit()">
           	  <option value="all" <?=StringIsSelected('all',$this->kriteria)?> >Semua Pengembalian</option>
              <option value="tglpinjam" <?=StringIsSelected('tglpinjam',$this->kriteria)?>>Tanggal Peminjaman</option>
              <option value="tglkembali" <?=StringIsSelected('tglkembali',$this->kriteria)?>>Jadwal Pengembalian</option>
           	  <option value="nis" <?=StringIsSelected('nis',$this->kriteria)?>>NIS Siswa</option>
              <option value="nip" <?=StringIsSelected('nip',$this->kriteria)?>>NIP Pegawai</option>
              <option value="denda" <?=StringIsSelected('denda',$this->kriteria)?>>Denda</option>
            </select>
            </td>
          </tr>
          <? if ($this->kriteria!='all'){ ?>
		  <? if ($this->kriteria=='tglpinjam' ||$this->kriteria=='tglkembali' ) { ?>
          <tr id="tgl">
            <td align="right">Periode</td>
          <td>
                <table width="100%" border="0" cellpadding="0">
                  <tr>
                    <td valign="bottom"><input class="inptxt" name="tglAwal" id="tglAwal" type="text" value="<?=$this->tglAwal?>" style="width:100px" readonly="readonly" />&nbsp;<a href="javascript:TakeDate('tglAwal')" >&nbsp;<img src="../img/ico/calendar.png" width="16" height="16" border="0" /></a>&nbsp;&nbsp;s.d.&nbsp;&nbsp;<input class="inptxt" name="tglAkhir" id="tglAkhir" type="text" value="<?=$this->tglAkhir?>"  style="width:100px" readonly="readonly"/><a href="javascript:TakeDate('tglAkhir')" >&nbsp;<img src="../img/ico/calendar.png" width="16" height="16" border="0" /></a>&nbsp;&nbsp;<em>*dd-mm-yyyy</em></td>
                  </tr>
                </table>
            </td>
          </tr>
          <? } ?>
          <? if ($this->kriteria=='nis' || $this->kriteria=='nip' ) { ?>
          <tr id="nis">
            <td align="right"><?=strtoupper($this->kriteria)?></td>
          <td>
                <input type="hidden" id="statuspeminjam" value="<?=$this->statuspeminjam?>" />
                <input type="text" class="inptxt-small-text" name="noanggota" id="noanggota" readonly="readonly"  onclick="cari()" value="<?=$this->noanggota?>" style="width:150px" />
                &nbsp;
<input id="nama" class="inptxt-small-text" name="nama" type="text" readonly="readonly"  onclick="cari()" value="<?=$this->nama?>" size="50" style="width:200px"/>
                &nbsp;
                <a href="javascript:cari()"><img src="../img/ico/cari.png" width="16" height="16" border="0" /> </a>
            </td>
          </tr>
          <? } ?>
          <? if ($this->kriteria=='denda') { ?>
          <tr id="nis">
            <td align="right">Besar Denda</td>
          	<td>
           	  <select name="denda" id="denda" onchange="chgDenda()" >
               	<option value="0" <?=StringIsSelected('0',$this->denda)?>>Tanpa Denda</option>
                <option value="1" <?=StringIsSelected('1',$this->denda)?>>< Rp 5.000</option>
                <option value="2" <?=StringIsSelected('2',$this->denda)?>>< Rp 10.000</option>
               	<option value="3" <?=StringIsSelected('3',$this->denda)?>>> Rp 10.000</option>
              </select>	    
          	</td>
          </tr>
          <? } ?>
          <? } ?>
        </table>
        </div>
      <div class="funct">
        	<a href="javascript:getFresh()"><img src="../img/ico/refresh.png" border="0">&nbsp;Refresh</a>&nbsp;&nbsp;
			<a href="javascript:cetak()"><img src="../img/ico/print1.png" border="0">&nbsp;Cetak</a>&nbsp;&nbsp;        
        </div>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="tab" id="table">
          <tr>
            <td height="30" align="center" class="header"> Anggota</td>
            <td height="30" align="center" class="header">Kode Pustaka</td>
            <td height="30" align="center" class="header">Tgl Pinjam</td>
            <td height="30" align="center" class="header">Tgl Kembali</td>
            <td align="center" class="header"> Tanggal Pengembalian</td>
            <? if($this->kriteria=='denda') { ?>
            <td align="center" class="header">Denda</td>
            <? } ?>
            <td height="30" align="center" class="header">Keterangan</td>
          </tr>
          <?
		  if ($num>0){
			  while ($row=@mysql_fetch_array($result)){
			  $sqlDenda = "SELECT * FROM denda WHERE idpinjam='$row[replid]'";
			  $resultDenda = QueryDb($sqlDenda);
			  $rowDenda = @mysql_fetch_array($resultDenda);
			  $this->idanggota = $row[idanggota];
			  $NamaAnggota = $this->GetMemberName();
			  ?>
			  <tr style="color:<?=$color?>; <?=$weight?>">
				<td height="25" align="left"><?=$row[idanggota]?> - <?=$this->GetMemberName();?></td>
				<td height="25" align="center"><?=$row[kodepustaka]?></td>
				<td height="25" align="center"><?=LongDateFormat($row[tglpinjam])?></td>
				<td height="25" align="center"><?=LongDateFormat($row[tglkembali])?></td>
				<td align="center"><?=LongDateFormat($row[tglditerima])?></td>
				<? if ($this->kriteria=='denda') { ?>
                <td align="center"><div style="padding-right:5px"><?=FormatRupiah($rowDenda[denda])?></div></td>
				<? } ?>
                <td height="25" align="center"><?=$row[keterangan]?></td>
		  </tr>
			  <?
			  }
		  } else {
		  ?>
          <tr>
            <td height="25" colspan="7" align="center" class="nodata">Tidak ada data</td>
          </tr>
		  <?
		  }
		  ?>	
        </table>

        <?
	}
	function GetMemberName(){
		$idanggota = $this->idanggota;
		//return ($idanggota);
		$sql1 = "SELECT nama FROM ".get_db_name('akad').".siswa WHERE nis='$idanggota'";
		$result1 = QueryDb($sql1);
		if (@mysql_num_rows($result1)>0){
			$row1 = @mysql_fetch_array($result1);
			return $row1[nama];
			//return $sql1;
		} else {
			$sql2 = "SELECT nama FROM ".get_db_name('sdm').".pegawai WHERE nip='$idanggota'";
			$result2 = QueryDb($sql2);
			if (@mysql_num_rows($result2)>0){
				$row2 = @mysql_fetch_array($result2);
				return $row2[nama];
				//return $sql2;
			} else {
				$sql3 = "SELECT nama FROM anggota WHERE noregistrasi='$idanggota'";
				$result3 = QueryDb($sql3);
				if (@mysql_num_rows($result3)>0){
					$row3 = @mysql_fetch_array($result3);
					//return $sql3;
					return $row3[nama];
				} else {
					return "Tanpa Nama";
				}
			}
		}
	}
}
?>