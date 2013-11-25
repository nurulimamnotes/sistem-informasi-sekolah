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
class CPustaka{
	function OnStart(){
		$this->replid = $_REQUEST[replid];
		$this->asal = $_REQUEST[asal];
		$this->perpustakaan = $_REQUEST[perpustakaan];
		$this->kategori = $_REQUEST[kategori];
		$this->keyword = $_REQUEST[keyword];
		$sql = "SELECT * FROM pustaka WHERE replid=".$this->replid;
		$result = QueryDb($sql);
		$row = @mysql_fetch_array($result);
		$this->judul = stripslashes($row[judul]);
		$this->harga = $row[harga];
		$this->katalog = $row[katalog];
		$this->penerbit = $row[penerbit];
		$this->penulis = $row[penulis];
		$this->tahun = $row[tahun];
		$this->format = stripslashes($row[format]);
		$this->keyword = stripslashes($row[keyword]);
		$this->keteranganfisik = stripslashes($row[keteranganfisik]);
		$this->abstraksi = stripslashes($row[abstraksi]);
		$this->keterangan = stripslashes($row[keterangan]);
		//echo $this->katalog."<hr>";
		//echo $this->penulis."<hr>";
		if (isset($_REQUEST[simpan]))
			$this->save();
	}
	function reload_page(){
		$this->replid = $_REQUEST[replid];
		?>
		<script language='JavaScript'>
			document.location.href="pustaka.<?=$this->asal?>.php?replid=<?=$this->replid?>&perpustakaan=<?=$this->perpustakaan?>&kategori=<?=$this->kategori?>&keyword=<?=$this->keyword?>&cari";
        </script>
		<?
	}
	function OnFinish(){
		?>
		<script language='JavaScript'>
		//	Tables('table', 1, 0);
		</script>
		<?
    }
	function GetKatalog(){
		//$this->katalog = $_REQUEST[katalog];
		$sql = "SELECT replid,kode,nama FROM katalog ORDER BY nama";
		$result = QueryDb($sql);
		$max=0;
		while ($row = @mysql_fetch_row($result)){
			$newmax = strlen($row[2]);
			if ($newmax>$max)
				$max=$newmax;
		}
		?>
		<select name="katalog" id="katalog" class="cmbfrm" style="width:100%; font-family:'Courier New'">
		<?
        $sql = "SELECT replid,kode,nama FROM katalog ORDER BY nama";
		$result = QueryDb($sql);
		while ($row = @mysql_fetch_row($result)){
		$len = strlen($row[2]);
		$space = $this->GetSpace($max,$len);
		if ($this->katalog=="")
			$this->katalog = $row[0];	
		?>
			<option value="<?=$row[0]?>" <?=IntIsSelected($row[0],$this->katalog)?>>
				<?=$row[2]?><?=$space?> - <?=$row[1]?>
            </option>
		<?
		}
		?>
		</select>
		<?
	}
	function GetPenulis(){
		//$this->penulis = $_REQUEST[penulis];
		$sql = "SELECT replid,kode,nama FROM penulis ORDER BY nama";
		$result = QueryDb($sql);
		$max=0;
		while ($row = @mysql_fetch_row($result)){
			$newmax = strlen($row[2]);
			if ($newmax>$max)
				$max=$newmax;
		}
		?>
		<select name="penulis" id="penulis" class="cmbfrm" style="width:100%; font-family:'Courier New'">
		<?
		$sql = "SELECT replid,kode,nama FROM penulis ORDER BY nama";
		$result = QueryDb($sql);
		while ($row = @mysql_fetch_row($result)){
		$len = strlen($row[2]);
		$space = $this->GetSpace($max,$len);
		if ($this->penulis=="")
			$this->penulis = $row[0];	
		?>
			<option value="<?=$row[0]?>" <?=IntIsSelected($row[0],$this->penulis)?>>
			<?=$row[2]?><?=$space?> - <?=$row[1]?> 
            </option>
		<?
		}
		?>
		</select>
		<?
	}
	
	function GetPenerbit(){
		//$this->penerbit = $_REQUEST[penerbit];
		$sql = "SELECT replid,kode,nama FROM penerbit ORDER BY nama";
		$result = QueryDb($sql);
		$max=0;
		while ($row = @mysql_fetch_row($result)){
			$newmax = strlen($row[2]);
			if ($newmax>$max)
				$max=$newmax;
		}
		?>
		<select name="penerbit" id="penerbit" class="cmbfrm" style="width:100%; font-family:'Courier New'">
		<?
        $sql = "SELECT replid,kode,nama FROM penerbit ORDER BY nama";
		$result = QueryDb($sql);
		while ($row = @mysql_fetch_row($result)){
		$len = strlen($row[2]);
		$space = $this->GetSpace($max,$len);
		if ($this->penerbit=="")
			$this->penerbit = $row[0];	
		?>
			<option value="<?=$row[0]?>" <?=IntIsSelected($row[0],$this->penerbit)?>><?=$row[2]?><?=$space?> - <?=$row[1]?></option>
		<?
		}
		?>
		</select>
		<?
	}
	function GetFormat(){
		//$this->format = $_REQUEST[format];
		$sql = "SELECT replid,kode,nama FROM format ORDER BY nama";
		$result = QueryDb($sql);
		?>
		<select name="format" id="format" class="cmbfrm" style="width:100%">
		<?
		while ($row = @mysql_fetch_row($result)){
		if ($this->format=="")
			$this->format = $row[0];	
		?>
			<option value="<?=$row[0]?>" <?=IntIsSelected($row[0],$this->format)?>><?=$row[1]?> - <?=$row[2]?></option>
		<?
		}
		?>
		</select>
		<?
	}
    function Content(){
		?>
		<link href="../sty/style.css" rel="stylesheet" type="text/css">
        <form action="pustaka.ubah.php" method="post" onsubmit="return validate(<?=$this->CountPustaka()?>)" enctype="multipart/form-data">
		<input name="replid" type="hidden" class="inputtxt" id="replid" value="<?=$this->replid?>"/>
		<input name="asal" type="hidden" class="inputtxt" id="asal" value="<?=$this->asal?>"/>
		<input name="perpustakaan" type="hidden" class="inputtxt" id="perpustakaan" value="<?=$this->perpustakaan?>"/>
		<input name="kategori" type="hidden" class="inputtxt" id="kategori" value="<?=$this->kategori?>"/>
		<input name="keyword" type="hidden" class="inputtxt" id="keyword" value="<?=$this->keyword?>"/>
		<input name="katalogasli" type="hidden" class="inputtxt" id="katalogasli" value="<?=$this->katalog?>"/>
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
          <tr>
            <td width="47%" valign="top">
                <fieldset><legend><strong>Informasi Pustaka</strong></legend>
                    <table width="99%" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td width="24%" align="right" valign="top">&nbsp;<strong>Judul</strong></td>
                        <td colspan="2"><textarea name="judul" cols="45" rows="3" class="areatxt2" id="judul" style="width:100%"><?=$this->judul?></textarea></td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;<strong>Harga&nbsp;Satuan</strong></td>
                        <td colspan="2">
                            <input name="harga" type="text" class="inputtxt" id="harga" value="<?=FormatRupiah($this->harga)?>" onfocus="unformatRupiah('harga')" onblur="formatRupiah('harga')"/>                        </td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;<strong>Katalog</strong></td>
                        <td colspan="2">
                            <?=$this->GetKatalog()?>
						</td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;<strong>Penulis</strong></td>
                        <td colspan="2">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td><div id="PenulisInfo"><?=$this->GetPenulis()?></div></td>
                                <td width="18" align="right"><a href="javascript:ManagePenulis()"><img src="../img/ico/tambah.png" width="16" height="16" border="0" /></a></td>
                              </tr>
                            </table>
						</td>
                      </tr>
                      <tr>
                        <td align="right"><strong>&nbsp;Penerbit</strong></td>
                        <td colspan="2">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td><div id="PenerbitInfo"><?=$this->GetPenerbit()?></div></td>
                                <td width="18" align="right"><a href="javascript:ManagePenerbit()"><img src="../img/ico/tambah.png" width="16" height="16" border="0" /></a></td>
                              </tr>
                            </table>
                        </td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;<strong>Tahun&nbsp;Terbit</strong></td>
                        <td width="27%"><input name="tahun" type="text" class="inputtxt" id="tahun" maxlength="4" value="<?=$this->tahun?>" /></td>
                        <td width="49%">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td align="right"><strong>Format&nbsp;</strong></td>
                                <td><?=$this->GetFormat()?></td>
                              </tr>
                            </table>                    </td>
                      </tr>
                      <tr>
                        <td align="right">&nbsp;<strong>Keyword</strong></td>
                        <td colspan="2"><input name="keyword" type="text" class="inputtxt" id="keyword" size="48" value="<?=$this->keyword?>" /></td>
                      </tr>
                      <tr>
                        <td align="right" valign="top">&nbsp;<strong>Keterangan&nbsp;Fisik</strong></td>
                        <td colspan="2"><textarea name="keteranganfisik" cols="45" rows="5" class="areatxt2" id="keteranganfisik" style="width:100%"><?=$this->keteranganfisik?></textarea></td>
                      </tr>
                	</table>            
            	</fieldset>
            </td>
            <td width="53%" rowspan="2" valign="top">
                <table width="100%" border="0" cellspacing="2" cellpadding="0">
                  <tr>
                    <td>
                    	<fieldset><legend><strong>Gambar Cover</strong></legend>
                    		<table width="130" border="0" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC">
                              <tr height="130">
                                <td align="center" valign="middle"><img src="../inc/gambar.php?replid=<?=$this->replid?>&table=pustaka" /></td>
                              </tr>
                            </table><br />
                        <input name="cover" id="cover" type="file" />&nbsp;<span class="posted">* Isi untuk ganti cover
                        </span>
                                                </fieldset>                    </td>
                  </tr>
                  <tr>
                    <td>
                    <fieldset><legend><strong>Abstraksi</strong></legend>
                    <textarea name="abstraksi" id="abstraksi" cols="" rows="" style="width:100%"><?=$this->abstraksi?></textarea>
                    </fieldset>                    </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top">
                    <fieldset><legend><strong>Keterangan&nbsp;Tambahan</strong></legend>                    
                   	<textarea name="keterangan" id="keterangan" cols="45" rows="5"><?=$this->keterangan?>
                    	</textarea>
                    </fieldset>
                    </td>
                  </tr>
            </table>            </td>
          </tr>
          <tr>
            <td valign="top"><fieldset><legend><strong>Alokasi Jumlah</strong></legend>
            <?=$this->GetPustaka()?>
            </fieldset></td>
          </tr>
          <tr>
          	<td colspan="2" align="center">
            	<input name="simpan" type="submit" class="cmbfrm2" value="Simpan" />
            </td>
          </tr>  
        </table>
		</form>
        <?
	}
	function GetPustaka(){
		
		?>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" class="tab">
             <tr>
               <td width="63%" height="25" align="center" valign="middle" class="header">Perpustakaan</td>
               <td width="37%" height="25" align="center" valign="middle" class="header">Jumlah</td>
             </tr>
             <?
			 $cnt=0;
			 if (SI_USER_LEVEL()==2){
			 	$sql = "SELECT * FROM perpustakaan WHERE replid='".SI_USER_IDPERPUS()."' ORDER BY nama";
			 } else {
			 	$sql = "SELECT * FROM perpustakaan ORDER BY nama";
			 }
			 $result = QueryDb($sql);
			 while ($row = @mysql_fetch_array($result)){
			 	$num = @mysql_fetch_row(QueryDb("SELECT COUNT(replid) FROM daftarpustaka WHERE pustaka='".$this->replid."' AND perpustakaan='$row[replid]'"));
			 ?>
             <tr>
               <td height="25" valign="middle">&nbsp;<?=$row[nama]?></td>
               <td height="20" align="center" valign="middle">
               		<input type="text" name="jumlah<?=$cnt?>" id="jumlah<?=$cnt?>" class="inputtxt" value="<?=$num[0]?>"  />
 		            <input type="hidden" name="replid<?=$cnt?>" id="replid<?=$cnt?>" class="inputtxt" value="<?=$row[replid]?>" />     
               </td>
             </tr>
             <?
			 $cnt++;
			 }
			 ?>
        </table>
		<?
		if (SI_USER_LEVEL()==2){
			$sql = "SELECT * FROM perpustakaan WHERE replid<>'".SI_USER_IDPERPUS()."' ORDER BY nama";
			//echo $sql;
			$result = QueryDb($sql);
			$cnt=1;
			while ($row = @mysql_fetch_array($result)){ 
				$num = @mysql_fetch_row(QueryDb("SELECT COUNT(replid) FROM daftarpustaka WHERE pustaka='".$this->replid."' AND perpustakaan='$row[replid]'"));	
				?>
				<input type="hidden" name="jumlah<?=$cnt?>" id="jumlah<?=$cnt?>" class="inputtxt" value="<?=$num[0]?>" />
 		        <input type="hidden" name="replid<?=$cnt?>" id="replid<?=$cnt?>" class="inputtxt" value="<?=$row[replid]?>" />
				<?
            $cnt++;
			}
		}
    }
	function CountPustaka(){
		$sql = "SELECT * FROM perpustakaan ORDER BY nama";
		$result = QueryDb($sql);
		$num = @mysql_num_rows($result);
		return $num;
	}
	
	function save()
	{
		$replid = $_REQUEST[replid];
		$judul = trim(addslashes($_REQUEST[judul]));
		$abstraksi = trim(addslashes($_REQUEST[abstraksi]));
		$keyword = trim(addslashes($_REQUEST[keyword]));
		$tahun = trim(addslashes($_REQUEST[tahun]));
		$harga = UnformatRupiah(trim(addslashes($_REQUEST[harga])));
		$keteranganfisik = trim(addslashes($_REQUEST[keteranganfisik]));
		$penulis = trim(addslashes($_REQUEST[penulis]));
		$penerbit = trim(addslashes($_REQUEST[penerbit]));
		$format = trim(addslashes($_REQUEST[format]));
		$katalog = trim(addslashes($_REQUEST[katalog]));
		$katalogasli = trim(addslashes($_REQUEST[katalogasli]));
		$keterangan = trim(addslashes($_REQUEST[keterangan]));
		$cover = $_FILES['cover'];
		$uploadedfile = $cover['tmp_name'];
		$uploadedfile_name = $cover['name'];

		if (strlen($uploadedfile)!=0)
		{
			$tmp_path = realpath(".") . "/../../temp";
			$tmp_exists = file_exists($tmp_path) && is_dir($tmp_path);
			if (!$tmp_exists)
				mkdir($tmp_path, 0755);
			
			$filename = "$tmp_path/ed-pus-tmp.jpg";
			ResizeImage($cover, 160, 120, 70, $filename);
			
			$fh = fopen($filename, "r");
        	$cover_binary = addslashes(fread($fh, filesize($filename)));
			fclose($fh);
			
			$fill_cover = ", cover='$cover_binary'"; 
		}

		$sql = "UPDATE pustaka
				   SET harga='$harga', judul='$judul', abstraksi='$abstraksi',
					   keyword='$keyword', tahun='$tahun', keteranganfisik='$keteranganfisik',
					   penulis='$penulis', format='$format', katalog='$katalog', penerbit='$penerbit',
					   keterangan='$keterangan' $fill_cover
				 WHERE replid='$replid'";
		
		$result = QueryDb($sql);
		if ($result)
		{
			$sql = "SELECT count(replid) FROM daftarpustaka WHERE pustaka='$replid'";
			$result = QueryDb($sql);
			$row = @mysql_fetch_row($result);
			$jum = $row[0];

			$sql = "DELETE FROM daftarpustaka WHERE pustaka='$replid'";
			$result = QueryDb($sql);
			
			if ($katalog==$katalogasli)
			{	
				$sql = "SELECT counter FROM katalog WHERE replid='$katalog'";
				$result = QueryDb($sql);
				$r = @mysql_fetch_row($result);
				$counter = $r[0];
				
				$newcounter = (int)$counter-(int)$jum;

				$sql = "UPDATE katalog SET counter=".$newcounter." WHERE replid='$katalog'";
				QueryDb($sql);
			} 
			else 
			{
				$sql = "SELECT counter FROM katalog WHERE replid='$katalogasli'";
				$result = QueryDb($sql);
				$r = @mysql_fetch_row($result);
				$counter = $r[0];
				
				$newcounter = (int)$counter-(int)$jum;

				$sql = "UPDATE katalog SET counter=".$newcounter." WHERE replid='$katalogasli'";
				QueryDb($sql);

				$sql = "SELECT counter FROM katalog WHERE replid='$katalog'";
				$result = QueryDb($sql);
				$r = @mysql_fetch_row($result);
				$newcounter = $r[0];
			}
			
			for ($i = 0; $i < $this->CountPustaka(); $i++)
			{
				$rep_perpus = $_REQUEST['replid'.$i];
				if ($_REQUEST['jumlah'.$i] != "" && $_REQUEST['jumlah'.$i] > 0)
				{
					for ($j = 1;$j <= $_REQUEST['jumlah'.$i]; $j++)
					{
						$newcounter++;
						$sql = "UPDATE katalog SET counter=".$newcounter." WHERE replid='$katalog'";
						QueryDb($sql);
						$kodepustaka = $this->GenKodePustaka($katalog,$penulis,$judul,$format,$newcounter);
						$sql = "INSERT INTO daftarpustaka SET pustaka='$replid', perpustakaan='$rep_perpus', kodepustaka='$kodepustaka'";
						QueryDb($sql);
					}
				}
			}
		}
		$this->reload_page();	
	}
	
	function GenKodePustaka($katalog,$penulis,$judul,$format,$counter)
	{
		/*
		$sql = "SELECT kode FROM katalog WHERE replid='$katalog'";
		$result = QueryDb($sql);
		$ktlg = @mysql_fetch_row($result);

		$sql = "SELECT kode FROM penulis WHERE replid='$penulis'";
		$result = QueryDb($sql);
		$pnls = @mysql_fetch_row($result);
		
		$jdl = substr($judul,0,1);
	
		$sql = "SELECT kode FROM format WHERE replid='$format'";
		$result = QueryDb($sql);
		$frmt = @mysql_fetch_row($result);
		
		
		$counter = (int)$counter;
		
		if (strlen($counter)==1)
			$cnt = "0000".$counter;
		if (strlen($counter)==2)
			$cnt = "000".$counter;
		if (strlen($counter)==3)
			$cnt = "00".$counter;
		if (strlen($counter)==4)
			$cnt = "0".$counter;
		if (strlen($counter)==5)
			$cnt = $counter;

		$kode = $ktlg[0]."/".$pnls[0]."/".$jdl."/".$cnt."/".$frmt[0];
		
		
		return $kode;
		*/
		
		$sql = "SELECT kode FROM katalog WHERE replid='$katalog'";
		$result = QueryDb($sql);
		$ktlg = @mysql_fetch_row($result);

		$sql = "SELECT kode FROM penulis WHERE replid='$penulis'";
		$result = QueryDb($sql);
		$pnls = @mysql_fetch_row($result);
		
		$jdl = substr($judul, 0, 1);
	
		$sql = "SELECT kode FROM format WHERE replid='$format'";
		$result = QueryDb($sql);
		$frmt = @mysql_fetch_row($result);
		
		$cnt = str_pad($counter, 5, "0", STR_PAD_LEFT);

		$unique = true;
		$addcnt = 0;
		do
		{
			$kode = $ktlg[0] . "/" . $pnls[0] . "/" . $jdl . "/" . $cnt . "/" . $frmt[0];
			
			$sql = "SELECT COUNT(replid) FROM daftarpustaka WHERE kodepustaka = '$kode'";
			$result = QueryDb($sql);
			$row = mysql_fetch_row($result);
			
			if ($row[0] > 0)
			{
				$addcnt++;
				$cnt = "$cnt.$addcnt";
				$unique = false;
			}
			else
			{
				$unique = true;
			}
		}
		while(!$unique);
		
		return $kode;
	}
	
	function delete_file($file){ 
	  $delete = @unlink($file); 
	  clearstatcache();
	  if (@file_exists($file)) { 
		 $filesys = eregi_replace("/","\\",$file); 
		 $delete = @system("del $filesys");
		 clearstatcache();
		 if (@file_exists($file)) { 
			$delete = @chmod ($file, 0775); 
			$delete = @unlink($file); 
			$delete = @system("del $filesys");
		 }
	  }
	  clearstatcache();
	  if (@file_exists($file)){
		 return false;
		 }
		 else{
			   return true;
			   }
	}  // end function
	function GetSpace($maxlength,$length){
		$spacer="";
		for ($i=1;$i<=$maxlength-$length;$i++)
			$spacer .="&nbsp;";
		return $spacer;	
	}
}
?>