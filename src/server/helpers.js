require('coffee-script/register');
chai = require('chai');
global.sinon = require('sinon');
chai.use(require('sinon-chai'));
global.should = chai.should();

/**
 * Returns a supertest request with a base Rupert app using the provided route.
 */
global.superroute = function superroute(route, config){
  var Config = require('rupert').Config;
  config = new Config(config || {});
  var app = require('rupert/src/15_base')(config);
  route(app, config);
  return require('supertest')(app);
};
