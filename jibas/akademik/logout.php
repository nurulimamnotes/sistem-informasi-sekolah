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
session_name("jbsakad");
session_start();

unset($_SESSION['login']);
unset($_SESSION['namasimaka']);
unset($_SESSION['tingkatsimaka']);
unset($_SESSION['departemensimaka']);
unset($_SESSION['errtype']);
unset($_SESSION['errfile']);
unset($_SESSION['errno']);
unset($_SESSION['errmsg']);
unset($_SESSION['issend']);
$_SESSION['maintenance'] = false;
?>
<script language="javascript">
	top.window.location='../akademik/';
</script>
