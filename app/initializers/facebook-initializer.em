`import config from 'math-flows-client/config/environment'`

initializer =

  initialize: ->

    fbInit = ->
      FB.init
        appId      : config.fbAppId
        xfbml      : true
        version    : 'v2.5'

    if FB?
      fbInit()
    else
      `window.fbAsyncInit = fbInit`

`export default initializer`