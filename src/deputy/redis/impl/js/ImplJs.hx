package deputy.redis.impl.js;

import deputy.redis.impl.js.RedisClient as ImplRedisClient;

@:jsRequire("ioredis")
@:require("js")
@:final
extern class ImplJs {

    public static inline function ready(opts:{}) : js.lib.Promise<ImplRedisClient> {
        var impl: ImplRedisClient = js.Syntax.code("require")("ioredis").createClient(opts);
        return impl.connect().then(_ -> impl, reason -> reason);
    }

    public static inline function usable(opts:{}) : tink.core.Promise<ImplRedisClient>
        return tink.core.Promise.ofJsPromise(ready(opts));
}

