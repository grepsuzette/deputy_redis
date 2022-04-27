package deputy.redis.test;

using deputy.redis.request.General;
using deputy.redis.request.Hashes;

// please keep the same order for the tests
//  or it won't work
class TestHashes {
    var client : RedisClient;
    public function new() { client = null; }

    @:setup public function setup() 
        return deputy.redis.Redis.usable()
            .next(client -> this.client = client);

    public function first_cleanup_some_key()
       return client.del(['test']).next( _ -> client.exists(['test']).next( n -> assert(n == 0) )); 

    public function hexists_unknown() 
        return client.hexists('test_unknown45672891', 'foo').next( b -> assert(b == false) );

    public function hset1()
        return client.hset('test', 'pear', 'green').next( _ -> assert(true) );

    public function hset2()
        return client.hset('test', 'apple', 'red').next( _ -> assert(true) );

    public function hget1()
        return client.hget('test', 'pear').next( s -> assert(s == 'green') );

    public function hget2()
        return client.hget('test', 'apple').next( s -> assert(s == 'red') );

    public function hexists_unknown2() 
        return client.hexists('test', 'lemon').next( b -> assert(b == false) );

    public function hexists1() 
        return client.hexists('test', 'pear').next( b -> assert(b == true) );

    public function hmset()
        return client.hmset('test', [ 'lemon' => 'yellow' ]).next( _ -> assert(true) );

    public function hgetall()
        return client.hgetall('test')
            .next( h -> {
                assert(h['pear'] == "green"
                    && h['apple'] == "red"
                    && h['lemon'] == "yellow"
                );
            });

}
