import net, strutils
import jester, redis

type
    Storage* = ref object
        client*: Redis
        namespace*: string

const statusKey = "status"

proc status*(storage: Storage): string =
    storage.client.get(statusKey)

proc setStatus*(storage: Storage, value: string) =
    storage.client.setk(statusKey, value)

proc newStorage*(host: string, port: int): Storage =
    result.new
    result.client = redis.open(host, port.Port)
    echo "storage coming to life with value of `$1`" % [result.status()]
