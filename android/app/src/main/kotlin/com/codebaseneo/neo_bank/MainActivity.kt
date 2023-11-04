package com.codebaseneo.neo_bank

import io.flutter.embedding.android.FlutterFragmentActivity

import android.util.Log
import com.google.gson.Gson

import com.idwise.sdk.IDWiseSDKCallback
import com.idwise.sdk.data.models.IDWiseSDKError
import com.idwise.sdk.data.models.JourneyInfo
import com.idwise.sdk.IDWise
import com.idwise.sdk.data.models.IDWiseSDKTheme
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    val CHANNEL = "com.codebaseneo.neo_bank/idwise"
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    val clientKey = call.argument<String>("clientKey")
                    val theme = when (call.argument<String>("theme")) {
                        "LIGHT" -> IDWiseSDKTheme.LIGHT
                        "DARK" -> IDWiseSDKTheme.DARK
                        else -> IDWiseSDKTheme.SYSTEM_DEFAULT
                    }

                    IDWise.initialize(clientKey.toString(), theme) { error ->
                        result.error("ERROR", error!!.message, null)
                        methodChannel?.invokeMethod("onError", Gson().toJson(error))
                    }
                }

                "startJourney" -> {
                    val journeyDefinitionId = call.argument<String>("journeyDefinitionId")
                    val referenceNo = call.argument<String>("referenceNo")
                    val locale = call.argument<String>("locale")

                    IDWise.startJourney(
                        this,
                        journeyDefinitionId!!,
                        referenceNo,
                        locale,
                        callback = object : IDWiseSDKCallback {
                            override fun onJourneyStarted(journeyInfo: JourneyInfo) {
                                Log.d("IDWiseSDKCallback", "onJourneyStarted")
                                methodChannel?.invokeMethod(
                                    "onJourneyStarted",
                                    journeyInfo!!.journeyId
                                )
                            }

                            override fun onJourneyCompleted(
                                journeyInfo: JourneyInfo,
                                isSucceeded: Boolean
                            ) {
                                Log.d("IDWiseSDKCallback", "onJourneyFinished")
                                methodChannel?.invokeMethod(
                                    "onJourneyFinished",
                                    journeyInfo?.journeyId
                                )
                            }

                            override fun onJourneyCancelled(journeyInfo: JourneyInfo?) {
                                Log.d("IDWiseSDKCallback", "onJourneyCancelled")
                                methodChannel?.invokeMethod(
                                    "onJourneyCancelled",
                                    journeyInfo?.journeyId
                                )
                            }

                            override fun onJourneyResumed(journeyInfo: JourneyInfo) {
                                Log.d("IDWiseSDKCallback", "onJourneyResumed")
                                methodChannel?.invokeMethod(
                                    "onJourneyResumed",
                                    journeyInfo.journeyId
                                )
                            }

                            override fun onError(error: IDWiseSDKError) {
                                Log.d(
                                    "IDWiseSDKCallback",
                                    "onError ${error.message}"
                                )
                                methodChannel?.invokeMethod("onError", Gson().toJson(error))
                            }
                        }
                    )

                }

                else -> result.error("NO_SUCH_METHOD", "NO SUCH METHOD", null)
            }
            // Note: this method is invoked on the main thread.
            // TODO
        }
    }
}
