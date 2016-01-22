var Dialog = {
    Default : function(title, msg, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_DEFAULT,
            title: title,
            message:msg,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                action: function (dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Info: function(title, msg, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFO,
            title: title,
            message: msg,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                action: function (dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Primary: function(title, msg, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_PRIMARY,
            title: title,
            message: msg,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-default',
                icon: 'fa fa-check-square',
                action: function (dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Success: function(title, msg, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_SUCCESS,
            title: title,
            message:msg,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                action: function (dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Warning: function(title, message, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_WARNING,
            title: title,
            message: message,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-warning',
                icon: 'fa fa-check-square',
                action: function(dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Danger: function(title, message, buttonText, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_DANGER,
            title: title,
            message: message,
            buttons: [{
                label: " " + buttonText,
                cssClass: 'btn-warning',
                icon: 'fa fa-check-square',
                action: function(dialog) {
                    dialog.close();
                    if(Is.CallbackFunction(callback))
                        callback();
                }
            }]
        });
    },
    Confirm: function (title, msg, buttonTextPrimary, buttonTextSecondary, callback) {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFORMATION,
            title: title,
            message: msg,
            onhide: function (dialog) {
                if (Is.CallbackFunction(callback)) {
                    callback(null);
                }
            },
            buttons: [{
                label: " " + buttonTextPrimary,
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                hotkey: 13,
                action: function (dialog) {
                    if (Is.CallbackFunction(callback)) {
                        callback(true);
                    }
                    dialog.close();
                }
            }, {
                label: " " + buttonTextSecondary,
                cssClass: 'btn-danger',
                icon: 'fa fa-remove',
                action: function (dialog) {
                    if (Is.CallbackFunction(callback)) {
                        callback(false);
                    }
                    dialog.close();
                }
            }]
        });
    },
    Decision: function(title, msg, buttonTextPrimary, buttonTextSecondary, buttonTextTertiary, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFORMATION,
            title: title,
            message: msg,
            buttons: [{
                label:  " " + buttonTextPrimary,
                cssClass: 'btn-primary',
                icon: 'fa fa-plus',
                action: function (dialog) {
                    if (Is.CallbackFunction(callback)) {
                        callback(true);
                    }
                    dialog.close();
                }
            }, {
                label: " " + buttonTextSecondary,
                cssClass: 'btn-warning',
                icon: 'fa fa-edit',
                action: function (dialog) {
                    if (Is.CallbackFunction(callback)) {
                        callback(false);
                    }
                    dialog.close();
                }
            }, {
                label: " " + buttonTextTertiary,
                cssClass: 'btn-default',
                icon: 'fa fa-check-square',
                action: function (dialog) {
                    if (Is.CallbackFunction(callback)) {
                        callback(null);
                    }
                    dialog.close();
                }
            }]
        });  
    },
    Prompt: function (input_msg, callback)
    {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFORMATION,
            title: "",
            message: input_msg + '<input type="text" class="form-control">',
            onshown: function (dialog) {
                dialog.getModalBody().find('input').focus()
            },
            onhide: function (dialog) {
                var val = jQuery.trim(dialog.getModalBody().find('input').val());
                if (Is.CallbackFunction(callback))
                    callback(val);
            },
            buttons: [{
                label: " Ok",
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                hotkey: 13,
                action: function (dialog) {
                    dialog.close();
                }
            }]
        });
    },
    PromptDouble: function(input_msg1, input_msg2, callback) {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFORMATION,
            title: "",
            message: input_msg1 + '<input id="input1" type="text" class="form-control">' + input_msg2 + '<input id="input2" type="text" class="form-control">',
            onshown: function (dialog) {
                dialog.getModalBody().find('#input1').focus()
            },
            onhide: function (dialog) {
                var val1 = jQuery.trim(dialog.getModalBody().find('#input1').val());
                var val2 = jQuery.trim(dialog.getModalBody().find('#input2').val());
                if (Is.CallbackFunction(callback))
                    callback(val1, val2);
            },
            buttons: [{
                label: " Ok",
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                hotkey: 13,
                action: function (dialog) {
                    dialog.close();
                }
            }]
        });
    },
	PromptTriple: function(input_msg1, input_msg2, input_msg3, callback) {
        BootstrapDialog.show({
            type: BootstrapDialog.TYPE_INFORMATION,
            title: "",
            message: input_msg1 + '<input id="input1" type="text" class="form-control">' + input_msg2 + '<input id="input2" type="text" class="form-control">' + input_msg3 + '<input id="input3" type="text" class="form-control">',
            onshown: function (dialog) {
                dialog.getModalBody().find('#input1').focus()
            },
            onhide: function (dialog) {
                var val1 = jQuery.trim(dialog.getModalBody().find('#input1').val());
                var val2 = jQuery.trim(dialog.getModalBody().find('#input2').val());
				var val3 = jQuery.trim(dialog.getModalBody().find('#input3').val());
                if (Is.CallbackFunction(callback))
                    callback(val1, val2, val3);
            },
            buttons: [{
                label: " Ok",
                cssClass: 'btn-primary',
                icon: 'fa fa-check-square',
                hotkey: 13,
                action: function (dialog) {
                    dialog.close();
                }
            }]
        });
    }
}