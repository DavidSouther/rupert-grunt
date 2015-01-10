/* globals describe: false, it: false, superroute: false */
describe('CORS Access Control', function() {
  it('attaches Allow headers', function(done) {
    superroute(require('./allow'))
    .get('/')
    .expect('Access-Control-Allow-Origin', '*')
    .expect('Access-Control-Allow-Headers', 'Content-Type')
    .end(done);
  });
});
