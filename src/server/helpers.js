require('coffee-script/register');
chai = require('chai');
global.sinon = require('sinon');
chai.use(require('sinon-chai'));
global.should = chai.should();

/**
 * Returns a supertest request with a base Rupert app using the provided route.
 */
global.superroute = function superroute(route, config){
  var Config = require('rupert/src/config');
  config = new Config(config || {});
  var app = route(require('rupert/src/base')(config), config);
  return require('supertest')(app);
};
