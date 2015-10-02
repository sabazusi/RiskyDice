module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	{EventEmitter} = require 'events'
	emitter = new EventEmitter

	who = {}
	what = {}

	getJson = (fileName, eventName) ->
		json = {}
		filePath = path.normalize __dirname + "/../resources/" + fileName
		fs.exists filePath, (exists) ->
			if exists
				fs.readFile filePath, 'utf8', (error, body) ->
					if body.length > 0
						emitter.emit eventName, JSON.parse body


	emitter.on "who_loaded", (jsonData) ->
		who = jsonData
	emitter.on "what_loaded", (jsonData) ->
		what = jsonData

	getJson("who.json", "who_loaded")
	getJson("what.json", "what_loaded")

	robot.respond /hoge/, (msg) ->
		console.log who
