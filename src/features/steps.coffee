global.Q = require('q')
global.should = require('should')

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

        console.log process.env.PORT, @PORT, process.env.APPLICATION, @APP, process.env.APP_ROOT, @ROOT

        steps.call this
