`import FactoryGuy, { make } from 'ember-data-factory-guy'`

module 'Folder',
  afterEach: ->
    Ember.run(FactoryGuy, 'clearStore')

test 'it has projects', ->
  folder = make('folder')
  equal(folder.get('name'), "My Folder")