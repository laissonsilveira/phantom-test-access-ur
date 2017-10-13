var page = require('webpage').create();
var url = 'site/TestAcento.html';
// var url = 'http://get.adobe.com/br/flashplayer/about/';

// page.onResourceRequested = function (request) {
//     console.log('REQUEST: ' + JSON.stringify(request, undefined, 4));
// };
// page.onResourceReceived = function (response) {
//     console.log('RECEIVE: ' + JSON.stringify(response, undefined, 4));
// };

page.onConsoleMessage = function (msg) {
    console.log(msg);
};

page.settings.userAgent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';

page.onInitialized = function () {
    // page.evaluate(function () {
    //     window.navigator["plugins"] = {
    //         length: 1,
    //         'Shockwave Flash': {
    //             description: 'fakeflash'
    //         }
    //     };
    // });
};

var takeScreenshot = function (number) {
    page.evaluate(function() {
        var style = document.createElement('style'),
            text = document.createTextNode('body { background: #fff }');
        style.setAttribute('type', 'text/css');
        style.appendChild(text);
        document.head.insertBefore(style, document.head.firstChild);
    });
    var img = 'screenshots/' + (number ? number + '_' : '') + new Date().getTime() + '.png';
    page.render(img);
    console.log("Screenshot saved: " + img);
};

page.open(url, function (status) {
    console.log("STATUS: " + status);
    if (status === "success") {
        takeScreenshot();
        phantom.exit();
        // window.setTimeout(function () {
            // page.evaluate(function () {
            //     console.log(JSON.stringify(window.navigator));
            // });
            // takeScreenshot(4);
            // phantom.exit();
        // }, 5000);
    }
});