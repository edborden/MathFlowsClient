class LoginRoute extends Ember.Route

	beforeModel: ->
		if @session.loggedIn and not @session.me.guest
			window.location.href = "http://support.mathflows.com/login_success?sso=" + @session.me.uservoiceToken

`export default LoginRoute`