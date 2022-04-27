package deputy.redis.test;

import deputy.redis.Redis;
import deputy.redis.test.*;

class Main {

    // kept for debugging:

    // public static function main() {
    //     var old = haxe.Log.trace;
    //     haxe.Log.trace = @:privateAccess haxe.unit.TestRunner.customTrace;

    //     var client : deputy.redis.impl.js.RedisClient = js.Syntax.code("require")("ioredis").createClient({
    //         enableAutoPipelining : true,
    //         enableOfflineQueue   : false,
    //         lazyConnect          : true
    //     });
    //     client.connect().then(_ -> {
    //         trace("connected");
    //         do_tests(new deputy.redis.RedisClient(client));
    //     }, reason -> trace("FAILED I THINK " + reason));
    // }

    public static function main() {
        Runner.run(TestBatch.make([
            new TestStrings(),
            new TestHashes(),
        ])).handle(Runner.exit);
    }

}
