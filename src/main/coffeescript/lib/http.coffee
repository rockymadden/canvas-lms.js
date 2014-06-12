Agent = require('keep-alive-agent')
bilby = require('bilby')
encode = require('./encode')
q = require('q')
qio = require('q-io/http')
truthy = require('truthy.js')

http = class Http
	@parse: (response) ->
		if not truthy.bool.lengthy(response)
			bilby.left('Expected a lengthy response.')
		else
			try
				json = JSON.parse(response)

				if truthy.bool.objecty(json) and json.hasOwnProperty('errors')
					bilby.left(json.errors[0]['message'])
				else
					bilby.right(json)
			catch
				bilby.left('Expected a JSON based response.')

	@querystring: (query) -> truthy.opt.lengthy(query).map((_) -> '?' + encode.url(_)).getOrElse('')

	constructor: (@baseUrl, @token) ->
		@agent = if @baseUrl.indexOf('https:') == 0 then new Agent.Secure() else new Agent()

	delete: (path, interpolate, query) -> @withoutBody('DELETE')(path(interpolate), query)

	get: (path, interpolate, query) -> @withoutBody('GET')(path(interpolate), query)

	post: (path, interpolate, json, query) -> @withBody('POST')(path(interpolate), json, query)

	put: (path, interpolate, json, query) -> @withBody('PUT')(path(interpolate), json, query)

	withoutBody: (verb) => (path, query) =>
		deferred = q.defer()
		request =
			agent: @agent
			headers:
				'Authorization': 'Bearer ' + @token
				'User-Agent': 'canvas-lms.js'
			method: verb
			url: @baseUrl + path + http.querystring(query)

		qio.request(request)
			.then((_) -> _.body.read())
			.then((_) -> deferred.resolve(Http.parse(_.toString())))
			.catch((_) -> deferred.reject(_))
			.done()

		deferred.promise

	withBody: (verb) => (path, json, query) =>
		deferred = q.defer()
		jsonString = JSON.stringify(json)
		request =
			agent: @agent
			charset: 'UTF-8'
			headers:
				'Authorization': 'Bearer ' + @token
				'Content-Length': Buffer.byteLength(jsonString, 'utf8')
				'Content-Type': 'application/json'
				'User-Agent': 'canvas-lms.js'
			method: verb
			url: @baseUrl + path + http.querystring(query)
			body: [jsonString]

		qio.request(request)
			.then((_) -> _.body.read())
			.then((_) -> deferred.resolve(Http.parse(_.toString())))
			.catch((_) -> deferred.reject(_))
			.done()

		deferred.promise

module.exports = Object.freeze(http)
