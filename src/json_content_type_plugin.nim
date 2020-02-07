import jester
import request_utils


proc newJsonPostsOnlyPlugin*(req: Request, res: var ResponseData): string =
    ## A plugin to verify all posts are JSON.
    if not req.isPost:
        return

    if req.isContentTypeJson:
        return

    res.action = TCActionSend
    res.matched = true
    res.code = Http400
    res.content = ""
    res.completed = true

