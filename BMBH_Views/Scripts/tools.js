function pasteToGrid(sColumn, sender) {
    var content = document.getElementById("HiddenInputBox").value = sender.value;
    if (content && content.includes("\n")) {
        var sData = content.replace(/\n/g, ",").trim().replace('ä', 'ae').replace('ö', 'oe').replace('ü', 'ue').replace('ß', 'ss').replace('Ä', 'Ae').replace('Ö', 'Oe').replace('Ü', 'Ue');
        var aData = sData.substring(0, sData.length - 1).split(',');

        // trim all values
        for (var i = 0; i < aData.length; ++i)
            aData[i] = aData[i].trim();

        sData = aData.join();

        document.getElementById("HiddenInputBox").value = aData;
        __doPostBack('', sColumn);
    }
    else {
        alert("Falsches Eingabeformat! Es werden nur kopierte Spalten aus Excel unterstützt.");
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

function SetScrollBars(e) {
    if (window.location.pathname == "/views/Results" ||
        window.location.pathname == "/Views/Results" ||
        window.location.pathname == "/Results") {
        $("#MainContent_pnlGrid").height($(window).innerHeight() - 141);
        $("#MainContent_pnlGrid").width($(window).innerWidth() - 20);
        $("body").css("overflow", "hidden");
    }
    else
        $("body").css("overflow", "visible");

};

$(document).ready(function () {
    SetScrollBars(null);
});

$(document).on("load", $(window).bind("resize", SetScrollBars));

//function DeptChange() {
//    var value = $("#cboDept option:selected").val();
//    if (value == "")
//        return false;
//    else {
//        __doPostBack(value, 'PostFromDeptChange');
//        //__doPostBack('<%=updList.ClientID %>', 'PostFromDeptChange');
//    }
//}

function colorChanged(sender) {
    sender.get_element().style.color = "#" + sender.get_selectedColor();
    sender.get_element().value = "#" + sender.get_selectedColor();
}

function PostFromSearch(obj) {
        __doPostBack('btnSearch', obj.value);
}
