package my.com.fromyourlover.zendesk_plus

import android.app.Activity
import android.content.Context
import android.graphics.Color
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import my.com.fromyourlover.pigeon.FlutterError
import my.com.fromyourlover.pigeon.ZendeskHostApi
import my.com.fromyourlover.pigeon.ZendeskListener
import my.com.fromyourlover.pigeon.ZendeskUser
import zendesk.android.Zendesk
import zendesk.android.ZendeskResult
import zendesk.android.events.ZendeskEvent
import zendesk.android.events.ZendeskEventListener
import zendesk.android.events.exception.ZendeskJwtExpiredException
import zendesk.android.messaging.model.UserColors
import zendesk.messaging.android.DefaultMessagingFactory
import zendesk.logger.Logger;

/** ZendeskPlusPlugin */
class ZendeskPlusPlugin : FlutterPlugin, ActivityAware, ZendeskHostApi {

    private var activity: Activity? = null // Store the activity
    private var context: Context? = null
    private var zendesk: Zendesk? = null

    private var flutterApi: ZendeskListener? = null

    //    Customization
    var lightColors: UserColors? = null
    var darkColors: UserColors? = null

    private val zendeskEventListener: ZendeskEventListener = ZendeskEventListener { zendeskEvent ->


        when (zendeskEvent) {
            is ZendeskEvent.AuthenticationFailed -> {
                flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.AUTHENTICATION_FAILED) { }

                when (zendeskEvent.error) {
                    is ZendeskJwtExpiredException -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.JWT_EXPIRED_EXCEPTION) {}
                }
            }

            is ZendeskEvent.ConnectionStatusChanged -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.CONNECTION_STATUS_CHANGED) { }
            is ZendeskEvent.ConversationAdded -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.CONNECTION_STATUS_CHANGED) { }
            is ZendeskEvent.FieldValidationFailed -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.FIELD_VALIDATION_FAILED) { }
            is ZendeskEvent.SendMessageFailed -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.SEND_MESSAGE_FAILED) { }
            is ZendeskEvent.UnreadMessageCountChanged -> flutterApi?.onEvent(my.com.fromyourlover.pigeon.ZendeskEvent.UNREAD_MESSAGE_COUNT_CHANGED) { }
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.i("Zendesk", "Setup Method Chanel")
        ZendeskHostApi.setUp(binding.binaryMessenger, this)
        flutterApi = ZendeskListener(binding.binaryMessenger)

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

    override fun initialize(
        androidChannelId: String?, iosChannelId: String?, callback: (Result<Unit>) -> Unit
    ) {
        if (androidChannelId == null) {
            callback(
                Result.failure(
                    FlutterError(
                        "missing-argument",
                        "Android app ID is required",
                        "No androidAppId provided for initialization"
                    )
                )
            )
            return
        }

        if (context == null) {
            callback(
                Result.failure(
                    FlutterError(
                        "invalid-context",
                        "Android context is not available",
                        "Make sure plugin is properly initialized with context"
                    )
                )
            )
            return
        }

        CoroutineScope(Dispatchers.Main).launch {
            try {
                Log.i("Zendesk", "Starting Zendesk initialization...")

                val result = Zendesk.initialize(
                    context = context!!,
                    channelKey = androidChannelId,
                    messagingFactory = DefaultMessagingFactory(lightColors, darkColors)
                )

                when (result) {
                    is ZendeskResult.Success -> {
                        Log.i("Zendesk", "Initialization successful")
                        zendesk = result.value

                        callback(Result.success(Unit))
                    }

                    is ZendeskResult.Failure -> {
                        Log.e("Zendesk", "Initialization failed: ${result.error}")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "zendesk-error",
                                    "Zendesk initialization failed",
                                    result.error.message ?: "Unknown error"
                                )
                            )
                        )
                    }
                }
            } catch (e: Exception) {
                Log.e("Zendesk", "Exception during initialization", e)
                callback(
                    Result.failure(
                        FlutterError(
                            "unexpected-error",
                            "Unexpected error occurred",
                            e.message ?: "No error details"
                        )
                    )
                )
            }
        }
    }


    override fun openChat() {

        checkInitialization()

        CoroutineScope(Dispatchers.Main).launch {
            try {
                if (activity != null) {
                    zendesk!!.messaging.showMessaging(activity!!)
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

    override fun signIn(jwt: String, callback: (Result<ZendeskUser>) -> Unit) {

        checkInitialization()

        CoroutineScope(Dispatchers.Main).launch {
            try {
                // Call the suspend function and await its result
                // Handle ZendeskResult and map it to Result<String>
                when (val result = zendesk!!.loginUser(jwt)) {
                    is ZendeskResult.Success -> {
                        // Extract data from ZendeskUser (replace with actual logic)
                        val userData = result.value
                        callback(
                            Result.success(
                                ZendeskUser(
                                    id = userData.id, externalId = userData.externalId!!
                                )
                            )
                        )
                    }

                    is ZendeskResult.Failure -> {
                        callback(Result.failure(result.error))
                    }
                }
            } catch (e: Exception) {
                // Handle exceptions (e.g., network errors)
                println("Error: ${e.message}")
                callback(Result.failure(FlutterError("channel-error", "Sign-in failed", e.message)))
            }
        }
    }

    override fun signOut(callback: (Result<Unit>) -> Unit) {
        checkInitialization()
        CoroutineScope(Dispatchers.Main).launch {
            try {
                when (val result = zendesk!!.logoutUser()) {
                    is ZendeskResult.Success -> {
                        callback(
                            Result.success(Unit)
                        )
                    }

                    is ZendeskResult.Failure -> {
                        callback(Result.failure(result.error))
                    }
                }
            } catch (e: Exception) {
                callback(
                    Result.failure(
                        FlutterError(
                            "channel-error", "Sign-out failed", e.message
                        )
                    )
                )
            }
        }
    }

    private fun checkInitialization() {
        if (zendesk == null) {
            throw FlutterError("channel-error", "Zendesk is not initialized", "")
        }
    }

    override fun getUnreadMessageCount(callback: (Result<Long>) -> Unit) {
        checkInitialization()
        CoroutineScope(Dispatchers.Main).launch {
            try {
                val unreadMessageCount = zendesk!!.messaging.getUnreadMessageCount()
                callback(Result.success(unreadMessageCount.toLong()))
            } catch (e: Exception) {
                callback(
                    Result.failure(
                        FlutterError(
                            "channel-error", "Failed to get unread message count", e.message
                        )
                    )
                )
            }
        }
    }

    override fun startListener() {
        checkInitialization()
        zendesk!!.addEventListener(zendeskEventListener)
    }

    override fun stopListener() {
        checkInitialization()
        zendesk!!.removeEventListener(zendeskEventListener)
    }

    override fun setLightColorRgba(colors: my.com.fromyourlover.pigeon.UserColors) {
        lightColors = UserColors(
            onPrimary = getAndroidColor(colors.onPrimary),
            onAction = getAndroidColor(colors.onAction),
            onMessage = getAndroidColor(colors.onMessage)
        )
    }

    override fun setDarkColorRgba(colors: my.com.fromyourlover.pigeon.UserColors) {
        darkColors = UserColors(
            onPrimary = getAndroidColor(colors.onPrimary),
            onAction = getAndroidColor(colors.onAction),
            onMessage = getAndroidColor(colors.onMessage)
        )
    }

    private fun getAndroidColor(color: my.com.fromyourlover.pigeon.RgbaColor?): Int? {

        if (color == null) return null
        return Color.valueOf(
            color.r.toFloat(), color.g.toFloat(), color.b.toFloat(), color.a.toFloat()
        ).componentCount
    }

    override fun enableLogging(enabled: Boolean) = Logger.setLoggable(enabled)

    override fun loggingEnabled(): Boolean = Logger.isLoggable()


}
