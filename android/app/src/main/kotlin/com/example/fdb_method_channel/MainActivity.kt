
package com.example.fdb_method_channel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.random.Random
import android.graphics.Color


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "fdb-example").setMethodCallHandler {
                call, result ->
            if(call.method == "getRandomNumber") {
                val rand = Random.nextInt(100)
                result.success(rand)
            }
            else if(call.method=="getRandomColor"){

                    val red = Random.nextInt(256)
                    val green = Random.nextInt(256)
                    val blue = Random.nextInt(256)
                var colorResult=Color.rgb(red, green, blue)
                    result.success(colorResult)
                }

            else {
                result.notImplemented()
            }
        }

    }
}