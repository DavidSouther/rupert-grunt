Path = require 'path'
Config = require('rupert').Config
module.exports = (grunt, conf)->
    config = new Config conf || {}
    require('grunt-recurse')(grunt, __dirname)

    grunt.expandFileArg = (
        prefix = '.',
        base = '**',
        postfix = '*test.{js,coffee}'
    )->
        part = (v)->"#{prefix}/#{v}#{postfix}"
        files = grunt.option('files')
        return part(base) unless files
        files.split(',').map (v)-> part(v)

    # Include other grunts.
    [
        './client'
        './server'
        './features'
    ].map (_)-> require(_ + '/Gruntfile')(grunt, config)

    grunt.Config =
        jshint:
            options:
                jshintrc: config.find('jshint.rc', 'JSHINTRC', '.jshintrc')
            files: config.prepend('jshint.files', [
                'src/**/*.js'
                'Gruntfile.js'
            ])

        coffeelint:
            options:
                grunt.file.readJSON(config.find(
                  'coffeelint.rc', 'COFFEELINTRC', '.coffeelintrc'
                ))

            files: config.prepend('coffeelint.files', [
                'src/**/*.coffee'
                'Gruntfile.coffee'
            ])

        clean:
            all:
                [
                    'build/'
                    'www/'
                    '*.log'
                ]

    grunt.Config =
        notify:
            linting:
                options:
                    message: 'Linting Complete.'
        watch:
            lint:
                files: [
                    grunt.Config.jshint.files.concat(
                        grunt.Config.coffeelint.files
                    )
                ]
                tasks: [
                    'linting'
                    'notify:linting'
                ]
            options:
                spwan: no
        # release:
        #     options:
        #         npm: no
        concurrent:
            watchers: [
                'launchConcurrent'
                'watch:server'
                'watch:client'
                'watch:lint'
                # 'watch:features'
            ]
            options:
                logConcurrentOutput: yes

    base = process.cwd()
    grunt.file.setBase base, 'node_modules', 'rupert-grunt'
    grunt.finalize()
    grunt.file.setBase base

    grunt.registerTask 'launchConcurrent', ->
        done = @async()
        process.argv = (config.find('argv', 'node app.js')).split ' '
        require(config.find('server')).start()

    grunt.registerTask 'launch', ->
        done = @async()
        process.argv = (config.find('argv', 'node app.js')).split ' '
        base = require(config.find('server'))
        base.start ->
            base.app.stassets.promise.then ->
                process.env.APP_ROOT = base.app.url
                done()

    defaultLogLevel = config.find('log.level', 'LOG_LEVEL', null)
    grunt.registerTask 'logErrors', ->
        process.env.LOG_LEVEL = 'error'
    grunt.registerTask 'logDefault', ->
        if defaultLogLevel
            process.env.LOG_LEVEL = defaultLogLevel
        else
            delete process.env.LOG_LEVEL


    grunt.registerTask 'test',
        'Run all non-component tests.',
        [ 'testClient', 'testServer', 'features' ]

    grunt.registerTask 'build',
        'Prepare distributable components.',
        [ 'client' ]

    grunt.registerTask 'linting',
        'Lint all files.',
        [ 'jshint', 'coffeelint' ]

    grunt.registerTask 'base',
        'Perform component specific prep and test steps.',
        [
            'clean:all'
            'linting'
            'client'
            'server'
            # 'features'
        ]

    grunt.registerTask 'rupert-watch',
        'Have Rupert begin watching all files.',
        [
            'concurrent:watchers'
        ]

    grunt.registerTask 'rupert-default',
        'Perform all Prepare and Test tasks.',
        [ 'base' ]
