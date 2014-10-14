clientClosure = require('../../lib/client')
lazy = require('lazy.js')
should = require('should')

client = clientClosure(process.env.CANVASLMSJS_BASEURL, process.env.CANVASLMSJS_TOKEN)
random = -> lazy.generate((-> Math.floor(Math.random() * 10))).take(32).toString('')

describe 'client.withSession()', ->
  it 'should work', (done) ->
    client.withSession((session) ->
      session.getAccounts()
        .then((_) -> _.fold(
          (l) -> should.fail(l)
          (r) -> r.length.should.be.above(0)
        )).done(-> done())
    )

  it 'should work', (done) ->
    create =
      user: name: 'client create'
      pseudonym: unique_id: random() + '@example.com'
    update = user: name: 'client update'

    client.withSession((session) ->
      session.postUser(1, create)
        .then((_) -> _.fold((-> -1), ((r) -> r.id)))
        .then((id) -> session.putUser(id, update); id)
        .then((id) -> session.deleteUser({account_id: 1, user_id: id}))
        .done(-> done())
    )

  it 'should work', (done) ->
    client.withSession((session) ->
      session.getUserLogins('self')
        .done(-> done())
    )
