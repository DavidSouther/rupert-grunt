describe 'Rupert App', ->
    describe 'Title Service', ->
        beforeEach module 'rupert-app.title-service'

        it 'has a good title', inject (TitleSvc)->
            TitleSvc.title.should.equal 'A Rupert SPA'
