/* globals describe: false, it: false, beforeEach: false */
describe('Rupert App', function(){
  describe('Title Service', function(){

    var sut = null;
    beforeEach(function(){
      sut = new window.TitleManager();
    });

    it('has a good title', function(){
      sut.title.should.equal('Vanilla Rupert');
    });

    it('loads a random title', function(){

    });
  });
});
