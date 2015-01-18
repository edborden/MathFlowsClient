`import {configurable} from 'torii/configuration'`
`import Oauth2 from 'torii/providers/oauth2-code'`

class GoogleOffline extends Oauth2
	name:    'google-offline'
	baseUrl: 'https://accounts.google.com/o/oauth2/auth'

	requiredUrlParams: ['state']
	optionalUrlParams: ['scope', 'request_visible_actions', 'access_type', 'approval_prompt']

	requestVisibleActions: configurable('requestVisibleActions', '')

	accessType: configurable('accessType', '')

	responseParams: ['code']

	scope: configurable('scope', 'email')

	state: configurable('state', 'STATE')

	redirectUri: configurable('redirectUri', 'http://localhost:8000/oauth2callback')

	approvalPrompt: configurable('approvalPrompt','auto')

`export default GoogleOffline`