import storage
export storage

type
    App* = ref object
        storage*: Storage


proc newApp*(): App =
    result.new
    result.storage = newStorage("localhost", 6379)

