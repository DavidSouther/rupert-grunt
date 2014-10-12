Path = require 'path'
module.exports = (grunt, config = {})->

    require('grunt-recurse')(grunt, __dirname)

    grunt.expandFileArg = (
        prefix = '.',
        base = '**',
        postfix = '*test.coffee'
    )->
        part = (v)->"#{prefix}/#{v}#{postfix}"
        files = grunt.option('files')
        return part(base) unless files
        files.split(',').map (v)-> part(v)

    [
        './client'
        './server'
        './features'
    ].map (_)-> require(_ + '/Gruntfile')(grunt, config)

    grunt.Config =
        jshint:
            options:
                jshintrc: '.jshintrc'
            files: [
                'src/**/*.js'
            ].concat(config.jshint?.files or [])

        coffeelint:
            options:
                grunt.file.readJSON '.coffeelintrc'

            files: [
                'src/**/*.coffee'
                'Gruntfile.coffee'
            ]
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
                'watch:lint'
                'watch:client'
                'watch:server'
                # 'watch:features'
            ]
            options:
                logConcurrentOutput: yes

    base = process.cwd()
    grunt.file.setBase base, 'node_modules', 'rupert-grunt'
    grunt.finalize()
    grunt.file.setBase base

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
