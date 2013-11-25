clearResult = function() {
	$("#keyword").val("");
	$("#searchBox").html("");
}

validateSearch = function() {
	var keyword = $.trim($("#keyword").val());
	if (keyword.length < 3)
	{
		$("#info").text("Panjang kata kunci minimal 3 karakter");
		return false;
	}
	
	return true;
}

pilih = function(data, noid, nama) {
	opener.AcceptSearch(data, noid, nama);
	window.close();
}

$(function() {
	$("#keyword").focus();	
});