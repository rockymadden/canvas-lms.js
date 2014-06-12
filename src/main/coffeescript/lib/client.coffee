bilby = require('bilby')
httpClosure = require('./http')

clientClosure = (@baseUrl, @token) ->
	withSession: (f) ->
		http = httpClosure(baseUrl, token)

		f(Object.freeze(
			# Account functions.
			deleteAccountUser: bilby.bind(http.delete)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/users/#{ i.user_id }")
			getAccount: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }")
			getAccountCourses: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/courses")
			getAccountSubs: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/sub_accounts")
			getAccountUsers: bilby.bind(http.get)(http, -> "/api/v1/accounts/#{ i.account_id || i }")
			getAccounts: bilby.bind(http.get)(http, (-> '/api/v1/accounts'), null)
			postAccountSub: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/sub_accounts")
			postAccountUser: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
			putAccount: bilby.bind(http.put)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }")
			putAccountUsersMerge: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id }/merge_into/accounts/#{ i.destination_account_id }/users/#{ i.destination_user_id }")

			# User self functions.
			deleteSelfStreamItem: bilby.bind(http.delete)(http, (i) -> "/api/v1/users/self/activity_stream/#{ i.user_id || i }")
			deleteSelfStreamItems: bilby.bind(http.delete)(http, (-> '/api/v1/users/self/activity_stream'), null)
			getSelfEvents: bilby.bind(http.get)(http, (-> '/api/v1/users/self/upcoming_events'), null)
			getSelfStreamItems: bilby.bind(http.get)(http, (-> '/api/v1/users/self/activity_stream'), null)
			getSelfStreamItemsSummary: bilby.bind(http.get)(http, (-> '/api/v1/users/self/activity_stream/summary'), null)
			getSelfTodos: bilby.bind(http.get)(http, (-> '/api/v1/users/self/todo'), null)

			# User functions.
			deleteUser: bilby.bind(http.delete)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/users/#{ i.user_id }")
			deleteUserCustom: bilby.bind(http.delete)(http, (i) -> "/api/v1/users/#{ i.user_id} /custom_data/#{ i.scope }")
			getUser: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/profile")
			getUserAvatars: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/avatars")
			getUserCustom: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id} /custom_data/#{ i.scope }")
			getUserPageViews: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/page_views")
			getUserProfile: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/profile")
			getUserSettings: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/settings")
			postUser: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
			# TODO: postUserFile
			putUser: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id || i }")
			putUserCustom: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id} /custom_data/#{ i.scope }")
			putUserSettings: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/settings")
			putUsersMerge: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id }/merge_into/#{ i.destination_user_id }")
		))

module.exports = Object.freeze(clientClosure)
