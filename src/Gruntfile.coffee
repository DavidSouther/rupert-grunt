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
                '!src/client/d3/**'
            ]

        coffeelint:
            options:
                grunt.file.readJSON '.coffeelintrc'

            files: [
                'src/**/*.coffee'
                'Gruntfile.coffee'
            ]

        clean:
            all:
                [ 'build/' ]
        release:
            options:
                npm: no

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
            'features'
        ]

    grunt.registerTask 'rupert-default',
        'Perform all Prepare and Test tasks.',
        [ 'base' ]
