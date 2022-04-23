package deputy.redis;

import tink.core.Pair as Duet;

#if js

// DOC https://luin.github.io/ioredis/classes/Redis.html#get
class RedisClient {

    var client : deputy.redis.impl.js.RedisClient;

    public function new(client:deputy.redis.impl.js.RedisClient) {
        this.client = client;
    }

    public function get(k:RedisKey) : Promise<RedisString>
        return Promise.fromJsPromise(client.get(k));

    public function set(k:RedisKey, v:RedisString) : Promise<Noise>
        return Promise.fromJsPromise(client.set(k, v)).next( _ -> Noise );

    public function mget(aIn:Iterable<RedisKey>) : Promise<List<Duet<RedisKey, RedisString>>> {
        var a : Array<RedisKey> = Lambda.array(aIn);
        return Promise.fromJsPromise(client.mget(a))
            .next(aRet -> 
                if (aRet.length != a.length) Failure(new Error(Conflict, 'Redis.mget mismatch ${aRet.length} != ${a.length}'))
                else Success(tink.pure.List.fromArray([ for (i in 0...a.length) new Duet(a[i], aRet[i]) ]))
            );
    }

    public function mset(l:Iterable<Duet<RedisKey, RedisString>>) : Promise<Noise> 
        return Promise.fromJsPromise(client.mset(new js.lib.Map([ for (dd in l) [dd.a, dd.b ] ])))
            .next( _ -> Noise );

    public function del(l:Iterable<RedisKey>) : Promise<Noise>
        return Promise.fromJsPromise(client.del(Lambda.array(l))) .next( _ -> Noise );

    public function exists(l:Iterable<RedisKey>) : Promise<Int>
        return Promise.fromJsPromise(client.exists(Lambda.array(l)));

    public function quit() : Promise<Noise>
        return Promise.fromJsPromise(client.quit()).next( _ -> Noise );

}
#end
