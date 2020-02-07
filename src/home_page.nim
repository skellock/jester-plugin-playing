import strutils, asyncdispatch
import jester
import sample_plugin

proc homePage*(request: Request, sample: Sample): ResponseData =
    block route:
        resp "<h1>Welcome to the Home Page</h1><h1>$1</h1>" % [sample.sayHello]

proc slowPage*(request: Request): Future[ResponseData] {.async.} =
    block route:
        await sleepAsync(1000)
        resp "<h1>Sorry For Waiting</h1>"

