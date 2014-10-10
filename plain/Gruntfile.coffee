module.exports = (grunt)->
    require('ng-stassets-grunt')(grunt, config)

    grunt.registerTask ‘watcher’, [ ‘ng-stassets-watch’ ]
    grunt.registerTask 'default', [ 'ng-stassets-default' ] 
