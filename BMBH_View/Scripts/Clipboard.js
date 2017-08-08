function pasteContent(sFieldId, sDatatype)
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
            sClipboardData = sClipboardData.replace(/\r\n/g, "','").trim();
            sClipboardData = sClipboardData.substring(0, sClipboardData.length - 2);
            sClipboardData = "('" + sClipboardData + ")";
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