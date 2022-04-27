package deputy.redis.request;

#if js
class Strings {

    public static function get(client:RedisClient, k:RedisKey) : Promise<RedisString>
        return Promise.ofJsPromise(client.impl.get(k));

    public static function set(client:RedisClient, k:RedisKey, v:RedisString) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.set(k, v)).next( _ -> Noise );

    /* Set key to hold the string value and set key to timeout after a given number of seconds. */
    public static function setex(client:RedisClient, k:RedisKey, seconds:Int, v:RedisString) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.setex(k, seconds, v)).next( _ -> Noise );

    public static function mget(client:RedisClient, aIn:Iterable<RedisKey>) : Promise<List<Duet<RedisKey, RedisString>>> {
        var a : Array<RedisKey> = Lambda.array(aIn);
        return Promise.ofJsPromise(client.impl.mget(a))
            .next(aRet -> 
                if (aRet.length != a.length) Failure(new Error(Conflict, 'Redis.mget mismatch ${aRet.length} != ${a.length}'))
                else Success(tink.pure.List.fromArray([ for (i in 0...a.length) new Duet(a[i], aRet[i]) ]))
            );
    }

    public static function mset(client:RedisClient, l:Iterable<Duet<RedisKey, RedisString>>) : Promise<Noise> 
        return Promise.ofJsPromise(client.impl.mset(new js.lib.Map([ for (dd in l) [dd.a, dd.b ] ])))
            .next( _ -> Noise );

}
#end
