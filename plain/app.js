global.root = __dirname;
var config = require('./server.json');
config.name = require('./package.json').name;
require('rupert')(config).start();
