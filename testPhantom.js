const page = require('webpage').create();
// const url = 'site/TestAcento.html';
const url = 'https:/www.facebook.com';

// page.onResourceRequested = function (request) {
//     console.log('REQUEST: ' + JSON.stringify(request, undefined, 4));
// };
// page.onResourceReceived = function (response) {
//     console.log('RECEIVE: ' + JSON.stringify(response, undefined, 4));
// };

page.onConsoleMessage = function (msg) {
    console.log(msg);
};

page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50 Safari/537.36';
page.customHeaders['Accept-Language'] = 'pt-BR';

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

const takeScreenshot = function (number) {
    page.evaluate(function() {
        const style = document.createElement('style'),
            text = document.createTextNode('body { background: #fff }');
        style.setAttribute('type', 'text/css');
        style.appendChild(text);
        document.head.insertBefore(style, document.head.firstChild);
    });
    const img = 'screenshots/' + (number ? number + '_' : '') + new Date().getTime() + '.png';
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