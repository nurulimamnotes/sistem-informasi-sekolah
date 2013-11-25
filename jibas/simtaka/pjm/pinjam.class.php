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
<link href="../sty/style.css" rel="stylesheet" type="text/css" />
<?
class CPinjam
{
	function OnStart()
	{
		$this->state = $_REQUEST[state];
		
		$this->jenisanggota = $_REQUEST['jenisanggota'];
		$jenis = 'pegawai';

		switch($this->jenisanggota){
			case '0' : $jenis = 'pegawai'; break;
			case '1' : $jenis = 'siswa'; break;
			case '2' : $jenis = 'lain'; break;
		}
		$this->noanggota = $_REQUEST[noanggota];
		$this->nama = $_REQUEST[nama];
		$this->numcode = 0;
		$this->kodepustaka = $_REQUEST[kodepustaka];
		
		$op = "";
		if (isset($_REQUEST[op]))
			$op = $_REQUEST[op];
			
		if ($op=="addnew")
		{
			$sql = "SELECT d.replid, d.kodepustaka, p.judul FROM pustaka p, daftarpustaka d WHERE p.replid=d.pustaka AND d.kodepustaka='$this->kodepustaka'";
			$result=QueryDb($sql);
			$this->numcode=@mysql_num_rows($result);
			$row=@mysql_fetch_row($result);
			$this->replid = $row[0];
			$this->judul = $row[2];
		}
		
		if ($op=="addtochart")
		{
			$sql = "SELECT * FROM pinjam WHERE kodepustaka='$_REQUEST[kodepustaka]' AND idanggota='$_REQUEST[noanggota]'";
			$result = QueryDb($sql);
			$num = @mysql_num_rows($result);
			if ($num==0){
				$sql = "INSERT INTO pinjam SET kodepustaka='$_REQUEST[kodepustaka]',tglpinjam='".MySqlDateFormat($_REQUEST[tglpinjam])."',tglkembali='".MySqlDateFormat($_REQUEST[tglkembali])."',idanggota='$_REQUEST[noanggota]',keterangan='".CQ($_REQUEST['keterangan'])."',info1='$jenis'";
				QueryDb($sql);
			}
			$this->replid = '';
			$this->kodepustaka = '';
			$this->judul = '';
		}
		
		if ($op=='delqueue')
		{
			$sql = "DELETE FROM pinjam WHERE replid=$_REQUEST[replid]";
			QueryDb($sql);
		}
		
		if ($op=='DontSave')
		{
			$sql = "DELETE FROM pinjam WHERE replid IN ($_REQUEST[idstr])";
			QueryDb($sql);
		}
		
		if ($op=='Save')
		{
			$sql = "UPDATE pinjam SET status=1 WHERE replid IN ($_REQUEST[idstr])";
			QueryDb($sql);
			$sql = "SELECT kodepustaka FROM pinjam WHERE replid IN ($_REQUEST[idstr])";
			$result = QueryDb($sql);
			while ($row = @mysql_fetch_array($result))
			{
				$sql = "UPDATE daftarpustaka SET status=0 WHERE kodepustaka='$row[kodepustaka]'";
				QueryDb($sql);
			}
		}
		
		if (isset($_REQUEST[openuser]))
			$this->OpenUser();
	}
	
	function OpenUser()
	{	?>
		<script language='JavaScript'>
			cari();
		</script>
<?  }

	function OnFinish()
	{	?>
		<script language='JavaScript'>
		//	Tables('table', 1, 0);
		</script>
<?  }
	
	function GetMaxQueue($anggota)
	{
		$sql = "SELECT * FROM konfigurasi";
		$result = QueryDb($sql);
		$row = @mysql_fetch_array($result);
		$max_siswa_pjm = $row['siswa'];
		$max_pegawai_pjm = $row['pegawai'];
		$max_anggota_pjm = $row['other'];
		$denda = $row['denda'];
	
		if ($anggota == 1) 
			return $max_siswa_pjm;
		if ($anggota == 0) 
			return $max_pegawai_pjm;
		if ($anggota == 2) 
			return $max_anggota_pjm;
	}

	
    function Content()
	{
		if ($this->state=='') 
		{
			$this->state='1';
		}
		
		$this->datenow = "";
		$this->oc1 = "";
		$this->oc2 = "";
		$this->dsp1 = "style=\"display:none\"";
		$this->dsp2 = "style=\"display:none\"";
		
		if ($this->kodepustaka!='') 
		{
			$sql = "SELECT DATE_FORMAT(now(), '%d-%m-%Y')";
			$result = QueryDb($sql);
			$row = @mysql_fetch_row($result);
			$this->datenow = $row[0];
			$this->oc1 = "onclick=\"TakeDate('tglpjm')\"";
			$this->oc2 = "onclick=\"TakeDate('tglkem')\"";
			$this->dsp1 = "";
			$this->dsp2 = "";
		}
		
		$sql = "SELECT DATE_FORMAT(now(),'%Y-%m-%d')";
		$result = QueryDb($sql);
		$row = @mysql_fetch_row($result);
		$now = $row[0];

		$sql = "SELECT * FROM pinjam WHERE idanggota='$this->noanggota' AND status=1 AND tglkembali<'".$now."' ORDER BY tglpinjam";
		$result = QueryDb($sql);
		$JumTelat = @mysql_num_rows($result);

		$sql = "SELECT * FROM pinjam WHERE idanggota='$this->noanggota' AND status=1";
		$result = QueryDb($sql);
		$JumPinjam = @mysql_num_rows($result);
		$max_queue = $this->GetMaxQueue($this->state); ?>
        <input type="hidden" name="max_queue" id="max_queue" value="<?=$max_queue?>" />
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
                <fieldset><legend class="welc">Pilih Anggota</legend>
					<table width="100%" border="0" cellspacing="3" cellpadding="0">
                      <tr>
                        <td width="9%" align="right"><span class="news_content1">Status&nbsp;Peminjam</span></td>
                  		<td width="91%">
                        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr></tr>
                              
                              <tr>
                                <td width="5" align="right">
                                	<input name="state" type="radio" value="0" onclick="fillstate('0')" <?=StringIsChecked($this->state,'0')?> />
                                </td>
                                <td ><span class="news_content1">Pegawai</span></td>
                                <td width="5" align="right">
                                	<input name="state" type="radio" value="1" onclick="fillstate('1')" <?=StringIsChecked($this->state,'1')?>/>
                                </td>
                                <td><span class="news_content1">Siswa</span></td>
                                <td width="5" align="right">
                                	<input name="state" type="radio" value="2" onclick="fillstate('2')" <?=StringIsChecked($this->state,'2')?>/>
                                </td>
                                <td><span class="news_content1">Anggota Luar Sekolah</span></td>
                              </tr>
                            </table>                        
                         </td>
                      </tr>
                      <tr>
                        <td align="right"><span class="news_content1">Peminjam</span></td>
                  		<td>
                        	<input type="hidden" id="statuspeminjam" value="<?=$this->state?>" />
                            <input type="text" name="noanggota" id="noanggota" readonly="readonly" class="btnfrm" onclick="cari()" value="<?=$this->noanggota?>" size="30" />
    &nbsp;
                            <input id="nama" name="nama" type="text" readonly="readonly" class="btnfrm" onclick="cari()" value="<?=$this->nama?>" size="50"/>
        &nbsp;
                          <a href="javascript:cari()"><img src="../img/ico/cari.png" width="16" height="16" border="0" /></a>                        </td>
                      </tr>
                    </table>
                </fieldset>
            </td>
            <td valign="top">
            	<div id="title" align="right">
                    <font style="color:#FF9900; font-size:30px;"><strong>.:</strong></font>
                    <font style="font-size:18px; color:#999999">Peminjaman Pustaka Baru</font><br />
                    <a href="peminjaman.php" class="welc">Peminjaman</a><span class="welc"> > Peminjaman Pustaka Baru</span><br /><br /><br />
                </div>
            </td>
          </tr>
		  	<?
			if (isset($_REQUEST[noanggota]) && $_REQUEST[noanggota]!=""){
			?>
          <tr>
            <td colspan="2">
              <fieldset>
              <legend class="welc">Daftar Peminjaman</legend>
              <div style="height:97px; overflow-x:hidden; width:100%; overflow-y:scroll">  
              <?
              $sql = "SELECT * FROM pinjam WHERE idanggota='$this->noanggota' AND status=0 ORDER BY tglkembali";
			  $result = QueryDb($sql);
			  $num = @mysql_num_rows($result);
              if ($num>0){
			  ?>
              <table width="98%" border="1"  cellspacing="0" cellpadding="0" class="tab">
                  <tr height="25" class="header">
                    <td width="19" height="25" align="center">No</td>
                    <td width="253" height="25" align="center">No Pustaka</td>
                    <td width="495" height="25" align="center">Judul</td>
                    <td width="99" align="center">Tgl Kembali</td>
                    <td width="99" align="center">&nbsp;</td>
                  </tr>
                  <tbody style="overflow:hidden;" >
                  <?
				  $cnt=1;
				  while ($row=@mysql_fetch_array($result)){
				  $judul = @mysql_fetch_row(QueryDb("SELECT p.judul FROM pustaka p, daftarpustaka d WHERE d.pustaka=p.replid AND d.kodepustaka='$row[kodepustaka]'"));
				  ?>
                  <tr height="25">
                    <td width="20" height="20" align="center">
						<input type="hidden" name="idpinjam<?=$cnt?>" id="idpinjam<?=$cnt?>" value="<?=$row[replid]?>" />
						<?=$cnt?>                    </td>
                    <td width="254" align="center"><?=$row[kodepustaka]?></td>
                    <td width="496" ><?=$judul[0]?></td>
                    <td width="100" align="center"><?=LongDateFormat($row[tglkembali])?></td>
                    <td width="100" align="center"><a href="javascript:HapusPeminjaman('<?=$row[replid]?>')"><img src="../img/ico/hapus.png" width="16" height="16" border="0" /></a></td>
                  </tr>
                  <? $cnt++; ?>
                  <? } ?>
                  </tbody>
              </table>
              <? } ?>
              </div>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr height="30">
                        <td class="news_content1">Jumlah yang akan dipinjam <?=$num?></td>
                        <td align="right">
                        	<? if($num!=0){ ?>
                            <input name="simpan" type="button" class="cmbfrm3" value="Simpan" onclick="ValidatePeminjaman()" />
          					&nbsp;<input name="batal" type="button" class="cmbfrm2" value="Batal" onclick="CancelPeminjaman()" />
                        	<? } ?>
                        </td>
                      </tr>
              </table>
              <input type="hidden" name="num" id="num" value="<?=$num?>" /> 
                </fieldset>            </td>
          </tr>
          <tr>
          	<td colspan="2">
                <fieldset>
            <legend class="welc">Cari Pustaka Yang Akan Dipinjam</legend>
            <table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
                        <td width="9%" align="right" class="news_content1">Nomor Pustaka</td>
                        <td colspan="2"><input name="kodepustaka" id="kodepustaka" type="text" size="40" maxlength="45" value="<?=$this->kodepustaka?>" onkeypress="return KeyPress('kodepustaka',event)" />&nbsp;<a href="javascript:CariPustaka()"><img src="../img/ico/cari.png" border="0" /></a></td>
                      </tr>
                      <tr height="30">
                        <td align="right" class="news_content1">Judul</td>
                        <td colspan="2"><div id="title" class="btnfrm" style="height:30px">&nbsp;<?=$this->judul?></div>                        </td>
                      </tr>
                      <tr>
                        <td align="right" class="news_content1">Tanggal&nbsp;Pinjam</td>
                        <td colspan="4">                       
                        <table   border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="tglpjm" type="text" class="btnfrm" id="tglpjm" value="<?=$this->datenow?>" size="20" maxlength="10" readonly="true" <?=$this->oc1?> /></td>
                            <td width="18" align="right"><a href="javascript:TakeDate('tglpjm')" <?=$this->dsp1?>><img src="../img/ico/calendar.png" width="16" height="16" border="0" /></a></td>
                            <td>&nbsp;&nbsp;&nbsp;<span class="news_content1">Tanggal&nbsp;Kembali</span>&nbsp;</td>
                            <td><input name="tglkem" type="text" class="btnfrm" id="tglkem" value="<?=$this->datenow?>" size="20" maxlength="10" readonly="true" <?=$this->oc2?> /></td>
                            <td width="18" align="right"><a href="javascript:TakeDate('tglkem')" <?=$this->dsp2?> ><img src="../img/ico/calendar.png" border="0" /></a></td>
                          </tr>
                        </table>
</td>
                        <td width="36%" rowspan="3" align='left'>
                        <input type="hidden" name="borrowed" id="borrowed" value="<?=$JumPinjam?>" />
                        <fieldset style="height:100%; width:75%"><legend class="welc">Data Peminjaman Aktif</legend>
                   	        <span class="news_content1">Jumlah Peminjaman <?=$JumPinjam?><br />
								Jumlah Peminjaman Yang Terlambat <?=$JumTelat?>                           </span>
                        </fieldset>                        </td>
                      </tr>
                      <tr>
                        <td align="right" class="news_content1">Keterangan</td>
                        <td><textarea name="keterangan" id="keterangan" cols="40" rows="1"></textarea></td>
                      </tr>
                      
                      <tr>
                        <td colspan="2" align="center">
						<? if ($this->numcode>0){ ?>
						<input name="button" type="button" class="cmbfrm2" id="button" value="Tambahkan ke daftar pustaka yang akan dipinjam" onclick="AddToChart()" />
						<? } ?>
						</td>
                      </tr>
                    </table>
              </fieldset>            </td>
          </tr>
          <tr>
          	<td colspan="2" align="center"></td>
          </tr>
		  <?
           } else {	
          ?>
          <input type="hidden" name="num" id="num" value="0" />
          <? } ?>
        </table>

        <?
	}
}
?>