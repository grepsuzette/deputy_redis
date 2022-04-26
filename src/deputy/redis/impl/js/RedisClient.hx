package deputy.redis.impl.js;

private typedef Ok = String;  // Some function return a Promise<"OK">
private typedef JsPromise<T> = js.lib.Promise<T>;

// DOC https://luin.github.io/ioredis/classes/Redis.html#get
@:jsRequire("ioredis") @:require("js")
extern class RedisClient {
    function connect() : JsPromise<RedisClient>;
    function quit() : JsPromise<Ok>;

    /** @name Strings @{ {{{ **/
        function get(k:RedisKey) : JsPromise<RedisString>; 
        function set(k:RedisKey, v:RedisString) : JsPromise<Ok>;

        function mget(a:Array<RedisKey>) : JsPromise<Array<RedisString>>; 
        function mset(a:js.lib.Map<RedisKey, RedisString>) : JsPromise<Ok>; 

        function del(a:Array<RedisKey>) : JsPromise<Ok>;
        function exists(a:Array<RedisKey>) : JsPromise<Int>;
    /** @} }}} **/

    /** @name hashes @{ {{{ **/
        function hgetall(k:RedisKey) : JsPromise<js.lib.Map<String, String>>;
        function hset(k:RedisKey, h:js.lib.Map<String, String>) : JsPromise<Ok>;
    /** @} }}} **/
}

