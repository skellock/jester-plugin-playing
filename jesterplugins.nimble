version = "0.1.0"
author = "Steve Kellock"
description = "A new awesome nimble package"
license = "MIT"
srcDir = "src"
bin = @["jesterplugins"]
binDir = "bin"

requires "nim >= 1.0.6"
requires "https://github.com/JohnAD/jester#00418d8d68304dc4fa3afeeb99309ee513bbb1cb"
requires "redis >= 0.3.0"

