httpClosure = require('./http')
lazy = require('lazy.js')
should = require('should')

http = httpClosure(process.env.CANVASLMSJS_BASEURL, process.env.CANVASLMSJS_TOKEN)
random = -> lazy.generate((-> Math.floor(Math.random() * 10))).take(32).toString('')

describe 'http.delete()', ->

	it 'should work with a single record', (done) ->
		create =
			user: name: 'http create'
			pseudonym: unique_id: random() + '@example.com'

		http.post(((i) -> "/api/v1/accounts/#{ i }/users"), 1, create)
			.then((_) ->
				id = _.fold(
					(l) -> -1
					(r) -> r.id
				)

				http.delete(((i) -> "/api/v1/accounts/#{ i.account_id }/users/#{ i.id }"), {account_id: 1, id: id})
			).then((_) -> _.fold(
				(l) -> should.fail(l)
				(r) -> r.id.should.be.above(0)
			)).done(-> done())

describe 'http.get()', ->

	it 'should work with multiple records', (done) ->
		http.get(-> "/api/v1/accounts")
			.then((_) -> _.fold(
				(l) -> should.fail(l)
				(r) -> r[0].id.should.be.above(0)
			)).done(-> done())

	it 'should work with a single record', (done) ->
		http.get(((i) -> "/api/v1/accounts/#{ i.id }"), id: 1)
			.then((_) -> _.fold(
				(l) -> should.fail(l)
				(r) -> r.id.should.be.above(0)
			)).done(-> done())

describe 'http.post()', ->

	it 'should work with a single record', (done) ->
		create =
			user: name: 'http create'
			pseudonym: unique_id: random() + '@example.com'

		http.post(((i) -> "/api/v1/accounts/#{ i }/users"), 1, create)
			.then((_) -> _.fold(
				(l) -> should.fail(l)
				(r) -> r.id.should.be.above(0)
			)).done(-> done())

describe 'http.put()', ->

	it 'should work with a single record', (done) ->
		create =
			user: name: 'http create'
			pseudonym: unique_id: random() + '@example.com'
		update = user: name: 'http update'

		http.post(((i) -> "/api/v1/accounts/#{ i }/users"), 1, create)
			.then((_) ->
				id = _.fold(
					(l) -> -1
					(r) -> r.id
				)

				http.put(((i) -> "/api/v1/users/#{ i }"), id, update)
			).then((_) -> _.fold(
				(l) -> should.fail(l)
				(r) -> r.name.should.equal('http update')
			)).done(-> done())
