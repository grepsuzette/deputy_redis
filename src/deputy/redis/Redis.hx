package deputy.redis;

import deputy.redis.RedisClient;

/**
 * Contains Redis.init() function.
 * This takes a callback called when it's ready.
 */
class Redis {
    /**
     * @note The defaults set when opts is null have proven to work in our case.
     * See https://github.com/luin/ioredis/issues/1123
     * @param (opts) There is no formalization yet for the options. 
     * But for js, try these:
     *   https://luin.github.io/ioredis/interfaces/CommonRedisOptions.html
     *   https://luin.github.io/ioredis/interfaces/SentinelConnectionOptions.html
     *   - connectTimeout: Int
     *   - disconnectTimeout: Int
     *   - commandTimeout: Int         If a command does not return a reply 
     *                                  within a set number of milliseconds,
     *                                  a "Command timed out" error will be thrown.
     */
    public static inline function usable(opts:{}=null) : tink.core.Promise<RedisClient> {
        #if js
        final DEFAULTOPTS = {
            enableAutoPipelining : true,
            enableOfflineQueue   : false,
            lazyConnect          : true
        }
        // in js, enableAutoPipelining, enableOfflineQueue, lazyConnect are
        // always needed, thus if not overriden we use the defaults
        var o = {}
        for (field in Reflect.fields(DEFAULTOPTS)) Reflect.setField(o, field, Reflect.field(DEFAULTOPTS, field));
        if (opts != null) {
            for (field in Reflect.fields(opts))
                Reflect.setField(o, field, Reflect.field(opts, field));
        }
        return deputy.redis.impl.js.ImplJs.usable(o)
            .next(x -> new RedisClient(x));
        #else
        #error "unsupported target (for now)"
        #end
    }

}
