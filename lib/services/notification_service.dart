
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';


import '../app_keys.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('[BACKGROUND] ${message.notification?.title}');
  debugPrint('[BACKGROUND] ${message.notification?.body}');
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Meminta izin notifikasi dan mengembalikan statusnya:
  /// authorized | provisional | denied | notDetermined
  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: ${settings.authorizationStatus.name}',
    );
    return settings.authorizationStatus;
  }
  /// Mengambil FCM Token perangkat
  Future<String?> getToken() async {
    final token = await _messaging.getToken();
    debugPrint('FCM Token: $token');
    return token;
  }
  /// Mendengarkan perubahan FCM Token
  void listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
    });
  }

/// Inisialisasi listener notifikasi foreground
Future<void> init() async {
   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('[FOREGROUND] Notification received');
    debugPrint('title: ${message.notification?.title}');
    debugPrint('body : ${message.notification?.body}');
    debugPrint('data : ${message.data}');

    final title = message.notification?.title ?? 'Notifikasi';
    final body = message.notification?.body ?? '';

    messengerKey.currentState?.showSnackBar(
      SnackBar(content: Text('$title\n$body')),
    );
  });
}

}
