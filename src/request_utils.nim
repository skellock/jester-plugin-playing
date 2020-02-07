import strutils
import jester

proc isPost*(req: Request): bool =
    ## Is this request an HTTP Post method?
    req.reqMethod == HttpPost


proc isContentTypeJson*(req: Request): bool =
    ## Is this request's content type json?
    const key = "content-type"
    const value = "application/json"

    if not req.headers.hasKey(key):
        return false

    let contentType = req.headers.getOrDefault(key)

    if contentType.len <= 0:
        return false

    contentType.toLowerAscii == value

