canvas = require('./canvas-lms')
should = require('should')

describe('client', -> it('should be exported', -> canvas.hasOwnProperty('client').should.be.true))
describe('encode', -> it('should not be exported', -> canvas.hasOwnProperty('encode').should.be.false))
describe('http', -> it('should be exported', -> canvas.hasOwnProperty('http').should.be.true))
