class PageNavigatorComponent extends Ember.Component

  nextPage: 'nextPage'
  previousPage: 'previousPage'

  actions:
    nextPage: -> @sendAction 'nextPage' unless @model.lastPage
    previousPage: -> @sendAction 'previousPage' unless @model.firstPage

`export default PageNavigatorComponent`