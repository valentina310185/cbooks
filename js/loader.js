(function() {
	var root = window.location.protocol + "//" + window.location.hostname + "/js/lazy/";
	var jsFilesUrl = [
		"jquery.min.js",
		"jquery.form.min.js",
		"jquery.inputmask.bundle.js",
		"base64.js",
		"bootstrap.min.js",
		"bootstrap-dialog.min.js",
		"bootstrap-maxlength.min.js",
		"datatables-bootstrap.min.js",
		"device.min.js",
		"dialog.js",
		"filesaver.min.js",
		"form.js",
		"handlers.js",
		"html2canvas.js",
		"html-docx.js",
		"input.js",
		"is.js",
		"jquery.autosize.min.js",
		"jquery.base64.js",
		"jspdf.js",
		"addhtml.js",
		"jspdf.plugin.autotable.js",
		"jspdf.plugin.textalign.js",
		"notify.min.js",
		"sprintf.js",
		"tableExport.js"
   ];
	for (var i = 0; i < jsFilesUrl.length; i++) 
	{
		LoadScript(jsFilesUrl[i]);
	}
	function LoadScript(file)
	{
		document.write("<script src='" + root + file + "'></script>")
	}

	if (navigator.userAgent.match(/IEMobile\/10\.0/)) 
	{
	  var msViewportStyle = document.createElement('style')
	  msViewportStyle.appendChild(
		document.createTextNode(
		  '@-ms-viewport{width:auto!important}'
		)
	  )
	  document.querySelector('head').appendChild(msViewportStyle)
	}
})();
