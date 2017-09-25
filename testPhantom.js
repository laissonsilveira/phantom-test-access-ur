var page = require('webpage').create();
var system = require('system');
var url = 'http://esaj.tjac.jus.br/cpopg/open.do';
page.open(url, function(status) {
  console.log("Status: " + status);
  if(status === "success") {
  	var img = 'screenshots/' + new Date().getTime() + '.png';
    page.render(img);
    console.log("Screenshot saved: " + img);
  }
  phantom.exit();
});