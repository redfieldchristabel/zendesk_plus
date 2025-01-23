package my.com.fromyourlover.zendesk_plus

import android.app.Activity
import android.content.Context
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import my.com.fromyourlover.pigeon.FlutterError
import my.com.fromyourlover.pigeon.ZendeskHostApi
import zendesk.android.Zendesk
import zendesk.messaging.android.DefaultMessagingFactory

/** ZendeskPlusPlugin */
class ZendeskPlusPlugin : FlutterPlugin, ActivityAware, ZendeskHostApi {

    private var activity: Activity? = null // Store the activity
    private var context: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ZendeskHostApi.setUp(binding.binaryMessenger, this)
        context = binding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        ZendeskHostApi.setUp(binding.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity // Get the activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null // Clear the activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity // Re-get the activity
    }

    override fun onDetachedFromActivity() {
        activity = null // Clear the activity
    }

    override fun initialize(androidAppId: String?, iosAppId: String?) {
        if (androidAppId != null) {
            // Initialize Zendesk client for Android

            CoroutineScope(Dispatchers.Main).launch { // Launch a coroutine on the Main thread
                try {
                    // Call the suspend function here
                    Log.i("Zendesk", "Zendesk initialized (Android) before")
                    Zendesk.initialize(
                        context = context!!,
                        channelKey = androidAppId,
                        messagingFactory = DefaultMessagingFactory(),
                    ) // Report success back to Flutter
                    Log.i("Zendesk", "Zendesk initialized (Android)")
                } catch (e: Exception) {
                    throw FlutterError(
                        "channel-error",
                        "Unable to establish connection on channel: '$androidAppId'.",
                        "Fail while initializing Zendesk (Android).",
                    ) // Report error to Flutter
                }
            }

        } else {
            throw FlutterError(
                "channel-error",
                "Android app id is not provided.",
                "Fail while initializing Zendesk (Android).",
            )
        }
    }




    override fun openChat() {

        CoroutineScope(Dispatchers.Main).launch {
            try {
                if (activity != null) {
                    Zendesk.instance.messaging.showMessaging(activity!!)
                } else {
                    println("Activity is null. Cannot show Zendesk messaging.")
                    // Handle the error appropriately, e.g., send an error back to Flutter
                }
            } catch (e: Exception) {
                println("Error showing Zendesk messaging: ${e.message}")
                // Handle errors
            }
        }
    }


}
