`import growl from 'math-flows-client/utils/growl'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class ApplicationRoute extends Ember.Route

  voicer: service()
  structure: service()
  me: alias 'session.me'
  structuredMe: computed 'me', -> @structure.structuredUser(@me) if @me?

  beforeModel: -> 
    if localStorage.mathFlowsToken
      @session.open().then(
        =>
          @sessionSuccessHandler()
        =>
          @session.open().then => @sessionSuccessHandler()
      )
    else
      Ember.$(".center-spinner").hide()

  sessionSuccessHandler: ->
    Ember.$(".center-spinner").hide()
    @voicer.setup() unless @session.me.guest
    @keen.addEvent 'session'
    if __insp?
      __insp.push(['identify', @session.me.name])
      __insp.push(['tagSession', @structuredMe])

  actions:
    logout: ->
      @session.close()
      @transitionTo 'index'

    saveModel: (model) -> saveModel model

    authenticate: ->
      @transitionTo('loading').then =>
        @torii.open('google-oauth2').then( 
          (authData) => 
            growl authData, 'muted'
            @session.post(authData.authorizationCode,authData.redirectUri).then => 
              @transitionTo 'me'
              @voicer.setup()
          (error) => growl error
        )

    authenticateForUservoice: ->
      @transitionTo('loading').then =>
        @torii.open('google-oauth2').then( 
          (authData) => 
            growl authData, 'muted'
            @session.post(authData.authorizationCode,authData.redirectUri).then => 
              window.location.href = "http://support.mathflows.com/login_success?sso=" + @session.me.uservoiceToken
          (error) => growl error
        )     

    closeModal: -> @modaler.closeModal()

`export default ApplicationRoute`