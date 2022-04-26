package deputy.redis;

typedef Impl = 
    #if js deputy.redis.impl.js.RedisClient
    #else #error "platform not supported yet"
    #end

/** 
 * DOC https://luin.github.io/ioredis/classes/Redis.html#get
 * Methods are regrouped by family (sets, strings, hashes etc).
 * Use static extension upon the choosen classes in the deputy.redis.request package.
 */
@:allow(deputy.redis.request)
class RedisClient {
    var impl : Impl;
    public function new(impl:Impl) this.impl = impl;
}
