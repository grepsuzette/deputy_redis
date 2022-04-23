ioredis v5 minimal bindings for [Haxe](https://haxe.org) (current target: node)
with [tink_core](https://haxe.org/haxetink/tink_core) promises

a totally minimal version with just the in-memory key-value for now

See API, in case you need to bind more functions, 
at https://luin.github.io/ioredis/classes/Redis.html

# Prerequisite

To install you *should* use [lix](https://github.com/lix-pm/lix). Then:

    lix install github:grepsuzette/deputy_redis
    npm install ioredis

# Example

This kind of stupid example doesn't give justice to tink.
It can help you out though. Also see the unit tests.

```haxe
import deputy.redis.Redis;
import deputy.redis.RedisClient;
import js.Browser.alert;
using tink.CoreApis;

Redis.usable()                              // connects. 
     .handle( run );     

function run(out:Outcome<RedisClient, Error>) {
    switch out {
        case Failure(err): 
            alert(err.toString());
        case Success(client): 
            client.set("hello", "world");   // return a tink.Promise, which we don't handle

            client.mset([ 
                new Pair("current_city", "NY"), 
                new Pair("current_month", "April") 
            ]).handle(_ -> console.log("done"));

            client.mget(["cats", "dogs"])
                  .handle(out -> switch out {
                        case Success(pairs):
                            for (pair in pairs) {
                                console.log('There are ${pair.b} ${pair.a}');
                            }
                        case Failure(e):
                            console.error(e.toString());
                  });
    }
}
```
