
Execução com pacote personalizado

	./3rd/phantomjs-2.1.1 --config='config.json' testPhantom.js > http.log

Execução com Phantom mais atual (sudo apt-get install phantomjs)

	phantomjs --config='config.json' testPhantom.js > http.log

Teste a URL no Chrome
	
	google-chrome --headless --disable-gpu --screenshot http://esaj.tjac.jus.br/cpopg/open.do