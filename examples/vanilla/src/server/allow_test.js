describe('CORS Access Control', function() {
  it('attaches Allow headers', function(done) {
    var allow = require('./allow');
    superroute(function(app){
      allow(app);
      app.get('/', function(q, s){
        s.status(200).send();
      });
    })
    .get('/')
    .expect('Access-Control-Allow-Origin', '*')
    .expect('Access-Control-Allow-Headers', 'Content-Type')
    .end(done);
  });
});
