Path = require 'path'
request = require('superagent')
fs = require 'fs'
Q = require 'q'

module.exports = (grunt, config)->
    flatten = (a, b)-> a.concat b
    prefix = (prefix)-> (str)->"#{prefix}#{str}"

    testFileOrdering = grunt.expandFileArg(
        config.client?.root or 'src/client/'
        config.client?.test?.glob or '**/'
    )

    grunt.Config =
        notify:
            client:
                options:
                    message: 'Client Tests Complete.'
        watch:
            client:
                files: [
                    'src/client/**'
                ]
                tasks: [
                    'client'
                    'notify:client'
                ]

    # butt - Browser Under Test Tools
    butt = config.client?.browsers or []
    unless process.env.DEBUG
        if process.env.BAMBOO
            butt.push 'PhantomJS'
        else if process.env.TRAVIS
            butt.push 'Firefox'
        else
            butt.push 'Chrome'

    preprocessors =
        'src/client/**/*test.coffee': [ 'coffee' ]
        'src/client/**/*mock.coffee': [ 'coffee' ]
        'src/client/tools/**/*.coffee': [ 'coffee' ]

    if true and (not process.env.DEBUG or process.env.COVER)
        app = (config.client?.write?.dest or './www') + '/application.js';
        preprocessors[app] = [ 'coverage' ]

    grunt.Config =
        karma:
            client:
                options:
                    browsers: butt
                    frameworks: [ 'mocha', 'sinon-chai' ]
                    reporters: [ 'spec', 'junit', 'coverage' ]
                    singleRun: true,
                    logLevel: 'INFO'
                    preprocessors: preprocessors
                    files: [
                        config.client?.files || []
                        [
                            '/vendors.js'
                            '/templates.js'
                            '/application.js'
                        ].map (_)-> (config.client?.write?.dest or './www') + _

                        'node_modules/rupert-grunt/node_modules/' +
                            'angular-mocks/angular-mocks.js'
                        'node_modules/rupert-grunt/node_modules/' +
                            'mockasing/src/tools/*'

                        config.client?.test?.tools || [
                          'src/client/tools/**'
                          'src/client/**/*mock.coffee'
                        ]

                        testFileOrdering
                    ].reduce(flatten, [])
                    junitReporter:
                        outputFile: 'build/reports/karma.xml'
                    coverageReporter:
                        type: 'lcov'
                        dir: 'build/reports/coverage/'

    grunt.registerTask 'writeClient', ->
        done = @async()
        options = @options
            dest: config.client?.write?.dest or './www'
            files: [
                'index.html'
                'application.js'
                'application.js.map'
                'templates.js'
                'vendors.js'
                'vendors.css'
                'all.css'
                'screen.css'
                'print.css'
            ].concat (config.client?.write?.files or [])
        options.dest = Path.resolve process.cwd(), options.dest
        getFile = (file)->
            defer = Q.defer()
            grunt.verbose.writeln "Starting request for #{file}..."
            request.get("#{process.env.URL}#{file}")
            .buffer()
            .end (err, res)->
                return defer.reject err if err
                return defer.reject res if res.status isnt 200
                grunt.file.write Path.join(options.dest, file), res.text
                defer.resolve()
            defer.promise

        writeFiles = ->
            pass = true
            process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'
            grunt.verbose.writeln 'Stassets compiled all files!'
            promises = options.files.map getFile
            Q.all(promises)
            .catch (err)->
                grunt.debug.write err
                grunt.debug.writeln ''
                pass = false
            .then ->
                process.env.NODE_TLS_REJECT_UNAUTHORIZED = null
                done pass

        try
            base = require(config.server)
            base.start().then ->
              base.app.stassets.promise.then writeFiles
        catch e
            # Assume it's already running. TODO look for EACCESS
            console.log 'Failed to start client'
            console.log e
            console.log e.stack
            process.env.URL = 'localhost:8080' # Next best guess
            writeFiles()

    grunt.registerTask 'watchClient',
        [
            'watch:client'
        ]

    grunt.registerTask 'testClient',
        'Run karma tests against the client.',
        [
            'logErrors'
            'writeClient'
            'logDefault'
            'karma:client'
        ]

    grunt.registerTask 'client',
        'Prepare and test the client.',
        [
            'testClient'
        ]
