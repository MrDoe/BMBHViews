﻿function pasteContent(sFieldId, sDatatype)
{
    if (window.clipboardData) // Internet Explorer
    {
        var sClipboardData = window.clipboardData.getData('Text');

        if (sDatatype == 'int')
        {
            sClipboardData = sClipboardData.replace(/\r\n/g, ",").trim();
            sClipboardData = sClipboardData.substring(0, sClipboardData.length - 1);
            sClipboardData = "(" + sClipboardData + ")";
        }
        else
        {
            sClipboardData = sClipboardData.replace(/\r\n/g, ",").trim();
            sClipboardData = sClipboardData.substring(0, sClipboardData.length - 1);
            var aClipboardData = sClipboardData.split(',');

            // trim all values
            for (var i = 0; i < aClipboardData.length; ++i)
                aClipboardData[i] = "'" + aClipboardData[i].trim() + "'";

            sClipboardData = aClipboardData.join();    
            sClipboardData = "(" + sClipboardData + ")";
        }
        document.getElementById(sFieldId).value = sClipboardData;
        return true;
    }
    else
    {   // Not IE
        alert('Not IE');
        return false;
    }
}

function InputBox(params) {
    var result = prompt("Name der Werteliste:", "");
    document.getElementById("MainContent_HiddenInputBox").value = result;
    __doPostBack('<%= btnSaveSearch.UniqueID%>', params);
}

function DeleteSearch(params) {
    var result = confirm("Suche wirklich löschen?") == true? "YES" : "NO";
    document.getElementById("MainContent_HiddenInputBox").value = result;
    __doPostBack('<%= btnDeleteSearch.UniqueID%>', params);
}

$(document).ready(function () {
    if (window.location.pathname == "/views/Results" ||
        window.location.pathname == "/Results") {
        $("#MainContent_pnlGrid").height($(window).height() - 100);
        $("#MainContent_pnlGrid").width($(window).width() - 20);
        $("body").css("overflow", "hidden");
    }
    else
        $("body").css("overflow", "visible");
});

function SetScrollBars(e) {
    if (window.location.pathname == "/views/Results" ||
        window.location.pathname == "/Results") {
        $("#MainContent_pnlGrid").height($(window).height() - 100);
        $("#MainContent_pnlGrid").width($(window).width() - 20);
        $("body").css("overflow", "hidden");
    }
    else
        $("body").css("overflow", "visible");

};

$(document).load($(window).bind("resize", SetScrollBars));

function DeptChange() {
    var value = $("#cboDept option:selected").val();
    if (value == "")
        return false;
    else {
        __doPostBack(value, '');
    }
}