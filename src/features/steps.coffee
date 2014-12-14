global.Q = require('q')
chai = require('chai')
global.sinon = require('sinon')
chai.use(require('sinon-chai'))
global.should = chai.should()

module.exports = (steps, config)->
  ->
    require('qcumber')(@)
    require('qcumberbatch').steps.call(@)

    if config.protractor
      @protractor = require('protractor').wrapDriver @world.driver

    @PORT = process.env.PORT or 80
    @APP = process.env.APPLICATION or ''
    @ROOT = process.env.APP_ROOT or "http://localhost:#{@PORT}/#{@APP}"
    process.env.APP_ROOT = @ROOT

    steps.call this
