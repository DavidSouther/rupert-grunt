module.exports = function(grunt) {
  require('rupert-grunt')(grunt, {
    server: __dirname + '/app.js'
  });

  grunt.registerTask('watcher', [ 'rupert-watch' ]);
  grunt.registerTask('default', [ 'rupert-default' ]);
};
