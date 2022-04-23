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
     */
    public static inline function usable(opts:{}=null) : tink.core.Promise<RedisClient> {
        #if js
        final DEFAULTOPTS = {
            enableAutoPipelining : true,
            enableOfflineQueue   : false,
            lazyConnect          : true
        }
        return deputy.redis.impl.js.ImplJs.usable(opts == null ? DEFAULTOPTS : opts)
            .next(x -> new RedisClient(x));
        #else
        #error "unsupported target (for now)"
        #end
    }

}
