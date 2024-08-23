import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  LocalNotifications._();

  static final LocalNotifications instance = LocalNotifications._();

  Future<void> initialize() async{
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
        });

    FirebaseMessaging.onMessage.listen((message) {
        showNotification(message);
    });
    String? token = await getToken();
    print(token);
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'my_data',
      );
    });
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<void> onTokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      // call an api
      // send new token
    });
  }
}



