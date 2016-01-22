var JSON = {
    HasRows: function (json) 
    {
        if (typeof json === 'object') {
            return json.length !== 0;
        }
        else {
            try {
                var arr = jQuery.parseJSON(json);
                return arr.length !== 0;
            } catch (e) {
                return false;
            }
        }
    },
    BindWithForm: function(json, callback) {
        if (Is.Json(json) & JSON.HasRows(json)) {
            $.each(json, function () {
                $.each(this, function (key, val) {
                    if($("#" + key).length)
                        $("#" + key).val(val);
                });
            });
            if (Is.CallbackFunction(callback)) {
                callback();
            }
        }
    }/*,
    BindMultipleJsonWithForm: function (json, callback) {
        var jsonArray = json.split("~");
        var index;
        for (index = 0; index < jsonArray.length; index++) {
            console.log(jsonArray[index]);
            bindJsonWithForm($.parseJSON(jsonArray[index]));
        }
        if (Is.CallbackFunction(callback)) {
            callback();
        }
    }*/
}