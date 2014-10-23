console.log("In rupert-grunt server helpers.");
require('coffee-script/register');
global.should = require("should");

global.superRupert = function superRupert(route, config){
    var app = route(require('rupert/src/base'), config);
    return require('supertest')(app);
};
