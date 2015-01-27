global.Q = require('q')
chai = require('chai')
global.sinon = require('sinon')
chai.use(require('sinon-chai'))
global.should = chai.should()

module.exports = (steps, config = {protractor: no})->
  ->
    unless this.loaded
      require('qcumber')(@)
      require('qcumberbatch').steps.call(@)

      @PORT = process.env.PORT or 80
      @APP = process.env.APPLICATION or ''
      @ROOT = process.env.APP_ROOT or "http://localhost:#{@PORT}/#{@APP}"
      process.env.APP_ROOT = @ROOT

      this.loaded = yes

    if config.protractor and !@protractorized
      @protractor = require('protractor').wrapDriver @world.driver
      @protractorized = yes

    steps.call this
