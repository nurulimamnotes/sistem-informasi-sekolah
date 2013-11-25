b_Edit = function() {
    $.ajax({
        url : 'beranda/beranda.login.php',
        type: 'get',
        success : function(html) {
            $('#b_main').html(html);
        }
    })
}

b_Login = function() {
    var password = trim($('#b_password').val());
    if (password.length == 0)
        return;
    
    $.ajax({
        url : 'beranda/beranda.dologin.php?password='+password,
        type: 'get',
        success : function(html) {
            $('#b_main').html(html);
        }
    })
}

b_Save = function() {
    if (!confirm('Apakah isi data sudah benar?'))
        return;
    
    var content = tinyMCE.get('b_content').getContent();
    content = escape(content);
    $.ajax({
        url : 'beranda/beranda.save.php',
        data : 'content='+content,
        type: 'post',
        success : function(html) {
            $('#b_main').html(html);
        }
    })
}

b_Close = function() {
    $.ajax({
        url : 'beranda/beranda.logout.php',
        type: 'get',
        success : function(html) {
            $('#b_main').html(html);
        }
    })
}

b_Cancel = function() {
    $.ajax({
        url : 'beranda/beranda.content.php',
        type: 'get',
        success : function(html) {
            $('#b_main').html(html);
        }
    })
}