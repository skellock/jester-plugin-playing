import strutils, re # stdlib
import jester # 3rd party
import app as _ # re-aliasing because i want to create an app variable
import sample_plugin, json_content_type_plugin # our plugins
import status_page, home_page, admin_pages # our pages

var app = newApp()

routes:
    plugin _ <-
        # checks if it is a POST and the content-type is application/json
        newJsonPostsOnlyPlugin()

    plugin sample <-
        # just playing around creating a plugin
        newSamplePlugin("Steve")

    get "/admin":
        # how to read from redis and create a JSON payload that comes from an object
        return adminJsonPage(request, sample, app.storage)

    post "/admin":
        # how to parse inbound JSON
        return adminPostPage(request, sample)

    get "/":
        # returning html
        return homePage(request, sample)

    get "/wait":
        # testing a slow async page
        return await slowPage(request)

    get "/status":
        # reads from redis
        return readStatusPage(request, app.storage)

    post "/status":
        # writes to redis
        return writeStatusPage(request, app.storage)

    get re".*":
        # the fallback
        resp "fallback"
