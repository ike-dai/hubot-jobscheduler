# Description
#  This is JobScheuler collaboration hubot script.
# 
# Dependencies:
#  "jobscheduler": "0.0.1"
#
# Configuration:
#  None
#
# Commands:
#  hubot set url <JOC url e.g. http://hostname:4444> - set JOC url for operating JobScheduler API
#  hubot start job <Job name> - start job immediately
#  hubot start jobchain <JobChain name> - start jobchain immediately
#  hubot disable job <Job name> for <seconds>sec - disable job. And enable job after xx seconds
#
# Author:
#  ike-dai(Daisuke Ikeda)

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
  robot.respond /disable job (\S*) for (\S*)sec/i, (msg) ->
    jobname = msg.match[1]
    mili_time = msg.match[2]
    time = mili_time * 1000
    msg.send "Disable #{jobname} #{time}"
    js_url = robot.brain.get 'js_url'
    client = new jobscheduler({url: js_url});
    client.job.stop {job: jobname},(err, res, result)->
      if result.answer.ok isnt undefined
        msg.send "OK: disbled job #{jobname}"
        setTimeout ->
          client.job.unstop {job: jobname},(err, res, result)->
            if result.answer.ok isnt undefined
              msg.send "OK: enable job #{jobname}"
            else
              msg.send "Error: #{result.answer.ERROR.$.text}"
        ,time

      else
        msg.send "Error: #{result.answer.ERROR.$.text}"

