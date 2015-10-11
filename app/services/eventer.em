class EventerService extends Ember.Service with Ember.Evented

  ##SYNC BLOCKS

  triggerSyncBlocks: ->
    @trigger 'syncBlocks'

  triggerActiveObjChanged: ->
    @trigger 'activeObjChanged'

`export default EventerService`