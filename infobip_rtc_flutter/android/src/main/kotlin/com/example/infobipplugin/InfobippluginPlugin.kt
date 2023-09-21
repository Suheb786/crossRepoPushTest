package com.example.infobipplugin

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import com.example.infobipplugin.utils.ApiManager
import com.example.infobipplugin.utils.ReturnTokenCallBack
import com.infobip.webrtc.sdk.api.InfobipRTC
import com.infobip.webrtc.sdk.api.event.call.CallEstablishedEvent
import com.infobip.webrtc.sdk.api.event.call.CallHangupEvent
import com.infobip.webrtc.sdk.api.event.call.CallRingingEvent
import com.infobip.webrtc.sdk.api.event.call.ErrorEvent
import com.infobip.webrtc.sdk.api.options.WebrtcCallOptions
import com.infobip.webrtc.sdk.api.request.CallWebrtcRequest
import com.infobip.webrtc.sdk.impl.call.DefaultOutgoingWebrtcCall
import com.infobip.webrtc.sdk.impl.event.listener.DefaultWebrtcCallEventListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Date
import java.util.logging.StreamHandler

/** UntitledPlugin */
class InfobippluginPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

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
    var isMute: Boolean? = false
    var isOnSpeaker: Boolean? = false
    var callDuration: Int? = 0
    var callStartTime: Date? = null
    var callEstablishTime: Date? = null
    var callEndTime: Date? = null
    val handler: Handler = Handler(Looper.getMainLooper())
    var callWeb: DefaultOutgoingWebrtcCall? = null;
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, InfobippluginPlugin.CHANNEL)
        channel.setMethodCallHandler(this)
        eventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            InfobippluginPlugin.EVENT_CHANNEL
        )
        setStreamHandlerListener()
    }

    override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setStreamHandlerListener()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {
        channel.setMethodCallHandler(null)
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


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            InfobippluginPlugin.INITIALISATION -> {
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: ")
                applicationId = call.argument<String>("application_id")!!
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: applicationId1 -> $applicationId")

                appKey = call.argument<String>("app_key")!!
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: applicationKey1 -> $appKey")

                baseUrl = call.argument<String>("app_base_url")!!
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: baseUrl1 -> $baseUrl")
                result.success("Android method channel Initialize")
            }

            InfobippluginPlugin.FETCH_TOKEN -> {
                identity = call.argument<String>("identity")!!
                displayName = call.argument<String>("displayName")!!
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: identity -> $identity")
                Log.e(InfobippluginPlugin.TAG, "onMethodCall: displayName -> $displayName")

                ApiManager.fetchToken(
                    identity!!,
                    displayName!!,
                    applicationId,
                    baseUrl,
                    appKey,
                    object : ReturnTokenCallBack {
                        override fun returnToken(token: String) {
                            callToken = token
                            handler.post {
                                result.success(callToken)
                                Log.e(
                                    InfobippluginPlugin.TAG,
                                    "onMethodCall: CALLTOKEN ---> $callToken"
                                )
                            }
                        }
                    }
                )
            }

            InfobippluginPlugin.DIAL_CALL -> {
                dialcall(callToken!!)
                Log.e(
                    InfobippluginPlugin.TAG,
                    "onMethodCall: callParameters --> callToken -> $callToken identity -> $identity"
                )
                result.success("Done")
            }

            InfobippluginPlugin.FINAL_CALL_STATUS -> {
                result.success(callStatus)
                Log.e(
                    InfobippluginPlugin.TAG,
                    "onMethodCall: finalCallStatus -> callStatus -> $callStatus"
                )
            }

            InfobippluginPlugin.MUTE_CALL -> {
                callMuted()
                result.success(callWeb?.muted())
            }

            InfobippluginPlugin.CALL_SPEAKER_PHONE -> {
                callSpeakerPhone()
                result.success(callWeb?.speakerphone())
            }

            InfobippluginPlugin.CALL_DURATION -> {
                callDuration()
                result.success(callDuration)
            }

            InfobippluginPlugin.CALL_START_TIME -> {
                callStartTime()
                result.success(callStartTime.toString())
            }

            InfobippluginPlugin.CALL_ESTABLISH_TIME -> {
                callEstablishTime()
                result.success(callEstablishTime.toString())
            }

            InfobippluginPlugin.CALL_END_TIME -> {
                callEndTime()
                result.success(callEndTime.toString())
            }

            InfobippluginPlugin.CALL_HANG_UP -> {
                callHangUp()
                result.success(true)
            }

            else -> result.notImplemented()
        }
    }


    private fun dialcall(token: String) {

        val callRequest = CallWebrtcRequest(
            token,
            applicationContext,
            DESTINATION,
            DefaultWebrtcCallEventListener()
        )

        // val infoBipRTC = InfobipRTC.getInstance()
        val webrtcCallOptions = WebrtcCallOptions.builder().audio(true).build()

//        val call =
//            infoBipRTC.callWebrtc(
//                callRequest,
//                webrtcCallOptions
//            ) as DefaultOutgoingWebrtcCall
        callWeb = InfobipRTC.getInstance().callWebrtc(
            callRequest,
            webrtcCallOptions
        ) as DefaultOutgoingWebrtcCall

        /*** call listeners for call event*/
        // webrtcCallEventListener = infoBipRTC.getActiveCall()
        // webrtcCallEventListener = InfobipRTC.getActiveCall()
        callWeb!!.eventListener =
            object : DefaultWebrtcCallEventListener() {

                override fun onRinging(callRingingEvent: CallRingingEvent?) {
                    super.onRinging(callRingingEvent)
                    callStatus = InfobippluginPlugin.ON_RINGING;
                }

                override fun onEstablished(callEstablishedEvent: CallEstablishedEvent?) {
                    super.onEstablished(callEstablishedEvent)
                    callStatus = InfobippluginPlugin.ON_ESTABLISHED;
                }

                override fun onHangup(callHangupEvent: CallHangupEvent?) {
                    super.onHangup(callHangupEvent)
                    callStatus =
                        InfobippluginPlugin.ON_HANGUP + "-" + callHangupEvent?.errorCode?.name;

                }

                override fun onError(errorEvent: ErrorEvent?) {
                    super.onError(errorEvent)
                    callStatus = InfobippluginPlugin.ON_ERROR;
                }

            }
    }

    fun callMuted(): Unit? {
        isMute = callWeb?.muted() ?: null
        return callWeb?.mute(!isMute!!)
    }

    fun callSpeakerPhone(): Unit? {
        isOnSpeaker = callWeb?.speakerphone() ?: null
        return callWeb?.speakerphone(!isOnSpeaker!!)
    }

    fun callHangUp(): Unit? {
        return callWeb?.hangup()
    }

    fun callEstablishTime(): Date? {
        callEstablishTime = callWeb?.establishTime()
        return callWeb?.establishTime()
    }

    fun callStartTime(): Date? {
        callStartTime = callWeb?.startTime()
        return callWeb?.startTime()
    }

    fun callEndTime(): Date? {
        callEndTime = callWeb?.endTime()
        return callWeb?.endTime()
    }

    fun callDuration(): Int? {
        callDuration = callWeb?.duration()
        return callWeb?.duration()
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
        if (callWeb!!.toString().isNotEmpty()) {
            callWeb = null
        }
        isMute = false
        isOnSpeaker = false
        callDuration = 0
    }


    companion object {
        const val TAG = "InfobipPlugin"
        const val CHANNEL = "infobip_plugin"
        const val EVENT_CHANNEL = "infobip_plugin_event"
        const val INITIALISATION = "initialisation"
        const val DIAL_CALL = "dial_call"
        const val FETCH_TOKEN = "fetch_token"
        const val FINAL_CALL_STATUS = "final_call_status"
        const val APPLICATION_ID = "application_id"
        const val APP_KEY = "app_key"
        const val BASE_URL = "app_base_url"
        const val MUTE_CALL = "mute_call"
        const val CALL_SPEAKER_PHONE = "call_speaker_phone"
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
        const val DESTINATION = "conversations"
    }

}
