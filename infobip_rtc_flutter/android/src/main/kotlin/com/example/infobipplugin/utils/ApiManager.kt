package com.example.infobipplugin.utils

import android.util.Log
import com.example.infobipplugin.InfobippluginPlugin
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
                callBack.returnToken("Error - $e")
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
                    callBack.returnToken("Error - $e")
                }

                override fun onResponse(call: Call, response: Response) {
                    try {
                        val resStr = response.body!!.string()
                        Log.d("MAIN_ACT", "onResponse: $resStr")
                        val json = JSONObject(resStr)
                        val token = json.getString("token")
                        val expirationTime = json.getString("expirationTime")
                        callBack.returnToken(token)
                        Log.e(InfobippluginPlugin.TAG, "onResponse: callToken -> $callToken")
                    } catch (e: Exception) {
                        Log.e("MAIN ACT", "onResponse:11 ${e.toString()}")
                        callBack.returnToken("Error - $e")
                    }
                }
            })
        }
    }
}

interface ReturnTokenCallBack {
    fun returnToken(token: String)
}