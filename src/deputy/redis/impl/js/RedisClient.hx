package deputy.redis.impl.js;

private typedef Ok = String;  // Some function return a Promise<"OK">
private typedef JsPromise<T> = js.lib.Promise<T>;

// DOC https://luin.github.io/ioredis/classes/Redis.html#get
@:jsRequire("ioredis") @:require("js")
extern class RedisClient {
    // --- General -------
    function connect() : JsPromise<RedisClient>;
    function quit() : JsPromise<Ok>;
    function del(a:Array<RedisKey>) : JsPromise<Ok>;
    function exists(a:Array<RedisKey>) : JsPromise<Int>;

    // --- Strings -------
    function get(k:RedisKey) : JsPromise<RedisString>; 
    function set(k:RedisKey, v:RedisString) : JsPromise<Ok>;
    function mget(a:Array<RedisKey>) : JsPromise<Array<RedisString>>; 
    function mset(a:js.lib.Map<RedisKey, RedisString>) : JsPromise<Ok>; 

    // --- Hashes -------
    // function hgetall(k:RedisKey) : JsPromise<js.lib.Map<String, String>>;
    function hgetall(k:RedisKey) : JsPromise<{}>;
    function hget(k:RedisKey, field:RedisField) : JsPromise<RedisString>;
    function hexists(k:RedisKey, field:RedisField) : JsPromise<Int>;
    function hdel(k:RedisKey, field:RedisField) : JsPromise<Int>;

    @:overload(function(k:RedisKey, h:String, v:String) : JsPromise<Ok> {})
    function hset(k:RedisKey, h:js.lib.Map<String, String>) : JsPromise<Ok>;

}

