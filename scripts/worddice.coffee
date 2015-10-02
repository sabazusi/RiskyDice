module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	{EventEmitter} = require 'events'
	emitter = new EventEmitter

	who = {}

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

	getJson("who.json", "who_loaded")

	robot.respond /hoge/, (msg) ->
		console.log who
