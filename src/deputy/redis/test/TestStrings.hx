package deputy.redis.test;

using deputy.redis.request.General;
using deputy.redis.request.Strings;

class TestStrings {
    var client : RedisClient;
    public function new() { client = null; }

    @:setup public function setup() 
        return deputy.redis.Redis.usable()
            .next(client -> this.client = client);

    public function set() 
        return client.set("test", "aa").next( _ -> assert(true) );

    public function get()
        return client.get("test").next( s -> assert(s == "aa") );

    public function mset()
        return client.mset([new tink.Pair("test1", "alpha"), new tink.Pair("test2", "beta")])
            .next( _ -> assert(true) );

    public function mget_empty() 
        return client.mget([]).next( l -> assert(l.length == 0 ));

    public function mget() 
        return client.mget(["test1", "test2"])
            .next( l -> {
                var a = l.toArray();
                assert(a[0].a == "test1"
                    && a[1].a == "test2"
                    && a[0].b == "alpha"
                    && a[1].b == "beta"
                );
            });

    public function mget_repeatedentry() 
        return client.mget(["test1", "test2", "test1"])
            .next( l -> {
                var a = l.toArray();
                assert(a[0].a == "test1"
                    && a[1].a == "test2"
                    && a[0].b == "alpha"
                    && a[1].b == "beta"
                );
            });

    public function mget_inexistant() 
        return client.mget(["test_a945294359234952"])
            .next( l -> {
                var a = l.toArray();
                assert(a[0].b == null);
            });

    public function exists_before_del() 
        return client.exists(["test1", "test2", "fjijaifjiwjfe"])
            .next( n -> assert(n == 2) );

    public function del() 
        return client.del(["test1", "test2"])
            .next( _ -> assert(true) );

    public function exists_after_del() 
        return client.exists(["test1", "test2", "fjijaifjiwjfe"])
            .next( n -> assert(n == 0) );

    public function setex() {
        var trig = Promise.trigger();
        client.setex('test', 1, 'bar');
        Future.delay( 
            1200, 
            function() { 
                client.exists(['test']).handle(
                    function (out) {
                        switch out {
                            case Success(n): trig.trigger(Success(assert(n == 0)));
                            case Failure(_): trig.trigger(Success(assert(false)));
                        }
                    }
                );
            }
        );
        return trig;
    }

}
