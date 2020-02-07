# Playing with Jester

[Jester](https://github.com/dom96/jester) is an http server framework for nim. It's extremely barebones.

There was a [guy](https://github.com/JohnAD) trying to get a [plugin system](https://github.com/dom96/jester/pull/227) into it, so he [forked it](https://github.com/JohnAD/jester). I wanted to try what he did.

# Dependencies

- `nim` to compile (using 1.0.6 installed via choosenim)
- `siege` to benchmark (`brew install siege`)
- `redis` as a server (`brew install redis`)
- `just` to run some scripts (`brew install just`)
- `fd` for finding files (`brew install fd`)
- `entr` for watching files and rerunning scripts (`brew install entr`)
- `curl` for hitting pages (already installed)

# How to run

Build and run:

```sh
nimble install
just release
```

Then make sure `redis-server` is running.

And use `redis-cli` to `set steve hello` which will "seed" the "database". :7

To run the app:

```sh
bin/jesterplugins
```

# Results

I'm very impressed with what I'm seeing.

Computer specs:

- MBP MacBook Pro (13-inch, 2018, Four Thunderbolt 3 Ports)
- 2.7 GHz Quad-Core Intel Core i7
- 16 GB 2133 MHz LPDDR3
- 10.15.3

Single threaded, read speeds when fetching 1 key from `redis`:

```
❯ just bench                                                                                        0.012s
** SIEGE 4.0.4
** Preparing 8 concurrent users for battle.
The server is now under siege...

Transactions:                   8000 hits
Availability:                 100.00 %
Elapsed time:                   0.89 secs
Data transferred:               0.52 MB
Response time:                  0.00 secs
Transaction rate:            8988.76 trans/sec
Throughput:                     0.58 MB/sec
Concurrency:                    7.79
Successful transactions:        8000
Failed transactions:               0
Longest transaction:            0.01
Shortest transaction:           0.00

```

Single threaded, writes to `redis` are hitting 5,000 transactions per second. Wild!

```
❯ just bench-status-write                                                                           0.813s

** SIEGE 4.0.4
** Preparing 8 concurrent users for battle.
The server is now under siege...

Transactions:                   8000 hits
Availability:                 100.00 %
Elapsed time:                   1.58 secs
Data transferred:               0.12 MB
Response time:                  0.00 secs
Transaction rate:            5063.29 trans/sec
Throughput:                     0.08 MB/sec
Concurrency:                    7.82
Successful transactions:        8000
Failed transactions:               0
Longest transaction:            0.23
Shortest transaction:           0.00
```

CPU load is around 50% under load. Redis hits 100%.
Memory spikes to 8.5 MB! Then settles back to 7.4 MB. I cannot believe this. Amazing.

# Code

I like the idea of plugins. I'm not too sold on the API design, but it is def working. I had a few issues with all the macro stuff and the error messages, but ultimately figured it out.

I've never used an `export` command in `nim` before, so that took getting used to.

I tried the `subrouter` command, and really didn't care for it. I can see how it might be useful in a larger app though.
