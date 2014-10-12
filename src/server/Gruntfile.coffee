process.env.LOG_LEVEL = 'error'
module.exports = (grunt, config)->
    testFiles = grunt.expandFileArg('src/server', '*/')
    grunt.Config =
        mochaTest:
            server:
                options:
                    reporter: 'spec'
                src: testFiles
        watch:
            server:
                files: testFiles
                tasks: [
                    'testServer'
                ]
                options:
                    spawn: false


    grunt.registerTask 'testServer', 'Test the server.', ['mochaTest:server']

    grunt.registerTask 'server', 'Prepare the server.', [
        'testServer'
    ]
