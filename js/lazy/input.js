var Input =
{
    MaxLength: function (obj) 
    {
        return (Is.Input(obj)) ? jQuery(obj).attr("maxLength") : null;
    },
    TextLength: function(obj) 
    {
        return (Is.Input(obj)) ? jQuery(obj).val().length : null;
    },
    Type : function (obj)
    {
        return (Is.Input(obj)) ? jQuery(obj).attr("type") : null;
    },
    Text : function (obj)
    {
        return (Is.Input(obj)) ? jQuery(obj).val() : null;
    },
    Success: function (elem) 
    {
        Input.IconClear(elem);
        jQuery(elem).closest("div .form-group").addClass("has-success");
        jQuery(elem).parent("div").addClass("input-group merged");
        jQuery(elem).parent("div").append("<span class='input-group-addon'><i class='fa fa-check'></i></span>");
    },
    Error: function (elem) 
    {
        Input.IconClear(elem);
        jQuery(elem).closest("div .form-group").addClass("has-error");
        jQuery(elem).parent("div").addClass("input-group merged");
        jQuery(elem).parent("div").append("<span class='input-group-addon'><i class='fa fa-close'></i></span>");
        jQuery('html, body').animate({
            scrollTop: jQuery(elem).offset().top - 80
        }, 500, function () {
            jQuery(elem).closest("div .form-group").addClass("shake animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                jQuery(this).removeClass("shake animated");
                jQuery(elem).focus();
            });
        });
    },
    Warning: function (elem) 
    {
        Input.IconClear(elem);
        jQuery(elem).closest("div .form-group").addClass("has-warning");
        jQuery(elem).parent("div").addClass("input-group merged");
        jQuery(elem).parent("div").append("<span class='input-group-addon'><i class='fa fa-exclamation-triangle'></i></span>");
		jQuery('html, body').animate({
            scrollTop: jQuery(elem).offset().top - 80
        }, 500, function () {
            jQuery(elem).closest("div .form-group").addClass("shake animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                jQuery(this).removeClass("shake animated");
                jQuery(elem).focus();
            });
        });
    },
    IconClear: function (elem) 
    {
    	jQuery(elem).closest("div").removeClass("input-group merged");
        jQuery(elem).closest("div .form-group").removeClass("has-error has-success has-warning");
        jQuery(elem).parent("div").find("span").remove();
    },
    //Prepares is the real-time typing corrector
    Validate: function (input)
    {
		if(!!jQuery(this).attr('readonly'))
		{
			Input.Success(this);
		}
		else if (jQuery(this).hasClass('optional') && jQuery.trim(jQuery(this).val()) == "")
		{
			Input.Success(this);
		} 
		else if(!new RegExp(jQuery(this).attr("regex")).test(jQuery.trim(jQuery(this).val())))
		{
			Input.Error(this);
			IsValid = false;
			return;
		}
		else
		{
			Input.Success(this);
		}
    },
    ValidateInputAndTableSubmitRow: function (input)
    {
		if(!!jQuery(input).attr('readonly'))
		{
			Input.Success(input);
		}
		else if (jQuery(input).hasClass('optional') && jQuery.trim(jQuery(input).val()) == "")
		{
			Input.Success(input);
		} 
		else if(!new RegExp(jQuery(input).attr("regex")).test(jQuery.trim(jQuery(input).val())))
		{
			Input.Error(input);
			return;
		}
		else
		{
			jQuery(input).closest("tr").addClass("success");
			jQuery(input).closest("tr").find(':input').not(":button").each(function ()
	        {
	        	jQuery(this).addClass("dirty");
	        });
	        jQuery("tr").find(":input").not(".dirty").not(":button").each(function() 
	        {
	        	jQuery(this).attr("disabled", "disabled");
	        });
	        SubmitForm(jQuery("form"));
	        setTimeout(function()
	        {
	        	jQuery(input).closest("tr").removeClass("success");
	        	jQuery("tr").find(":input").not(".dirty").not(":button").each(function() 
				{
					jQuery(this).removeAttr("disabled");
				});
        	}
        	,2000);
		}
    },
};