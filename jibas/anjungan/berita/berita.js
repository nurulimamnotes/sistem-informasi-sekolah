bs_ChangePage = function()
{
    var page = $('#bs_page').val();
    $.ajax({
        url : 'berita/berita.php?page='+page,
        type: 'get',
        success : function(html) {
            $('#content-pane-b').html(html);
        }
    })
}

bs_Read = function(id, page)
{
    $.ajax({
        url : 'berita/berita.read.php?id='+id+'&page='+page,
        type: 'get',
        success : function(html) {
            $('#content-pane-b').html(html);
        }
    })
}

bs_BackToList = function(page) {
    $.ajax({
        url : 'berita/berita.php?page='+page,
        type: 'get',
        success : function(html) {
            $('#content-pane-b').html(html);
        }
    })
}