package deputy.redis.request;

#if js
class General {

    public static function del(client:RedisClient, l:Iterable<RedisKey>) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.del(Lambda.array(l))) .next( _ -> Noise );

    public static function exists(client:RedisClient, l:Iterable<RedisKey>) : Promise<Int>
        return Promise.ofJsPromise(client.impl.exists(Lambda.array(l)));

    public static function quit(client:RedisClient) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.quit()).next( _ -> Noise );

}
#end
