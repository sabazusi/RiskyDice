module.exports = (robot) ->
	robot.hear /^(お題)$/i, (msg) ->
		msg.send "お題です"
