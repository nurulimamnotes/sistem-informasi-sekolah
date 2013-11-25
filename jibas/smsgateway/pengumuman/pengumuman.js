$(function(){
	$("#CheckAllPegawai").live('click',function(){
		if ($(this).attr('checked')){
			$(".checkboxpegawai").attr('checked','checked');
		} else {
			$(".checkboxpegawai").removeAttr('checked');
		}

		$(".checkboxpegawai").each(function(){
			var nip = $(this).attr('nip');
			var nama = $(this).attr('nama');
			var hp = $(this).attr('hp');
			var pin = $(this).attr('pin');
			if ($(this).attr('checked')){
				InsertNewReceipt(hp,nama,nip,'peg',pin,'');
			} else {
				RemoveReceive(nip,'peg');
			}
		});
	});
	$(".checkboxpegawai").live('click',function(){
		var nip = $(this).attr('nip');
		var nama = $(this).attr('nama');
		var hp = $(this).attr('hp');
		var pin = $(this).attr('pin');
		if ($(this).attr('checked')){
			InsertNewReceipt(hp,nama,nip,'peg',pin,'');
		} else {
			RemoveReceive(nip,'peg');
		}
	});

	$("#CheckAllOrtu").live('click',function(){
		if ($(this).attr('checked')){
			$(".checkboxortu").attr('checked','checked');
		} else {
			$(".checkboxortu").removeAttr('checked');
		}

		$(".checkboxortu").each(function(){
			var nip = $(this).attr('nip');
			var nama = $(this).attr('nama');
			var hp = $(this).attr('hp');
			var pina = $(this).attr('pinayah');
			var pini = $(this).attr('pinibu');
			if ($(this).attr('checked')){
				InsertNewReceipt(hp,nama,nip,'ortu',pina,pini);
			} else {
				RemoveReceive(nip,'ortu');
			}
		});
	});
	$(".checkboxortu").live('click',function(){
		var nip = $(this).attr('nip');
		var nama = $(this).attr('nama');
		var hp = $(this).attr('hp');
		var pina = $(this).attr('pinayah');
		var pini = $(this).attr('pinibu');
		if ($(this).attr('checked')){
			InsertNewReceipt(hp,nama,nip,'ortu',pina,pini);
		} else {
			RemoveReceive(nip,'ortu');
		}
	});

	$("#CheckAllSiswa").live('click',function(){
		if ($(this).attr('checked')){
			$(".checkboxsiswa").attr('checked','checked');
		} else {
			$(".checkboxsiswa").removeAttr('checked');
		}

		$(".checkboxsiswa").each(function(){
			var nip = $(this).attr('nip');
			var nama = $(this).attr('nama');
			var hp = $(this).attr('hp');
			var pin = $(this).attr('pin');
			if ($(this).attr('checked')){
				InsertNewReceipt(hp,nama,nip,'siswa',pin,'');
			} else {
				RemoveReceive(nip,'siswa');
			}
		});
	});
	$(".checkboxsiswa").live('click',function(){
		var nip = $(this).attr('nip');
		var nama = $(this).attr('nama');
		var hp = $(this).attr('hp');
		var pin = $(this).attr('pin');
		if ($(this).attr('checked')){
			InsertNewReceipt(hp,nama,nip,'siswa',pin,'');
		} else {
			RemoveReceive(nip,'siswa');
		}
	});
})
function MaxChar(value,maxlen,clid){
	var currentlen = maxlen-value.length;
	
	document.getElementById(clid).value=currentlen;
	if (currentlen < 0){
		document.getElementById('Message').value = value.substring(0, maxlen);
		document.getElementById(clid).value=0;
		document.getElementById('Message').scrollTop;
	}
}
function RemoveReceive(nip,type){
	$("#ReceiptTable #"+type+nip).remove();
}
function InsertNewReceipt2(x,y,z){

	InsertNewReceipt(x,y,z,a,b);
}
function InsertNewReceipt(x,y,z,w,a,b){
	if (x.length==0 && y.length==0 && z.length==0){
		HideError('ErrNewReceiptNo');
		HideError('ErrNewReceiptName');
		var PhNumber 	= document.getElementById('NewReceiptNo').value;
		var Name 		= document.getElementById('NewReceiptName').value;
		var NIP			= 'NULL';
		var PIN			= a;
		var PIN2		= b;
	} else {
		var PhNumber	= x;
		var Name		= y;
		var NIP			= z;
		var PIN			= a;
		var PIN2		= b;
	}
	//alert(PIN+"\n"+PIN2);
	if (PhNumber.length==0 || Name.length==0){
		if (Name.length==0){
			ShowError('ErrNewReceiptName','Masukkan Nama!','NewReceiptName');
			return false;
		}	
		if (PhNumber.length==0){
			ShowError('ErrNewReceiptNo','Masukkan No Ponsel!','NewReceiptNo');
			return false;
		} else {
			if (isNaN(PhNumber)){
				ShowError('ErrNewReceiptNo','No Ponsel harus berupa bilangan!','NewReceiptNo');
				return false;
			}
		}
	} else {
		if (isNaN(PhNumber)){
			ShowError('ErrNewReceiptNo','No Ponsel harus berupa bilangan!','NewReceiptNo');
			return false;
		}
		var tbl = document.getElementById('ReceiptTable');
		var numrow = parseInt(document.getElementById('ReceiptTable').rows.length)-1;
		var found  = false;
		for (i=1;i<=numrow;i++){
			var s = document.getElementById('ChkReceipt'+i).value;
			if (s==PhNumber+'>'+Name+'>'+NIP+'>'+PIN+'>'+PIN2){
				found = true;
				break;
			}
		}
		if (!found){
			var lastRow = tbl.rows.length;
			var iteration = lastRow;
			var row = tbl.insertRow(lastRow);
			row.setAttribute('id',w+NIP);
			
			// cell number
			var cellLeft = row.insertCell(0);
			var textNode = document.createTextNode(iteration);
			cellLeft.align='center';
			cellLeft.valign='top';
			cellLeft.appendChild(textNode);
			cellLeft.className='tdTop';
			
			// checkbox
			var cellDate = row.insertCell(1);
			cellDate.align='center';
			cellDate.valign='top';
			
			var cD1 = document.createElement('input');
			cD1.type = 'checkbox';
			cD1.name = 'ChkReceipt' + iteration;
			cD1.id = 'ChkReceipt' + iteration;
			cD1.checked = 'checked';
			cD1.value = PhNumber+">"+Name+">"+NIP+'>'+PIN+'>'+PIN2;
			cellDate.appendChild(cD1);
			
			//No HP
			var cellDate = row.insertCell(2);
			cellDate.align='center';
			cellDate.valign='top';
			cellDate.innerHTML = PhNumber;
			
			//Nama
			var cellDate = row.insertCell(3);
			cellDate.align='left';
			cellDate.valign='top';
			cellDate.className='td';
			cellDate.innerHTML = Name;
			
			document.getElementById('NewReceiptNo').value="";
			document.getElementById('NewReceiptName').value="";
			
			HideError('ErrNewReceiptList');
		} /*else {
			if (PhNumber.length>0 && Name.length>0)
				ShowError('ErrNewReceiptList','Penerima sudah dimasukkan ke daftar!','');
		}*/
	}
}
function CheckAllReceipt(state){
	var tbl = parseInt(document.getElementById('ReceiptTable').rows.length)-1;
	if (state){
		for (i=1;i<=tbl;i++)
			document.getElementById('ChkReceipt'+i).checked=true;
	} else {
		for (i=1;i<=tbl;i++)
			document.getElementById('ChkReceipt'+i).checked=false;		
	}
}
function Send(){
	HideError('ErrSender');
	HideError('ErrMessage');
	HideError('ErrNewReceiptList');
	var a = document.getElementById('SendDate').value;
	var b = document.getElementById('SendMonth').value;
	var c = document.getElementById('SendYear').value;
	var d = document.getElementById('SendHour').value;
	var e = document.getElementById('SendMinute').value;
	
	var SendTime = c+'-'+b+'-'+a+' '+d+':'+e+':00';
	
	var Sender = document.getElementById('Sender').value;
	var Message = document.getElementById('Message').value;
	Message = Message.replace(/\&/g,'^');
	Message = addslashes(Message);
	//alert(Message);
	//return false;
	var tbl = parseInt(document.getElementById('ReceiptTable').rows.length)-1;
	if (Sender.length==0){
		ShowError('ErrSender','Pengirim harus diisi!','Sender');
		return false;
	}
	if (Message.length==0){
		ShowError('ErrMessage','Pesan harus diisi!','Message');
		return false;
	}
	if (tbl==0){
		ShowError('ErrNewReceiptList','Minimal ada 1 penerima!','NewReceiptName');
		return false;
	}
	var nope = "";
	var nama = "";
	var noin = "";
	var pin1 = "";
	var pin2 = "";
	for (i=1;i<=tbl;i++){
		var x = document.getElementById('ChkReceipt'+i).checked;
		if (x){
			var y 	= document.getElementById('ChkReceipt'+i).value;
			//alert(y);
			NewY 	= y.split('>');
			if (nope==''){
				nope = NewY[0];
			}else{
				nope = nope+'>'+NewY[0];
			}
			
			if (nama==''){
				nama = NewY[1];
			}else{
				nama = nama+'>'+NewY[1];
			}
			
			if (noin==''){
				noin = NewY[2];
			}else{
				noin = noin+'>'+NewY[2];	
			}

			if (pin1==''){
				pin1 = NewY[3];
			}else{
				pin1 = pin1+'>'+NewY[3];	
			}
			
			if (pin2==''){
				pin2 = NewY[4];
				if (pin2==''){
					pin2 = 'X';
				}
			}else{
				pin2 = pin2+'>'+NewY[4];	
			}
		}
	}
	//alert(pin1+"\n"+pin2);
	//alert ("SendMessage.php?Sender="+Sender+"&Message="+Message+"&NoPe="+nope+"&Nama="+nama+"&NoIn="+noin+"&Pin1="+pin1+"&Pin2="+pin2+"&SendTime="+SendTime);

	parent.HiddenFrame.location.href = "SendMessage.php?Sender="+Sender+"&Message="+Message+"&NoPe="+nope+"&Nama="+nama+"&NoIn="+noin+"&Pin1="+pin1+"&Pin2="+pin2+"&SendTime="+SendTime;
}
function ChgCmbBagPeg(v){
	ShowWait('TablePegawai');
	//sendRequestText('GetTablePegawai.php',ShowTablePegawai,'Bagian='+v+'&Source=Pilih');
	sendRequestText('pengumuman.ajax.php',ShowTablePegawai,'Bagian='+v+'&Source=Pilih&op=GetTablePegawai');
}
function SearchPeg(){
	//alert ('Masuk');
	HideError('ErrInpNIPPeg');
	HideError('ErrInpNamaPeg');
	var NIP 	= document.getElementById('InpNIPPeg').value;
	var Nama 	= document.getElementById('InpNamaPeg').value;
	if (NIP=='NIP Pegawai' && Nama=='Nama Pegawai'){
		ShowError('ErrInpNamaPeg','Masukan kata kunci','InpNIPPeg');
		return false;
	} else {
		ShowWait('TablePegawai');
		sendRequestText('pengumuman.ajax.php',ShowTablePegawai,'NIP='+NIP+'&Nama='+Nama+'&Source=Cari&op=GetTablePegawai');
	}
}
function ShowTablePegawai(x){
	document.getElementById('TablePegawai').innerHTML = x;
	if ($("#TablePeg").length>0)
	Tables('TablePeg', 1, 0);
}

function ChgCmbDepSis(){
	var Dep 	= document.getElementById('CmbDepSis').value;
	ShowWait('DivCmbKelas');
	sendRequestText('pengumuman.ajax.php',ShowFilterSiswa,'dep='+Dep+'&op=GetFilterSiswa');
}
function ChgCmbKlsSis(){
	var Kls 	= document.getElementById('CmbKlsSis').value;
	ShowWait('TableSiswa');
	sendRequestText('pengumuman.ajax.php',ShowTableSiswa,'kls='+Kls+'&Source=Pilih&op=GetTableSiswa');
}
function ShowFilterSiswa(x){
	document.getElementById('DivCmbKelas').innerHTML = x;
	var Kls 	= document.getElementById('CmbKlsSis').value;
	ShowWait('TableSiswa');
	sendRequestText('pengumuman.ajax.php',ShowTableSiswa,'kls='+Kls+'&Source=Pilih&op=GetTableSiswa');
}
function ShowTableSiswa(x){
	document.getElementById('TableSiswa').innerHTML = x;
	if ($("#TableSis").length>0)
	Tables('TableSis', 1, 0);
}
function SearchSis(){
	HideError('ErrInpNISSis');
	HideError('ErrInpNamaSis');
	var NIS 	= document.getElementById('InpNISSis').value;
	var Nama 	= document.getElementById('InpNamaSis').value;
	if (NIS=='NIS Siswa' && Nama=='Nama Siswa'){
		ShowError('ErrInpNamaSis','Masukan kata kunci','InpNISSis');
		return false;
	} else {
		ShowWait('TableSiswa');
		sendRequestText('pengumuman.ajax.php',ShowTableSiswa,'NIS='+NIS+'&Nama='+Nama+'&Source=Cari&op=GetTableSiswa');
	}
}

function ChgCmbDepOrtu(){
	var Dep 	= $('#CmbDepOrtu').val();
	ShowWait('DivCmbKelasOrtu');
	$.ajax({
		url : 'pengumuman.ajax.php',
		data : 'dep='+Dep+'&op=GetFilterOrtu',
		success : function(x){
			$('#DivCmbKelasOrtu').html(x);
			ChgCmbKlsOrtu();
		}
	})
}
function ChgCmbKlsOrtu(){
	var Kls 	= $('#CmbKlsOrtu').val();
	ShowWait('TableOrtu');
	$.ajax({
		url : 'pengumuman.ajax.php',
		data : 'kls='+Kls+'&Source=Pilih&op=GetTableOrtu',
		success : function(x){
			$('#TableOrtu').html(x);
			if ($("#TableOr").length>0)
				Tables('TableOr', 1, 0);
		}
	})
}
function ShowTableOrtu(x){
	document.getElementById('TableOrtu').innerHTML = x;
	if ($("#TableOr").length>0)
		Tables('TableOr', 1, 0);
}
function SearchOrtu(){
	HideError('ErrInpNISOrtu');
	HideError('ErrInpNamaOrtu');
	var NIS 	= document.getElementById('InpNISOrtu').value;
	var Nama 	= document.getElementById('InpNamaOrtu').value;
	if (NIS=='NIS Siswa' && Nama=='Nama Siswa'){
		ShowError('ErrInpNamaOrtu','Masukan kata kunci','InpNISOrtu');
		return false;
	} else {
		ShowWait('TableOrtu');
		//sendRequestText('pengumuman.ajax.php',ShowTableOrtu,'NIS='+NIS+'&Nama='+Nama+'&Source=Cari&op=GetTableOrtu');
		$.ajax({
			url : 'pengumuman.ajax.php',
			data : 'NIS='+NIS+'&Nama='+Nama+'&Source=Cari&op=GetTableOrtu',
			success : function(x){
				$('#TableOrtu').html(x);
				if ($("#TableOr").length>0)
					Tables('TableOr', 1, 0);
			}
		})
	}
}

function PengumumanAfterSend(nope){
	if (nope>0){
		var msg = "<div style='border:1px solid #FF6600; background-color:#FFCC66; padding:2px;'>Berhasil mengirim pengumuman ke <span style='font-weight:bold;font-size:16px;'>"+nope+"</span> penerima.</div>";
		document.getElementById('DivLogs').innerHTML = msg;
		document.getElementById('Sender').value = "";
		document.getElementById('Message').value = "";
		document.getElementById('CharLeft').value = "160";
		
		setTimeout(function(){
			document.getElementById('DivLogs').innerHTML = "";
		},2000)
	} else {
		var msg = "<div style='border:1px solid #FF6600; background-color:#FFCC66; padding:2px;'>Tidak ada penerima pesan pengumuman, pastikan penerima memiliki Nomor Ponsel.</div>";
		document.getElementById('DivLogs').innerHTML = msg;
		
		setTimeout(function(){
			document.getElementById('DivLogs').innerHTML = "";
		},5000)
	}
}
function ResizeTabHeight() {
  var WinHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    WinHeight = window.innerHeight;
  } else if( document.documentElement &&
      ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    WinHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    WinHeight = document.body.clientHeight;
  }
  //alert(WinHeight+'px');DIVReceiptTable
  document.getElementById('MainTable').style.height = (parseInt(WinHeight)-90)+"px";
  document.getElementById('DIVReceiptTable').style.height = (parseInt(WinHeight)-385)+"px";
}

function addslashes(str) {
str=str.replace(/\\/g,'\\\\');
str=str.replace(/\'/g,'\\\'');
str=str.replace(/\"/g,'\\"');
str=str.replace(/\0/g,'\\0');
str=str.replace(/\&/g,'\\&');
return str;
}
function stripslashes(str) {
str=str.replace(/\\'/g,'\'');
str=str.replace(/\\"/g,'"');
str=str.replace(/\\&/g,'&');
str=str.replace(/\\0/g,'\0');
str=str.replace(/\\\\/g,'\\');
return str;
}