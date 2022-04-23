package deputy.redis.impl.js;

import deputy.redis.impl.js.RedisClient;

@:jsRequire("ioredis")
@:require("js")
@:final
extern class ImplJs {

    public static inline function ready(opts:{}) : js.lib.Promise<RedisClient> {
        var client : RedisClient = js.Syntax.code("require")("ioredis").createClient(opts);
        return client.connect().then(_ -> client, reason -> reason);
    }

    public static inline function usable(opts:{}) : tink.core.Promise<RedisClient>
        return tink.core.Promise.ofJsPromise(ready(opts));
}

