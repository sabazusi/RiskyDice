module.exports = (robot) ->
	fs = require('fs')
	path = require('path')
	filePath = path.normalize(__dirname + "/../resources/who.json")

	fs.readFile filePath, 'utf8', (error, data) ->
		console.log data

