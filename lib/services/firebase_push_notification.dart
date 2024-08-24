import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializePushNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    LocalNotificationService().initialize();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: LocalNotificationService().getRandomChannelId(),
            channelKey: 'score_channel',
            actionType: ActionType.Default,
            title: message.notification?.title,
            body: message.notification?.body,
          ),
        );
      },
    );

    FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  }

  Future<void> backgroundMessage(RemoteMessage remoteMessage) async {
    print(remoteMessage.notification?.title);
    print(remoteMessage.notification?.body);
    print(remoteMessage.data);
  }
}
