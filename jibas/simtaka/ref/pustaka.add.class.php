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
class CPustakaAdd
{
	function OnStart()
	{
		if (isset($_REQUEST[simpan]))
		{
			$sql = "SELECT nama FROM perpustakaan WHERE nama='$_REQUEST[nama]' ";
			$result = QueryDb($sql);
			$num = @mysql_num_rows($result);
			if ($num>0)
			{
				$this->exist('1');
			}
			else
			{
				$sql = "SELECT perpustakaan FROM jbsumum.identitas WHERE perpustakaan='$_REQUEST[dep]' ";
				$result = QueryDb($sql);
				$num = @mysql_num_rows($result);
				if ($num>0)
				{
					$this->exist($_REQUEST[dep]);
				}
				else
				{
					$sql = "INSERT INTO perpustakaan SET nama='".CQ($_REQUEST['nama'])."',keterangan='".CQ($_REQUEST['keterangan'])."'";
					$result = QueryDb($sql);
					
					$sql = "SELECT LAST_INSERT_ID()";
					$result = QueryDb($sql);
					$row = mysql_fetch_row($result);
					$perpusid = $row[0];
					
					$sql = "UPDATE jbsumum.identitas SET perpustakaan='$perpusid' WHERE departemen='$_REQUEST[dep]'";
					$result = QueryDb($sql);
					
					$this->success();
				}
			}
		}
	}
	
	function exist($state)
	{
		if ($state=='1')
		{ ?>
			<script language="javascript">
			alert('Nama perpustakaan sudah digunakan!');
			document.location.href="pustaka.add.php";
			</script>
<?		}
		else
		{ ?>
			<script language="javascript">
			alert('Perpustakaan sudah digunakan pada departemen <?=$state?>!');
			document.location.href="pustaka.add.php";
			</script>
<?		}
	}
	
	function success()
	{	?>
		<script language="javascript">
		parent.opener.getfresh();
		window.close();
		</script>
<? }

	function add()
	{	?>
      <link href="../sty/style.css" rel="stylesheet" type="text/css" />
      <form name="addpustaka" onSubmit="return validate()">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
      <tr>
         <td colspan="2" align="left">
				<font style="color:#FF9900; font-size:30px;"><strong>.:</strong></font>
	        	<font style="font-size:18px; color:#999999">Tambah Perpustakaan</font>
			</td>
 		</tr>
      <tr>
         <td>&nbsp;<strong>Departemen</strong></td>
         <td>
         <select id="dep" name="dep" class="cmbfrm2">
<?			$sql = "SELECT departemen FROM jbsakad.departemen ORDER BY urutan ASC";
			$res = QueryDb($sql);
			while ($row = @mysql_fetch_row($res))
				echo "<option value='".$row[0]."'>".$row[0]."</option>";	?>
         </select>
         </td>
      </tr>
      <tr>
         <td width="6%">&nbsp;<strong>Nama</strong></td>
         <td width="94%"><input name="nama" type="text" class="inputtxt" id="nama"></td>
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
<?	}

}
?>