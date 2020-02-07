import asyncdispatch, strutils, json # stdlib
import jester # 3rd party
import sample_plugin, storage # our app

type
    User = object
        name: string
        age: int

    AdminResponse = object
        sample: string
        status: string
        user: User
        moarUsers: seq[User]

proc buildAdminResponse*(sample: Sample, storage: Storage): AdminResponse =
    result.status = storage.status
    result.sample = sample.sayHello
    result.user.name = "Steve"
    result.user.age = 69


proc adminIndexPage*(request: Request, sample: Sample): ResponseData =
    block route:
        let more = sample.sayHello
        let s = request.params.getOrDefault("s", "100")
        resp "<h4>admin home page - $1</h4> - $2" % [more, s]


proc adminJsonPage*(request: Request, sample: Sample, storage: Storage): ResponseData =
    block route:
        resp %*(buildAdminResponse(sample, storage))


proc adminPostPage*(request: Request, sample: Sample): ResponseData =
    block route:
        try:
            let body = parseJson(request.body)

            resp %*{
                "omg_parsed": body,
            }
        except:
            resp %*{"you": "suck"}
