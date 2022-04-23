package deputy.redis.impl.js;

private typedef Ok = String;  // Some function return a Promise<"OK">
private typedef JsPromise<T> = js.lib.Promise<T>;

// DOC https://luin.github.io/ioredis/classes/Redis.html#get
@:jsRequire("ioredis") @:require("js")
extern class RedisClient {
    public function connect() : JsPromise<RedisClient>;
    public function quit() : JsPromise<Ok>;

    public function get(k:RedisKey) : JsPromise<RedisString>; 
    public function set(k:RedisKey, v:RedisString) : JsPromise<Ok>;

    public function mget(a:Array<RedisKey>) : JsPromise<Array<RedisString>>; 
    public function mset(a:js.lib.Map<RedisKey, RedisString>) : JsPromise<Ok>; 

    public function del(a:Array<RedisKey>) : JsPromise<Ok>;
    public function exists(a:Array<RedisKey>) : JsPromise<Int>;
}

