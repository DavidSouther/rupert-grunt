module.exports = function(app, config){
  var titlesFile = config.find('titles.file', 'TITLES_FILE', './titles.json');
  var titles = require(titlesFile);
  app.get('/api/titles/random', function(request, response){
    response.send(titles[Math.floor(Math.random() * titles.length)]);
  });
};
