module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	who = {}

	getJson = (fileName) ->
		json = {}
		filePath = path.normalize __dirname + "/../resources/" + fileName
		fs.exists filePath, (exists) ->
			if exists
				fs.readFile filePath, 'utf8', (error, body) ->
					if body.length > 0
						JSON.parse body


	who = getJson("who.json")

	robot.respond /hoge/, (msg) ->
		console.log who
