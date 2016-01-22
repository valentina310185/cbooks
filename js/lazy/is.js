var Is = 
{
    Object: function(obj)
    {
        return typeof obj === "object";
    },
    String: function(obj)
    {
        return typeof obj === "string";
    },
    Number: function (obj)
    {
        return typeof obj === "number";
    },
    Boolean: function (obj)
    {
        return typeof obj === "boolean";
    },
    Undefined: function (obj) 
    {
        return typeof obj === "undefined";
    },
    Function: function (obj) 
    {
        return typeof obj === "function";
    },
    Null: function (obj)
    {
        return (Is.Object(obj) && obj === null);
    },
    Array: function (obj)
    {
        return Object.prototype.toString.call(obj) === '[object Array]';
    },
    EmptyArray: function (obj)
    {
        return (Is.Array(obj) && obj.length < 1);
    },
    InstanceOf: function(obj1, obj2)
    {
        return obj1 instanceof obj2;
    },
    Numeric: function (obj) 
    {
        return (Is.Input(obj)) ? jQuery.isNumeric(jQuery.trim(jQuery(obj).val())) : jQuery.isNumeric(obj);
    },
    Int: function (obj) 
    {
        return (Is.Input(obj)) ? parseInt(jQuery(obj).val()) : parseInt(obj);
    },
    Double: function(obj)
    {
        var regex = /^\d{0,2}(\.\d{0,2}){0,1}$/;
        return (Is.Input(obj)) ? regex.test(jQuery.trim(jQuery(obj).val())) : regex.test(jQuery.trim(obj));
    },
    Float: function (obj) 
    {
        return (Is.Input(obj)) ? parseFloat(jQuery(obj).val()) : parseFloat(obj);
    },
    Empty: function (obj)
    {
        return (Is.Input(obj)) ? jQuery.trim(jQuery(obj).val()) === "" : jQuery.trim(obj) === "";
    },
    Equal: function (obj1, obj2)
    {
        return obj1 == obj2;
    },
    EqualSameType: function (obj1, obj2)
    {
        return obj1 === obj2;
    },
    Greater: function (obj, lenght)
    {
        return obj.lenght > length;
    },
    GreaterEqual: function (obj, lenght)
    {
        return obj.lenght >= length;
    },
    Less: function (obj, lenght)
    {
        return obj.lenght < length;
    },
    LessEqual: function (obj, lenght)
    {
        return obj.lenght <= length;
    },
    Email: function (obj)
    {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return (Is.Input(obj)) ? regex.test(jQuery.trim(jQuery(obj).val())) : regex.test(jQuery.trim(obj));
    },
    Phone: function(obj) 
    {
        /*
	     * Formats allowed
	     * (123) 456 7899
	     * (123).456.7899
	     * (123)-456-7899
	     * 123-456-7899
	     * 123 456 7899
	     * 1234567899
	     */
        var regex = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/;
        return (Is.Input(obj)) ? regex.test(jQuery.trim(jQuery(obj).val())) : regex.test(jQuery.trim(obj));
    },
    AlphaNumeric: function(obj)
    {
        var regex = /^[a-zA-Z0-9]*$/;
        return (Is.Input(obj)) ? regex.test(jQuery.trim(jQuery(obj).val())) : regex.test(jQuery.trim(obj));
    },
    CallbackFunction: function (obj)
    {
        return ((obj) && (Is.Function(obj)));
    },
    Input: function (obj)
    {
        return (Is.Object(obj)) ? obj.tagName.toLowerCase() == "input" : jQuery(obj).tagName.toLowerCase() == "input";
    },
    ValidJson: function (json)
    {
        if (Is.Object(json))
        {
            return true;
        }
        else
        {
            try
            {
                JSON.parse(json);
                return true;
            } catch (e) {
                return false;
            }
        }
    },
};



/*
var Select = {
    AppendOptions: function(json, data) {
        var options = "";
        jQuery.each(data, function () {
            jQuery.each(this, function (key, val) {
                if (!isNotNumeric(val))
                    options += "<option value='" + val + "'>";
                else
                    options += val + "</option>";
            })
        });
        jQuery("#" + elemId).append(options);
    
    }   
}*/