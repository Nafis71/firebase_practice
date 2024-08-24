import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationService{
  static LocalNotificationService? _instance;
  LocalNotificationService._();
  factory LocalNotificationService() => _instance ??= LocalNotificationService._();

  void initialize(){
    AwesomeNotifications().initialize(
        '',
        [
          NotificationChannel(
            channelGroupKey: 'score_channel_group',
            channelKey: 'score_channel',
            channelName: 'Score channel',
            channelDescription: 'Notification channel for basic tests',
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'score_channel_group',
              channelGroupName: 'Score Channel group')
        ],
        debug: true);
  }

  int getRandomChannelId(){
    Random random = Random();
    return random.nextInt(200);
  }
}