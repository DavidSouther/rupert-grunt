describe 'Rupert', ->
  it 'shows the correct h1 string', ->
    setTimeout ->
      elem = document.querySelector('body h1.test')
      elem.innerHTML.should.equal 'It Works!',
    5
