/* jshint esversion: 6 */

// Convert newlines to <br>, multiple lead spaces to non-breaking
function escapeText(str) {
    return str.replace(/^ +/mg, function (match) {
        return match.replace(/ /g, '&nbsp;');
    }).replace(/\n/g, '<br>');
}

// read text from URL location
function getPoem(file) {
    var request = new XMLHttpRequest();
    request.open('GET', file);
    request.send(null);
    request.onreadystatechange = function() {
        if (request.readyState === 4 && request.status === 200) {
        var type = request.getResponseHeader('Content-Type');
            if (type.indexOf("text") !== 1) {
                console.log("Got file:", file);
                document.getElementById("viewer").innerHTML = escapeText(request.responseText);
            }
        }
    }
}

$(document).ready(() => {
    $("[title]").tooltip();

    getPoem('./AimWasSong-Frost-113.txt');
});
