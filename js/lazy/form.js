var Form = {
    IsValid: function (form)
    {
        var IsValid = true;
        jQuery('#' + jQuery(form).attr("id") + ' *').filter(':input').not(":button").each(function ()
        {
            if (!IsValid)
                return;
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
        });
        return IsValid;
    }
};