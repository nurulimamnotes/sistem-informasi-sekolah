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
class CKatalogAdd{
	function OnStart(){
		if (isset($_REQUEST[simpan])){
			$sql = "SELECT kode FROM katalog WHERE kode='$_REQUEST[kode]' ";
			$result = QueryDb($sql);
			$num = @mysql_num_rows($result);
			if ($num>0){
				$this->exist();
			} else {
				$sql = "INSERT INTO katalog SET rak='$_REQUEST[rak]', kode='".CQ($_REQUEST['kode'])."', nama='".CQ($_REQUEST['nama'])."', keterangan='".CQ($_REQUEST['keterangan'])."'";
				$result = QueryDb($sql);
				if ($result)
					$this->success($_REQUEST[rak]);
			}
		}
	}
	function exist(){
		?>
        <script language="javascript">
			alert('Kode sudah digunakan!');
			document.location.href="katalog.add.php";
		</script>
        <?
	}
	function success($rak){
		?>
        <script language="javascript">
			parent.opener.getfresh('<?=$rak?>');
			window.close();
        </script>
        <?
	}
	function GetRak(){
		$this->rak = $_REQUEST[rak];
		$sql = "SELECT replid,rak FROM rak ORDER BY rak";
		$result = QueryDb($sql);
		?>
		<select name="rak" id="rak" class="cmbfrm">
		<?
		while ($row = @mysql_fetch_row($result)){
		if ($this->rak=="")
			$this->rak = $row[0];	
		?>
			<option value="<?=$row[0]?>" <?=IntIsSelected($row[0],$this->rak)?>><?=$row[1]?></option>
		<?
		}
		?>
		</select>
		<?
	}
	function add(){
		?>
        <form name="addkatalog" onSubmit="return validate()">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
          <tr>
            <td colspan="2" align="left">
            	<font style="color:#FF9900; font-size:30px;"><strong>.:</strong></font>
        		<font style="font-size:18px; color:#999999">Tambah Katalog Pustaka</font>            </td>
  		  </tr>
          <tr>
            <td width="6%">&nbsp;<strong>Rak</strong></td>
            <td width="94%"><?=$this->GetRak()?></td>
          </tr>
		  <tr>
            <td width="6%">&nbsp;<strong>Kode</strong></td>
            <td width="94%"><input name="kode" type="text" class="inputtxt" id="kode" maxlength="15"></td>
          </tr>
          <tr>
            <td>&nbsp;<strong>Nama</strong></td>
            <td><input name="nama" type="text" class="inputtxt" id="nama" size="48" maxlength="100"></td>
          </tr>
          <tr>
            <td>&nbsp;Keterangan</td>
            <td><textarea name="keterangan" cols="45" rows="5" class="areatxt" id="keterangan"></textarea></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><input type="submit" class="cmbfrm2" name="simpan" value="Simpan" >&nbsp;<input type="button" class="cmbfrm2" name="batal" value="Batal" onClick="window.close()" ></td>
          </tr>
        </table>
		</form>
		<?
	}
}
?>