package deputy.redis.request;

#if js
class Hashes {
    /*
    ### full list of hash commands 
    From https://redis.io/commands/?group=hash
    Most will be a poor match for Haxe because of the need to use reflection
    -------------------------------------------
    HDEL key field [field ...]
    HGET key field :: get the value of a hash field
    HSET key field value [..]
    HEXISTS key field
    HKEYS key :: get all fields in a hash
    HLEN key :: number of fields in a hash
    HGETALL key
    HINCRBY key field incr
    HINCRBYFLOAT key field incr
    HMGET key field [field ..]
    HMSET key field value..
    HRANDFIELD key [ count ] :: get one or multiple random fields from a hash
    HSCAN key cursor [ Matchpattern ] :: incrementally iterate hash fields and associated values
    HSETNX key field value :: set only if the field doesnt exist
    HSTRLEN key field :: length of value of a field
    HVALS key :: all values in a hash
    */

    public static function hget(client:RedisClient, k:RedisKey, field:RedisField) : Promise<RedisString>
        return Promise.ofJsPromise(client.impl.hget(k, field));

    /** 
     * Sets the specified fields to their respective values 
     * in the hash stored at key. This command overwrites any 
     * specified fields already existing in the hash. If key 
     * does not exist, a new key holding a hash is created.
     */
    public static function hmset(client:RedisClient, k:RedisKey, h:Map<String, String>) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.hset(k, new js.lib.Map([ for (key => v in h) [key, v] ])))
            .next( _ -> Noise );

    public static function hset(client:RedisClient, k:RedisKey, field:RedisField, v:RedisString) : Promise<Noise>
        return Promise.ofJsPromise(client.impl.hset(k, field, v))
            .next( _ -> Noise );

    /**
     * Returns all fields and values of the hash stored at key.
     * This unfortunately has to use Reflect.
     */
    public static function hgetall(client:RedisClient, k:RedisKey) : Promise<Map<String, String>>
        return Promise.ofJsPromise(client.impl.hgetall(k))
            .next( ret -> [ for (field in Reflect.fields(ret)) field => ( Reflect.field(ret, field) : String ) ] );

    /**
     * @return (Bool) whether key exists && field is an existing field in the hash stored at key.
     */
    public static function hexists(client:RedisClient, k:RedisKey, field:RedisField) : Promise<Bool> 
        return Promise.ofJsPromise(client.impl.hexists(k, field))
            .next( (n:Int) -> n > 0 );

    /** @return (Bool) True if any field was removed.
     * Removes the specified fields from the hash stored at key. 
     * Specified fields that do not exist within this hash are ignored.
     */
    public static function hdel(client:RedisClient, k:RedisKey, field:RedisField) : Promise<Bool> 
        return Promise.ofJsPromise(client.impl.hdel(k, field))
            .next( (n:Int) -> n > 0 );

}
#end

