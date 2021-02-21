package com.lightning.pinginator

import android.os.Process
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.ProcessBuilder.Redirect;
import java.sql.DriverManager.println
import java.util.concurrent.TimeUnit

class MainActivity: FlutterActivity() {
    private val CHANNEL="flutter.native/helper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler{
            call,result->
            if(call.method=="getPingTime"){
                val pingResult=getPingTime(call.arguments<String>())
                result.success(pingResult)
            }else{
                result.notImplemented()
            }
        }
    }

    fun getPingTime(domain:String): String {
        var output:String=""
        val process=ProcessBuilder("ping","-c 5",domain).start()
        process.inputStream.reader(Charsets.UTF_8).use {
            output+=it.readText()
        }

        return output
    }
}
