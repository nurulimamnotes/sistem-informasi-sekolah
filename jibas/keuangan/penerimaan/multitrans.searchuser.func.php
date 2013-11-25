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
function SearchUser()
{
    global $departemen, $filter, $data, $keyword;
    
    if ($data == "siswa")
    {
        if ($filter == "nama")
        {
            $sql = "SELECT s.nis, s.nama, k.kelas
                      FROM jbsakad.siswa s, jbsakad.kelas k, jbsakad.tingkat t
                     WHERE s.idkelas = k.replid
                       AND k.idtingkat = t.replid
                       AND s.nama LIKE '%$keyword%'
                       AND s.aktif = 1
                       AND s.alumni = 0
                       AND t.departemen = '$departemen'
                     ORDER BY s.nama";
        }
        else
        {
            $sql = "SELECT s.nis, s.nama, k.kelas
                      FROM jbsakad.siswa s, jbsakad.kelas k, jbsakad.tingkat t
                     WHERE s.idkelas = k.replid
                       AND k.idtingkat = t.replid
                       AND s.nis LIKE '%$keyword%'
                       AND s.aktif = 1
                       AND s.alumni = 0
                       AND t.departemen = '$departemen'
                     ORDER BY s.nama";
        }
        $titleId = "NIS";
        $titleInfo = "Kelas";
    }
    else
    {
        if ($filter == "nama")
        {
            $sql = "SELECT c.nopendaftaran, c.nama, k.kelompok
                      FROM jbsakad.calonsiswa c, jbsakad.kelompokcalonsiswa k, jbsakad.prosespenerimaansiswa p
                     WHERE c.idkelompok = k.replid
                       AND k.idproses = p.replid
                       AND c.nama LIKE '%$keyword%'
                       AND c.aktif = 1
                       AND p.departemen = '$departemen'
                     ORDER BY c.nama";
        }
        else
        {
            $sql = "SELECT c.nopendaftaran, c.nama, k.kelompok
                      FROM jbsakad.calonsiswa c, jbsakad.kelompokcalonsiswa k, jbsakad.prosespenerimaansiswa p
                     WHERE c.idkelompok = k.replid
                       AND k.idproses = p.replid
                       AND c.nopendaftaran LIKE '%$keyword%'
                       AND c.aktif = 1
                       AND p.departemen = '$departemen'
                     ORDER BY c.nama";
        }
        $titleId = "No.Pendaftaran";
        $titleInfo = "Kelompok";
    }
    
    $res = QUeryDb($sql);
    if (mysql_num_rows($res) == 0)
    {
        echo "<center>Tidak ditemukan data</center>";
        return;
    }
    
    ?>
    <table border="1" cellpadding="2" cellspacing="0" style="border-width: 1px; border-color: #333; border-collapse: collapse;" width="100%">
    <tr>
        <td width="7%" class="header">No</td>
        <td width="20%" class="header"><?=$titleId?></td>
        <td width="*" class="header">Nama</td>
        <td width="20%" class="header"><?=$titleInfo?></td>
        <td width="10%" class="header">&nbsp;</td>
    </tr>
<?
    $cnt = 0;
    
    while($row = mysql_fetch_row($res))
    {
        $cnt += 1;
?>
        <tr>
            <td><?=$cnt?></td>
            <td align="left"><?=$row[0]?></td>
            <td align="left"><?=$row[1]?></td>
            <td align="left"><?=$row[2]?></td>
            <td align="left">
                <input type="button" class="but" value="pilih" onclick="pilih('<?=$data?>', '<?=$row[0]?>', '<?=$row[1]?>');">
            </td>
        </tr>
<?
    }
?>
    </table>
    <?
}
?>