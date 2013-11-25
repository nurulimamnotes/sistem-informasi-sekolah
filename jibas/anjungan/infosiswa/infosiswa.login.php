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
<br><br><br><br><br><br>
<h2>LOGIN SISWA</h2>
<table border='0' cellpadding='2' cellspacing='2' align='center'>
<tr>
    <td align='right'>
        <font style='font-size:16px'>NIS:</font>
    </td>
    <td align='left'>
        <input type='text' id='is_nis' style='font-size:16px' maxlength='14' size='14' value=''>
    </td>
</tr>
<tr>
    <td align='right'>
        <font style='font-size:16px'>PIN:</font>
    </td>
    <td align='left'>
        <input type='password' id='is_pin' style='font-size:16px' maxlength='14' size='14' value=''>
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <input type="button" onclick="is_Login()" value="Masuk" style="font-size:16px; color: #fff;" class="but">
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <font style='color: red; font-size: 12px;'><?=$ERRMSG?></font>
    </td>
</tr>
</table>
<br><br><br><br><br><br>