package com.example.infobip_plugin.infobip_plugin

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import com.example.infobip_plugin.infobip_plugin.utils.SharedPrefs
import com.infobip.webrtc.sdk.api.InfobipRTC
import com.infobip.webrtc.sdk.api.call.CallConversationsRequest
import com.infobip.webrtc.sdk.api.call.OutgoingCall
import com.infobip.webrtc.sdk.api.event.CallEventListener
import com.infobip.webrtc.sdk.api.event.call.*
import com.infobip.webrtc.sdk.impl.event.DefaultCallEventListener

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.io.IOException
import java.util.*
import java.util.logging.StreamHandler

/** InfobipPlugin */
class InfobipPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var eventChannel: EventChannel
    private lateinit var eventSink: EventChannel.EventSink
    var identity: String? = null
    var displayName: String? = null
    lateinit var applicationContext: Context
    lateinit var applicationId: String
    lateinit var appKey: String
    lateinit var baseUrl: String
    var callToken: String? = null
    var callExpirationTime: String? = null
    var resString: String? = null
    var callStatus = "None"
    var isMute = false
    var isOnSpeaker = false
    var callDuration = 0
    var callStartTime: Date? = null
    var callEstablishTime: Date? = null
    var callEndTime: Date? = null
    var call: OutgoingCall? = null
    val handler: Handler = Handler(Looper.getMainLooper())

    /*** this method is attached with method channel*/
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL)
        setStreamHandlerListener()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    private fun setStreamHandlerListener() {
        eventChannel.setStreamHandler(
                object : StreamHandler(), EventChannel.StreamHandler {
                    override fun onListen(p0: Any?, sink: EventChannel.EventSink) {
                        eventSink = sink
                    }

                    override fun onCancel(p0: Any?) {
                    }
                }
        )
    }

    /*** this method is call when call methods channel and get and pass the result*/
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            MAIN_PARAMETERS -> {
                Log.e(TAG, "onMethodCall: ")
                applicationId = SharedPrefs.getString(applicationContext, APPLICATION_ID)
                if (applicationId.isEmpty() || applicationId.isNotEmpty()) {
                    applicationId = call.argument<String>("application_id")!!
                    Log.e(TAG, "onMethodCall: applicationId1 -> $applicationId")
                }
                appKey = SharedPrefs.getString(applicationContext, APP_KEY)
                if (appKey.isEmpty() || appKey.isNotEmpty()) {
                    appKey = call.argument<String>("app_key")!!
                    Log.e(TAG, "onMethodCall: applicationKey1 -> $appKey")
                }
                baseUrl = SharedPrefs.getString(applicationContext, BASE_URL)
                if (baseUrl.isEmpty() || baseUrl.isNotEmpty()) {
                    baseUrl = call.argument<String>("app_base_url")!!
                    Log.e(TAG, "onMethodCall: baseUrl1 -> $baseUrl")
                }
                result.success(true)
            }
            CALL_TOKEN -> {
                identity = call.argument<String>("identity")!!
                displayName = call.argument<String>("displayName")!!
                Log.e(TAG, "onMethodCall: identity -> $identity")
                Log.e(TAG, "onMethodCall: displayName -> $displayName")

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
                            callToken = token
                            callExpirationTime = expirationTime

                            handler.post {
                                result.success(resStr)
                                Log.e(TAG, "onMethodCall: resString inside handler-> $resString")
                            }

                            Log.e(TAG, "onResponse: resString -> $resString")
                            Log.e(TAG, "onResponse: callToken -> $callToken")
                            Log.e(TAG, "onResponse: callExpirationTime -> $callExpirationTime")
                        } catch (e: Exception) {
                            Log.e("MAIN ACT", "onResponse:11 ${e}")
                        }
                    }
                })
                Log.e(TAG, "onMethodCall: resString -> $resString")
                Log.e(TAG, "onMethodCall: callToken -> $callToken")
                Log.e(TAG, "onMethodCall: callExpirationTime -> $callExpirationTime")
            }
            CALL_PARAMETERS -> {
                dialCall(callToken!!)
                Log.e(
                        TAG,
                        "onMethodCall: callParameters --> callToken -> $callToken identity -> $identity"
                )
                result.success(true)
            }
            FINAL_CALL_STATUS -> {
                result.success(callStatus)
                Log.e(TAG, "onMethodCall: finalCallStatus -> callStatus -> $callStatus")
            }
            MUTE_PHONE -> {
                muteCall()
                result.success(this.call?.muted())
            }
            SPEAKER_PHONE -> {
                callSpeakerPhone()
                result.success(this.call?.speakerphone())
            }
            CALL_DURATION -> {
                getCallDuration()
                result.success(callDuration)
            }
            CALL_START_TIME -> {
                getCallStartTime()
                result.success(callStartTime.toString())
            }
            CALL_ESTABLISH_TIME -> {
                getCallEstablishTime()
                result.success(callEstablishTime.toString())
            }
            CALL_END_TIME -> {
                getCallEndTime()
                result.success(callEndTime.toString())
            }
            CALL_HANG_UP -> {
                callHangUp()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    /*** When user dial call to another user.*/
    private fun dialCall(token: String) {

        val callRequest = CallConversationsRequest(
                token,
                applicationContext,
                DefaultCallEventListener()
        )

        Log.e(TAG, "dialCall: token --> $token")
        Log.e(TAG, "dialCall: identity --> $identity")

        call = InfobipRTC.callConversations(callRequest)
        call!!.setEventListener(callEventListener)
        Log.e(TAG, "dialCall: call --> $call")
    }

    /*** call end */
    private fun callHangUp() {
        call?.hangup()
//        clearCallFinished()
    }

    /*** call end time */
    private fun getCallEndTime() {
        callEndTime = call?.endTime()
    }

    /*** call establish time */
    private fun getCallEstablishTime() {
        callEstablishTime = call?.establishTime()
    }

    /*** call start time */
    private fun getCallStartTime() {
        callStartTime = call?.startTime()
    }

    /*** call duration */
    private fun getCallDuration() {
        callDuration = call?.duration()!!
    }

    /*** call on speaker event*/
    private fun callSpeakerPhone() {
        val callOnSpeaker = call?.speakerphone()
        Log.e(TAG, "callSpeakerPhone: callOnSpeaker before --> $callOnSpeaker")
        call?.speakerphone(!callOnSpeaker!!)
    }

    /*** call mute event*/
    private fun muteCall() {
        val muteUnmuteCall = call?.muted()
        Log.e(TAG, "muteCall: muteUnmuteCall before --> $muteUnmuteCall")
        call?.mute(!muteUnmuteCall!!)
    }

    /*** call clear method*/
    private fun clearCallFinished() {
        if (callToken!!.isNotEmpty()) {
            callToken = null
        }
        if (callExpirationTime!!.isNotEmpty()) {
            callExpirationTime = null
        }
        if (identity!!.isNotEmpty()) {
            identity = null
        }
        if (displayName!!.isNotEmpty()) {
            displayName = null
        }
        if (callStartTime!!.toString().isNotEmpty()) {
            callStartTime = null
        }
        if (callEstablishTime!!.toString().isNotEmpty()) {
            callEstablishTime = null
        }
        if (callEndTime!!.toString().isNotEmpty()) {
            callEndTime = null
        }
        if (call!!.toString().isNotEmpty()) {
            call = null
        }
        isMute = false
        isOnSpeaker = false
        callDuration = 0
    }

    /*** call listeners for call event*/
    private val callEventListener: CallEventListener = object : CallEventListener {
        override fun onRinging(callRingingEvent: CallRingingEvent) {
            callStatus = ON_RINGING
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d("WebRTC", "Call is ringing on Alice's device!")
            Log.e(TAG, "onRinging: finalCallStatus -> callStatus -> $callStatus")
        }

        override fun onUpdated(callUpdatedEvent: CallUpdatedEvent?) {
            callStatus = ON_UPDATED
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d("WebRTC", "Call is updates on Alice's device!")
            Log.e(TAG, "onUpdated: finalCallStatus -> callStatus -> $callStatus")
        }

        override fun onEarlyMedia(callEarlyMediaEvent: CallEarlyMediaEvent) {
            callStatus = ON_EARLY_MEDIA
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d("WebRTC", "Ringback tone received!")
            Log.e(TAG, "onEarlyMedia: finalCallStatus -> callStatus -> $callStatus")
        }

        override fun onEstablished(callEstablishedEvent: CallEstablishedEvent) {
            callStatus = ON_ESTABLISHED
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d("WebRTC", "Alice answered call!")
            Log.e(TAG, "onEstablished: finalCallStatus -> callStatus -> $callStatus")
        }

        override fun onHangup(callHangupEvent: CallHangupEvent) {
            callStatus = ON_HANGUP
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d("WebRTC", "Call is done! Status: " + callHangupEvent.errorCode.description)
            Log.e(TAG, "onHangup: finalCallStatus -> callStatus -> $callStatus")
        }

        override fun onError(callErrorEvent: CallErrorEvent) {
            callStatus = ON_ERROR
            activity.runOnUiThread { eventSink.success(callStatus) }
            Log.d(
                    "WebRTC",
                    "Oops, something went very wrong! Message: " + callErrorEvent.reason.toString()
            )
            Log.e(TAG, "onError: finalCallStatus -> callStatus -> $callStatus")
        }
    }

    companion object {
        const val TAG = "InfobipPlugin"
        const val CHANNEL = "infobip_plugin"
        const val EVENT_CHANNEL = "infobip_plugin_event"
        const val MAIN_PARAMETERS = "main_parameter"
        const val CALL_PARAMETERS = "call_parameter"
        const val CALL_TOKEN = "call_token"
        const val FINAL_CALL_STATUS = "final_call_status"
        const val APPLICATION_ID = "application_id"
        const val APP_KEY = "app_key"
        const val BASE_URL = "app_base_url"
        const val MUTE_PHONE = "mute"
        const val SPEAKER_PHONE = "speaker"
        const val CALL_DURATION = "call_duration"
        const val CALL_START_TIME = "call_start_time"
        const val CALL_ESTABLISH_TIME = "call_establish_time"
        const val CALL_END_TIME = "call_end_time"
        const val CALL_HANG_UP = "call_hangup"
        const val ON_RINGING = "onRinging"
        const val ON_UPDATED = "onUpdated"
        const val ON_EARLY_MEDIA = "onEarlyMedia"
        const val ON_ESTABLISHED = "onEstablished"
        const val ON_HANGUP = "onHangup"
        const val ON_ERROR = "onError"
    }
}
