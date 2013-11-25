$(document).ready(function () {
    $(document).bgStretcher({
        images: ['../images/background07.jpg'], imageWidth: 1680, imageHeight: 1050
    });
    
    setTimeout(resizeVTab, 10);
    setTimeout(pageLoader, 10);
});

// ON STARTED UP
$(function() {
    setUpTabs();
})

// ON WINDOW RESIZED
$(window).resize(function() {
    resizeVTab();
});

setUpTabs = function() {
	$("#vtabs1").jVertTabs();
}

resizeVTab = function() {
	var docHeight = $(document).height();
    //$('#debug1').val(docHeight);
	
	var vTabHeight = docHeight - 160;
	$("#vtabs1").height(vTabHeight);
	
	var vTabDivHeight = docHeight - 170;
	$("#vtabs1>div").height(vTabDivHeight);
	$("#vtabs1>div>div").height(vTabDivHeight);
	
	var vTabPaneHeight = docHeight - 220;
	$("#vtabs1>div>div>div").height(vTabPaneHeight);
	
	//$('#debug2').val($("#vtabs1>div").height());
	//$('#debug3').val($("#vtabs1>div>div").height());
}

pageLoader = function() {
    loadBeranda();
    loadBeritaSekolah();
    loadInfoSiswa();
    loadKalender();
    loadJadwalGuru();
    loadJadwalKelas();
    loadPegawai();
}

loadBeranda = function() {
    $.ajax({
        url : 'beranda/beranda.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-a').html(html);
        }
    })
}

loadBeritaSekolah = function() {
    $.ajax({
        url : 'berita/berita.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-b').html(html);
        }
    })
}

loadInfoSiswa = function() {
    $.ajax({
        url : 'infosiswa/infosiswa.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-c').html(html);
        }
    })
}

loadKalender = function() {
    $.ajax({
        url : 'kalender/kalender.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-d').html(html);
        }
    })
}

loadJadwalGuru = function() {
    $.ajax({
        url : 'jadwalguru/jadwalguru.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-e').html(html);
        }
    })
}

loadJadwalKelas = function() {
    $.ajax({
        url : 'jadwalkelas/jadwalkelas.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-f').html(html);
        }
    })
}

loadPegawai = function() {
    $.ajax({
        url : 'pegawai/struktur.php',
        type: 'get',
        success : function(html) {
            $('#content-pane-g').html(html);
            if (!$.browser.mozilla)
                convertTrees();
            setTimeout(function() {
                expandTree('tree1'); 
            }, 200);
        }
    })
}