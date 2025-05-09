import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 这两个是封装的路由，可不用
// import 'package:planx_app/router/navigator_util.dart';
// import 'package:planx_app/router/routes.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _androidChannel = const AndroidNotificationChannel(
      'fcm', 'fcm Android',  // 这些信息根据自己的app定义
      description: "fcm Android description",
      importance: Importance.defaultImportance);

  // 本地消息，处理android的前台消息
  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    // @drawable/ic_launcher是应用的图标，路径是：android/app/src/main/res/drawable/ic_launcher.png
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // android 前台消息点击
          final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
          print(response);
          // 处理收到消息
          handleMessage(message);
        });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  // 初始化，获取设备token
  Future<void> initNotifications(BuildContext context) async {
    final settings = await _firebaseMessaging.requestPermission();
    print('授权状态: ${settings.authorizationStatus}');
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken); // 这个就是设备token，后端通过这token给设备发送信息
    if (context.mounted && fCMToken != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('FCM Token'),
          content: SelectableText(fCMToken), // 可复制内容
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: fCMToken));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已复制到剪贴板')),
                );
              },
              child: const Text('复制'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('关闭'),
            ),
          ],
        ),
      );
    }
    initPushNotifications();
    initLocalNotifications();
  }

  // 初始化接收消息的各种回调
  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // 打开app时，会执行该回调，获取消息（通常是程序终止时，点击消息打开app的回调）
    _firebaseMessaging.getInitialMessage().then(
          (RemoteMessage? message) {
        if (message == null) return; // 没有消息不执行后操作
        handleMessage(message);
      },
    );

    // 后台程序运行时，点击消息触发
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) => handleMessage(message));

    // 前台消息，android不会通知，所以需要自定义本地通知（iOS没有前台消息，iOS的前台消息和后台运行时一样的效果）
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      if (Platform.isIOS) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/ic_launcher',
              )),
          payload: jsonEncode(message.toMap()));
    });

    // 后台处理，后台程序运行时收到消息，不打开app也会执行的回调
    // FirebaseMessaging.onBackgroundMessage(FirebaseApi.handleBackgroundMessage);
  }

  // 处理收到的消息，比如跳转页面之类（这里需要无context跳转，可以参考我写的flutter路由配置篇章介绍）
  void handleMessage(RemoteMessage message) {
    // NavigatorUtil.push(Routes.indexPage);
  }

// static Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('后台消息');
//   // BotToast.showText(text: '后台消息:${message.toString()}');
//   print('title:${message.notification?.title}');
//   print('body:${message.notification?.body}');
//   print('payload:${message.data}');
//   print('message:${message}');
// }
}