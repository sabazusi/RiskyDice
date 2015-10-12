cron = require('cron').CronJob
module.exports = (robot) ->
  url = process.env.HUBOT_URL
  robot.enter ->
  new cron
    cronTime: "*/10 * * * *"
    start: true
    onTick: ->
      robot.http(url + "/hubot/version")
        .get() (err, res, body) ->
          return
