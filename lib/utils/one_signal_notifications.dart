import 'package:solidcare/config.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/utils/common.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void initializeOneSignal() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  await OneSignal.shared
      .setAppId(
          getStringAsync(ONESIGNAL_API_KEY, defaultValue: ONESIGNAL_APP_ID))
      .then((value) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent? event) {
      return event?.complete(event.notification);
    });

    saveOneSignalPlayerId();

    OneSignal.shared.disablePush(appStore.isNotificationsOn);

    OneSignal.shared.consentGranted(appStore.isNotificationsOn);
    OneSignal.shared.requiresUserPrivacyConsent();
    OneSignal.shared.consentGranted(appStore.isNotificationsOn);
    OneSignal.shared.promptUserForPushNotificationPermission();

    OneSignal.shared.setSubscriptionObserver((changes) async {
      if (!changes.to.userId.isEmptyOrNull)
        await setValue(PLAYER_ID, changes.to.userId);
    });
  });
}

Future<void> saveOneSignalPlayerId() async {
  await OneSignal.shared.getDeviceState().then((value) async {
    if (value!.userId.validate().isNotEmpty)
      appStore.setPlayerId(value.userId.validate());
  }).catchError((e) {
    toast(e.toString());
  });
}

onNotificationTaps({OSNotificationOpenedResult? openedResult}) {
  if (isPatient()) {
  } else if (isDoctor()) {
  } else {}
}
