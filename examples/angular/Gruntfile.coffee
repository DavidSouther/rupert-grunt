module.exports = (grunt)->
  require('rupert-grunt')(grunt, {
    server: __dirname + '/app.js',
    client:
      test:
        tools: [
          'angular-mocks/angular-mocks.js'
          'mockasing/src/tools/*'
        ].map (_)-> "node_modules/rupert-grunt/node_modules/#{_}"
  })

  grunt.registerTask 'watcher', [ 'rupert-watch' ]
  grunt.registerTask 'default', [ 'rupert-default' ]
