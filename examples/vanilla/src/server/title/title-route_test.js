/* globals describe: false, it: false, superroute: false */
describe('Rupert Title API', function(){
  it('sends funny titles', function(done){
    superroute(require('./title-route'))
    .get('/api/titles/random')
    .expect(200)
    .end(done);
  });
});
