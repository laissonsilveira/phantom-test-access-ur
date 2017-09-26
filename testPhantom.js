var page = require('webpage').create();
var url = 'http://esaj.tjac.jus.br/cpopg/open.do';

page.onResourceRequested = function (request) {
    console.log('REQUEST: ' + JSON.stringify(request, undefined, 4));
};
page.onResourceReceived = function (response) {
    console.log('RECEIVE: ' + JSON.stringify(response, undefined, 4));
};
// page.settings.userAgent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
page.open(url, function (status) {
    console.log("STATUS: " + status);
    if (status === "success") {
        var img = 'screenshots/' + new Date().getTime() + '.png';
        page.render(img);
        console.log("Screenshot saved: " + img);
    }
    phantom.exit();
});