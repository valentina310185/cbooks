
//Navigation Global Handler
jQuery(document).ready(function()
{
	BASE_URL = window.location.protocol + "//" + window.location.hostname + "/";
	jQuery.notify.defaults({globalPosition: 'top center',autoHideDelay: 2000});
});

jQuery(document).on("click","a", function(event) {
	if(jQuery(this).hasClass("ajax"))
	{
		jQuery.notify("Loading please wait...", "info");
		jQuery.get(BASE_URL + jQuery(this).attr("href"), function(data, textStatus, jqXHR) {
			if(jQuery.trim(data) != "" && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				jQuery("#main-content").html(ResponseFilter(data));
				setTimeout(function(){
					jQuery('input,textarea').not("[type=file],[type=submit]").maxlength({
						alwaysShow: true
					});
					jQuery(":input").inputmask();
				},1000);
			}
		}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("add"))
	{
		jQuery.get(BASE_URL + jQuery(this).attr("href"), function(data, textStatus, jqXHR) {
			if(jQuery.trim(data) != "" && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				Dialog.Default("<h3>New Record</h3>", ResponseFilter(data), " Ok");
				setTimeout(function(){
					jQuery('input,textarea').not("[type=file],[type=submit]").maxlength({
						alwaysShow: true
					});
					jQuery(":input").inputmask();
				},1000);
			}
		}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("edit"))
	{
		jQuery.post(BASE_URL + jQuery(this).attr("href"), jQuery.parseJSON(jQuery(this).attr("data-id")), function(data, textStatus, jqXHR) {
			if(jQuery.trim(data) != "" && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				Dialog.Default("<h3>Update Record</h3>", ResponseFilter(data), "Ok");
				setTimeout(function(){
					jQuery('input,textarea').not("[type=file],[type=submit]").maxlength({
						alwaysShow: true
					});
					jQuery(":input").inputmask();
				},1000);
			}
		}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("delete"))
	{
		var btn = this;
		Dialog.Confirm("Confirm", "Are you sure you want to delete the record?", "Yes", "No", function(confirm) {
			if(confirm)
			{
				jQuery.post(jQuery(btn).attr("href"), jQuery.parseJSON(jQuery(btn).attr("data-id")), function(data, textStatus, jqXHR) {
					jQuery.notify("Refreshing table...", "info");
					jQuery("button[type='submit']").click();
				}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
			}
		});
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("print-table"))
	{
		var btn = this;
		var copy_content = jQuery("table").clone();
		jQuery(copy_content).find("th").each(function() {
			if(jQuery(this).hasClass("edit") || jQuery(this).hasClass("delete"))
			{
				jQuery(this).remove();
			}				
		});
		jQuery(copy_content).find("td").each(function() {
			if(jQuery(this).hasClass("edit") || jQuery(this).hasClass("delete"))
			{
				jQuery(this).remove();
			}			
		});
		jQuery.notify("Loading print preview please wait...", "info");
		var print_window = window.open('', '', 'height=600,width=800');
		print_window.document.write('<!DOCTYPE html><html><head><title></title>');
		print_window.document.write('<link href="css/bootstrap.min.css" rel="stylesheet">');
		print_window.document.write('</head><body>');
		print_window.document.write(jQuery(copy_content).prop('outerHTML'));
		print_window.document.write('</body></html>');
		print_window.document.close();
		setTimeout(function(){print_window.print();},1000);
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("export-table"))
	{
		var btn = this;
		var copy_content = jQuery("table").clone();
		jQuery(copy_content).find("th").each(function() {
			if(jQuery(this).hasClass("edit") || jQuery(this).hasClass("delete"))
			{
				jQuery(this).remove();
			}				
		});
		jQuery(copy_content).find("td").each(function() {
			if(jQuery(this).hasClass("edit") || jQuery(this).hasClass("delete"))
			{
				jQuery(this).remove();
			}			
		});
		jQuery(copy_content).attr("id", "export");
		Dialog.Default("Exporting please wait...", ResponseFilter("<div class='print-template'>" + jQuery(copy_content).prop('outerHTML') + "</div>"), "Ok");
		setTimeout(function() {
			jQuery('.modal-dialog').css('width', '95%');
		}, 200);		
		setTimeout(function(){
			if(jQuery(btn).hasClass("pdf"))
			{
				jQuery("#export").tableExport({type:'pdf',pdfFontSize:'7',escape:'false'});
			}
			else if(jQuery(btn).hasClass("doc"))
			{
				var content = '<!DOCTYPE html><html><head><title></title></head><body>' + ResponseFilter(jQuery("#export").prop('outerHTML')) + '</body></html>';
				var converted = htmlDocx.asBlob(content, {orientation: 'landscape'});
				saveAs(converted, 'export.docx');
				//This export fails on file type recognition and association by the OS
				//jQuery("#export").tableExport({type:'doc',escape:'false'});
			}
			else if(jQuery(btn).hasClass("excel"))
			{
				jQuery("#export").tableExport({type:'excel',escape:'false'});
			}
			else if(jQuery(btn).hasClass("csv"))
			{
				jQuery("#export").tableExport({type:'csv',escape:'false'});
			}
			else if(jQuery(btn).hasClass("png"))
			{
				jQuery("#export").tableExport({type:'png',escape:'false'});
			}
			jQuery('.modal').last().modal('hide');
		},2000);
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("print-form"))
	{
		var btn = this;
		var copy_content = jQuery("form:not(.search)").clone();
		jQuery(copy_content).find("button[type=submit]").remove();
		var print_window = window.open('', '', 'height=600,width=800');
		print_window.document.write('<!DOCTYPE html><html><head><title></title>');
		print_window.document.write('<link href="css/bootstrap.min.css" rel="stylesheet">');
		print_window.document.write('</head><body>');
		print_window.document.write(jQuery(copy_content).prop('outerHTML'));
		print_window.document.write('</body></html>');
		print_window.document.close();
		setTimeout(function(){print_window.print();},1000);
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("export-form"))
	{
		var btn = this;
		var copy_content = jQuery("form:not(.search)").clone();
		jQuery(copy_content).find("button[type=submit]").remove();
		jQuery(copy_content).attr("id", "export");
		Dialog.Default("Exporting please wait...", ResponseFilter("<div class='print-template'>" + jQuery(copy_content).prop('outerHTML') + "</div>"), "Ok");
		setTimeout(function() {
			jQuery('.modal-dialog').css('width', '95%');
		}, 200);
		setTimeout(function(){
			if(jQuery(btn).hasClass("doc"))
			{
				jQuery(copy_content).find(":input").each(function ()
				{
					jQuery("<hr>").insertAfter(this);
					jQuery(this).remove();
				});
				var content = '<!DOCTYPE html><html><head><title></title></head><body>' + ResponseFilter(jQuery(copy_content).prop('outerHTML')) + '</body></html>';
				var converted = htmlDocx.asBlob(content);
				saveAs(converted, 'form.docx');
			}
			else if(jQuery(btn).hasClass("png"))
			{
				jQuery('.modal-dialog').css('width', '95%');
				jQuery(copy_content).find(":input").each(function ()
				{
					
					jQuery("<small>_________________________________________</small>").insertAfter(this);
					jQuery("<div class='clearfix'></div><br>").insertAfter(this);
					jQuery(this).remove();
				});					
				html2canvas(jQuery("#export"), {
					onrendered: function(canvas) {										
						var img = canvas.toDataURL("image/png");
						window.open(img);							
					}
				});
			}				
			jQuery('.modal').last().modal('hide');
		},2000);
		event.preventDefault();
		return false;
	}
	else if(jQuery(this).hasClass("download"))
	{
		jQuery.notify("Downloading please wait...", "info");
		window.open(jQuery(this).attr("href"), '_blank');
		event.preventDefault();
		return false;
	}
});
	
//Remove newlines, tabs so the content is displayed correctly
function ResponseFilter(data)
{
	return data.toString().replace(/(\r\n|\n|\r)/gm,"");
}

function PostDataChildForm(postdata, url)
{
	jQuery.post(BASE_URL + url, postdata, function(data, textStatus, jqXHR) {
			if(jQuery.trim(data) != "" && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				Dialog.Default("<h3>New Record</h3>", ResponseFilter(data), " Ok");
				setTimeout(function(){
					jQuery('input,textarea').not("[type=file],[type=submit]").maxlength({
						alwaysShow: true
					});
					jQuery(":input").inputmask();
				},1000);
			}
		}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
}

/*function GetData(data, url)
{
	jQuery.get(BASE_URL + url, data, function(data, textStatus, jqXHR) {
			if(textStatus == "success" && jQuery.trim(data) != "" && !jQuery.isNumeric(jQuery.trim(data)) && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				Dialog.Default("<h3>New Record</h3>", ResponseFilter(data), " Ok");
				setTimeout(function(){
					jQuery('input,textarea').not("[type=file],[type=submit]").maxlength({
						alwaysShow: true
					});
				},1000);
			}
			else if(textStatus != "success")
			{
				ResponseTypeMessage(textStatus, data);
			}
		}).fail(function(xhr, textStatus, error){ ResponseTypeMessage(textStatus, error); });
}*/

//Filter response type with a global message
function ResponseTypeMessage(textStatus, data)
{
	if(jQuery.trim(data) == "")
	{
		Dialog.Danger("Error", "The server response is empty!", "Ok", function() {
				
		});
		return false;
	}
	else
	{
		Dialog.Danger("Error", "Ups! There was an error processing the request! Error Text: " + textStatus + " - Data received: " + jQuery.trim(data), "Ok", function() {
				
		});
	}
}

//Forms Global Handler
jQuery(document).on("submit", "form", function (event) {
	var form = this;
	//Prevent Defaults Submit handler
	if (jQuery(form).hasClass("prevent"))
	{
		event.preventDefault();
		return false;
	}
	//Submit the form using ajax
	else if (jQuery(form).hasClass("ajax"))
	{
		if (Form.IsValid(form))
		{
			event.preventDefault();
			if(jQuery(form).hasClass("search"))
			{
				SubmitForm(form);
			}
			else
			{
				Dialog.Confirm("Confirm", "Are you sure that the information is correct?", "Yes", "No", function(confirm) {
					if(confirm)
					{
						SubmitForm(form);
					}
				});
			}
		}
		return false;			
	}
	//Submits the form normally
	else 
	{
		return true;	
	}
		
});

//Ajax Request for for submission
function SubmitForm(form)
{
	jQuery(form).ajaxSubmit({
		url: BASE_URL + jQuery(form).attr("action"),
		type: "post",
		cache: false,
		timeout: 10000,
		processData: false,
		contentType: false,
		success: function (data, textStatus, jqXHR, jQueryform) 
		{
			if(textStatus == "success" && jqXHR.getResponseHeader("content-type") == "text/html")
			{
				if(jQuery(form).hasClass("search") && jQuery.trim(data) != "")
				{
					jQuery("#table-content").html(data);
					jQuery('table').DataTable();
				}
			}
			else if(jQuery(form).hasClass("search") && jQuery.trim(data) == "")
			{
				jQuery("#table-content").html("");
			}
		},
		error: function (xhr, textStatus, error)
		{
			Dialog.Danger("Error", "Ups! There was an error processing the request! Please try again! Error Text: " + textStatus + " - Error Thrown: " + error, "Ok", function() {
			});
		},
		xhrFields:
		{
			withCredentials: true
		},
		crossDomain: true
	});
}