jobscheduler = require('jobscheduler');

module.exports = (robot) ->
  robot.respond /set url (\S*)/i, (msg) ->
    robot.brain.set 'js_url', msg.match[1]
    msg.send "Set JobScheduler URL #{msg.match[1]}"
  robot.respond /start job (\S*)/i, (msg) ->
    jobname = msg.match[1]
    msg.send "Starting #{jobname}"
    js_url = robot.brain.get 'js_url'
    client = new jobscheduler({url: js_url});
    client.job.start {job: jobname},(err, res, result)->
      if result.answer.ok
        msg.send "OK: start job #{jobname}"
      else
        msg.send "Error: #{result.answer.ERROR.$.text}"
  robot.respond /start jobchain (\S*)/i, (msg) ->
    jobchainname = msg.match[1]
    msg.send "Starting #{jobchainname}"
    js_url = robot.brain.get 'js_url'
    client = new jobscheduler({url: js_url});
    client.jobchain.start {jobchain: jobchainname},(err, res, result)->
      if result.answer.ok
        msg.send "OK: start jobchain #{jobchainname}"
      else
        msg.send "Error: #{result.answer.ERROR.$.text}"

