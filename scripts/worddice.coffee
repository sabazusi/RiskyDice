module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	{EventEmitter} = require 'events'
	emitter = new EventEmitter

	_who = {}
	_what = {}
	_with = {}

	_getJSON = (fileName, eventName) ->
		json = {}
		filePath = path.normalize __dirname + "/../resources/" + fileName
		fs.exists filePath, (exists) ->
			if exists
				fs.readFile filePath, 'utf8', (error, body) ->
					if body.length > 0
						emitter.emit eventName, JSON.parse body

	_make = () ->
		"hoge"


	emitter.on "who_loaded", (jsonData) ->
		_who = jsonData
	emitter.on "what_loaded", (jsonData) ->
		_what = jsonData
	emitter.on "with_loaded", (jsonData) ->
		_with = jsonData

	_getJSON("who.json", "who_loaded")
	_getJSON("what.json", "what_loaded")
	_getJSON("with.json", "with_loaded")

	robot.hear /^(make)$/i, (msg) ->
		msg.send _make()
