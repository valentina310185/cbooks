var Table =
{
    ColumnsName: function (data, callback)
    {
        var columns = [];
        $.each(data, function () {
            $.each(this, function (key, val) {
                if (columns.indexOf(key) == -1)
                    columns.push(key);
            });
        });
        return columns;
    },
    ColumnIndex: function (ColumnName, callback)
    {
        var index = -1;
        $('thead > tr > th').each(function () {
            if ($(this).text() === ColumnName) {
                index = $(this).index();
                if (Is.CallbackFunction(callback))
                    callback(index);
            }
        });
    }
}

function BuildTableFromJson(data, callback)
{     
    var table = "<div class='table-responsive'><table class='table table-striped table-bordered table-hover'><thead><tr>";
    var columns = Columns(data);
    for (var key in columns) {
        //IE 8,9 Bug!!
        if(typeof lang[columns[key].toString().toLowerCase()] !== "undefined")
            table += "<th>" + lang[columns[key].toString().toLowerCase()] + "</th>";
    }
    table += "</tr></thead><tbody>";
    $.each(data, function () {
        table += "<tr>";
        $.each(this, function (key, val) {
            table += "<td>" + val + "</td>";
        });
        table += "</tr>";
    });
    table += "</tbody></table></div>";
    if ((callback) && (typeof callback === 'function')) {
        callback(table);
    }
}





function table_data_render(column_name) {
    get_column_index(column_name, function(column_index) {
        if(column_index > -1) {
            $('tbody tr').each(function () {
                $(this).find('td:eq(' + column_index + ')').text(lang[$(this).find('td:eq(' + column_index + ')').text()])
            })
        }
    })
}