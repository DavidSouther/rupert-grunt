process.env.LOG_LEVEL = 'error'
module.exports = (grunt, config)->
    testFiles = grunt.expandFileArg('src/server', '**/*')
    grunt.Config =
        mochaTest:
            server:
                options:
                    reporter: 'spec'
                    require: './node_modules/rupert-grunt/src/server/helpers.js'
                src: testFiles
        notify:
            linting:
                options:
                    message: 'Server Tests Complete.'
        watch:
            server:
                files: testFiles
                tasks: [
                    'testServer'
                    'notify:server'
                ]

    grunt.registerTask 'testServer', 'Test the server.', ['mochaTest:server']

    grunt.registerTask 'server', 'Prepare the server.', [
        'testServer'
    ]
