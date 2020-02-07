import strutils, json
import jester
import storage

proc readStatusPage*(request: Request, storage: Storage): ResponseData =
    block route:
        resp "<h1>Welcome to the Home Page</h1><h3>status is $1</h3>" % [storage.status]

proc writeStatusPage*(request: Request, storage: Storage): ResponseData =
    block route:
        let body = parseJson(request.body)
        let status = body["status"].getStr()
        storage.setStatus status
        resp status
