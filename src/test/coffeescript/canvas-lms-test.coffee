canvas = require('./canvas-lms')
should = require('should')

describe('client', -> it('should be exported', -> canvas.hasOwnProperty('client').should.be.true))
