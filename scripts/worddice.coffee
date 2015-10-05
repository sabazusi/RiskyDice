module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	{EventEmitter} = require 'events'
	emitter = new EventEmitter

	_adjective = {}
	_who = {}
	_what = {}
	_with = {}
	_do = {}

	_getJSON = (fileName, eventName) ->
		json = {}
		filePath = path.normalize __dirname + "/../resources/" + fileName
		fs.exists filePath, (exists) ->
			if exists
				fs.readFile filePath, 'utf8', (error, body) ->
					if body.length > 0
						emitter.emit eventName, JSON.parse body

	_getRandom = (data) ->
		data[Math.floor(Math.random() * data.length)]

	_make = () ->
		[
			_getRandom(_adjective),
			_getRandom(_who),
			_getRandom(_what),
			_getRandom(_with),
			_getRandom(_do)
		].join(" ")

	emitter.on "adjective_loaded", (jsonData) ->
		_adjective = jsonData["items"]
	emitter.on "who_loaded", (jsonData) ->
		_who = jsonData["items"]
	emitter.on "what_loaded", (jsonData) ->
		_what = jsonData["items"]
	emitter.on "with_loaded", (jsonData) ->
		_with = jsonData["items"]
	emitter.on "do_loaded", (jsonData) ->
		_do = jsonData["items"]

	_getJSON("adjective.json", "adjective_loaded")
	_getJSON("who.json", "who_loaded")
	_getJSON("what.json", "what_loaded")
	_getJSON("with.json", "with_loaded")
	_getJSON("do.json", "do_loaded")

	robot.hear /^(make)$/i, (msg) ->
		if _adjective.length > 0 && _who.length > 0 && _what.length > 0 && _with.length > 0 && _do.length > 0
			msg.send _make()
		else 
			msg.send "なにかおかしいよ"
