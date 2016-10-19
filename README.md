# Hubot JobScheduler sample script

## What?

This is [JobScheuler](http://www.sos-berlin.com/jobscheduler) collaboration hubot script.

## Supported hubot command

* hubot set url <JOC url e.g. http://hostname:4444>
    * This command should be executed at first.
    * URL is set on hubot brain
* hubot start job <Job name>
    * This command execute JobScheduler job
* hubot start jobchain <JobChain name>
    * This command execute JobScheduler JobChain
* hubot disable job <Job name> for <seconds>sec
    * Disable job. And enable job after xx seconds

## Supported JobScheduler version

* v.1.10

## How to use

```
$ npm install hubot-jobscheduler
$ vim external-scripts.json
[
    "hubot-xxxx",
    "hubot-yyyy",
    ....,
    "hubot-jobscheduler"
]
```


## Contact

Please send feedback to me.
Daisuke IKEDA

Twitter: [@ike_dai](https://twitter.com/ike_dai)
e-mail: <dai.ikd123@gmail.com>

## License

Licensed under the Apache License, Version 2.0. The Apache v2 full text is published at this [link](http://www.apache.org/licenses/LICENSE-2.0).

Copyright 2016 Daisuke IKEDA.
