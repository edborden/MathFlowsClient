computed = Ember.computed
alias = computed.alias
service = Ember.inject.service
scheduleOnce = Ember.run.scheduleOnce
observer = Ember.observer

class PageEditorComponent extends Ember.Component

  # ATTRIBUTES

  page: null
  preview:false
  headers:false
  classNameBindings: ['preview']
  gridstack: null
  
  # SERVICES

  eventer: service()

  # COMPUTED

  alwaysShowResizeHandle: computed.not 'preview'
  gridstackOptions: computed -> 
    cell_height:18
    width:4
    float:true
    vertical_margin:9
    static_grid: @preview
    always_show_resize_handle: @alwaysShowResizeHandle

  # SETUP

  didInsertElement: -> 
    scheduleOnce 'afterRender', @, 'setupGridstack'

  setupGridstack: ->
    @gridstack = Ember.$(@element).children('.grid-stack').gridstack(@gridstackOptions).data 'gridstack'
    triggerSyncBlocks = Ember.run.bind @eventer,@eventer.triggerSyncBlocks
    Ember.$(@element).on 'dragstop', triggerSyncBlocks
    Ember.$(@element).on 'resizestop', triggerSyncBlocks    

  # BREAKDOWN

  willDestroyElement: ->
    @gridstack.destroy()
    Ember.$(@element).off 'change','**'

`export default PageEditorComponent`