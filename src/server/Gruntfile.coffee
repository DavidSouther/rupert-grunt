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
      server:
        options:
          message: 'Server Tests Complete.'
    watch:
      server:
        files: 'src/server/**/*'
        tasks: [
          'testServer'
          'notify:server'
        ]

  grunt.registerTask 'testServer', 'Test the server.', [
    'logErrors'
    'mochaTest:server'
    'logDefault'
  ]

  grunt.registerTask 'server', 'Prepare the server.', [
    'testServer'
  ]
