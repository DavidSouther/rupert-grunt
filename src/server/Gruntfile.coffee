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

    grunt.registerTask 'client-server-launch', ->
        done = @async()
        # process.argv = 'node app.js --api'.split ' '
        require(config.server)
        # process.env.APP_ROOT = 'https://dol-test.dataonline.com:8443/'
        setTimeout done, 5e3

    grunt.registerTask 'testServer', 'Test the server.', ['mochaTest:server']

    grunt.registerTask 'server', 'Prepare the server.', [
        'testServer'
    ]
