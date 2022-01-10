package com.example.infobip_plugin.infobip_plugin.utils

import android.os.Handler
import android.os.Looper
import android.util.Log
import com.example.infobip_plugin.infobip_plugin.InfobipPlugin
import io.flutter.plugin.common.MethodChannel
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.io.IOException

class ApiManager {

    companion object {
        fun fetchToken(
            identity: String,
            displayName: String,
            applicationId: String,
            baseUrl: String,
            appKey: String,
            callBack: ReturnTokenCallBack
        ) {
            val callToken = ""
            val jObject = JSONObject()
            try {
                jObject.put("identity", identity)
                jObject.put("displayName", displayName)
                jObject.put(
                    "applicationId",
                    applicationId
                )
            } catch (e: Exception) {

            }
            val mediaType = "application/json; charset=utf-8".toMediaType()
            val body = jObject.toString().toRequestBody(mediaType)

            val request = Request.Builder()
                .url("$baseUrl/webrtc/1/token")
                .addHeader(
                    "Authorization",
                    "App $appKey"
                )
                .addHeader("Content-Type", "application/json")
                .addHeader("Accept", "application/json")
                .post(body)
                .build()

            val client = OkHttpClient()

            client.newCall(request).enqueue(object : Callback {
                override fun onFailure(call: Call, e: IOException) {
                    Log.d("MAIN ACT", "onFailure:e -> $e")
                }

                override fun onResponse(call: Call, response: Response) {
                    try {
                        val resStr = response.body!!.string()
                        Log.d("MAIN_ACT", "onResponse: $resStr")
                        val json = JSONObject(resStr)
                        val token = json.getString("token")
                        val expirationTime = json.getString("expirationTime")
                        callBack.returnToken(token)
                        Log.e(InfobipPlugin.TAG, "onResponse: callToken -> $callToken")
                    } catch (e: Exception) {
                        Log.e("MAIN ACT", "onResponse:11 ${e.toString()}")
                    }
                }
            })
        }
    }
}

interface ReturnTokenCallBack {
    fun returnToken(token: String)
}