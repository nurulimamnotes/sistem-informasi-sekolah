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
<center><h2>LOGIN HALAMAN BERANDA</h2></center>
<table border='0' cellpadding='2' cellspacing='2' align='center'>
<tr>
    <td align='right'>
        <font style='font-size:16px'>LOGIN:</font>
    </td>
    <td align='left'>
        <input type='text' id='b_admin' style='font-size:16px; background-color: #bbb' maxlength='14' size='14' value='jibas' readonly="readonly">
    </td>
</tr>
<tr>
    <td align='right'>
        <font style='font-size:16px'>PASSWORD:</font>
    </td>
    <td align='left'>
        <input type='password' id='b_password' style='font-size:16px' maxlength='14' size='14' value=''>
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <input type="button" onclick="b_Login()" value="Login" style="font-size:16px; color: #fff;" class="but">
        <input type="button" onclick="b_Cancel()" value="Batal" style="font-size:16px; color: #fff;" class="but">
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <font style='color: red; font-size: 12px;'><?=$ERRMSG?></font>
    </td>
</tr>
</table>