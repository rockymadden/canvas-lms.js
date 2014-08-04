Agent = require('keep-alive-agent')
bilby = require('bilby')
encode = require('./encode')
q = require('q')
qio = require('q-io/http')
truthy = require('truthy.js')

http =
  parse: (response) -> truthy.eth.lengthy(response).fold(
    (-> bilby.left('Expected a lengthy response.'))
    ((_) ->
      try
        e = truthy.eitherize((j) => (truthy.bool.objecty(j) and j.hasOwnProperty('errors')))

        e(JSON.parse(_)).fold(
          ((r) -> bilby.right(r))
          ((l) -> bilby.left(l.errors[0]['message']))
        )
      catch
        bilby.left('Expected a JSON based response.')
    )
  )

  querystring: (query) -> truthy.opt.lengthy(query).map((_) -> '?' + encode.url(_)).getOrElse('')

httpClosure = (@baseUrl, @token) ->
  agent: new Agent.Secure()

  delete: (path, interpolate, query) -> @withoutBodyJson('delete')(path(interpolate), query)

  get: (path, interpolate, query) -> @withoutBodyJson('get')(path(interpolate), query)

  post: (path, interpolate, json, query) -> @withBodyJson('post')(path(interpolate), json, query)

  put: (path, interpolate, json, query) -> @withBodyJson('put')(path(interpolate), json, query)

  withoutBodyJson: (verb) -> (path, query) ->
    deferred = q.defer()
    request =
      agent: @agent
      headers:
        'Authorization': 'Bearer ' + token
        'User-Agent': 'canvas-lms.js'
      method: verb
      url: baseUrl + path + http.querystring(query)

    qio.request(request)
      .then((_) -> _.body.read())
      .then((_) -> deferred.resolve(http.parse(_.toString())))
      .catch((_) -> deferred.reject(_))
      .done()

    deferred.promise

  withBodyJson: (verb) -> (path, json, query) ->
    deferred = q.defer()
    jsonString = JSON.stringify(json)
    request =
      agent: @agent
      charset: 'UTF-8'
      headers:
        'Authorization': 'Bearer ' + token
        'Content-Length': Buffer.byteLength(jsonString, 'utf8')
        'Content-Type': 'application/json'
        'User-Agent': 'canvas-lms.js'
      method: verb
      url: baseUrl + path + http.querystring(query)
      body: [jsonString]

    qio.request(request)
      .then((_) -> _.body.read())
      .then((_) -> deferred.resolve(http.parse(_.toString())))
      .catch((_) -> deferred.reject(_))
      .done()

    deferred.promise

module.exports = Object.freeze(httpClosure)
