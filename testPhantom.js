var page = require('webpage').create();
var url = 'http://esaj.tjac.jus.br/cpopg/open.do';
page.open(url, function(status) {
  console.log("Status: " + status);
  if(status === "success") {
    page.render('esaj.png');
  }
  phantom.exit();
});
