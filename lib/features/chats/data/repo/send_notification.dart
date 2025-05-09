import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:nabd/features/chats/data/repo/get_fcm_token.dart';

Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/notification_key/pulse-b9de9-581f020b0bd4.json',
  );

  final accountCredentials = auth.ServiceAccountCredentials.fromJson(
    jsonString,
  );

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

  return client.credentials.accessToken.data;
}

Future<void> sendNotification({
  required String title,
  required String body,
  required String receiverId,
  required int imageUrl,
}) async {
  final String accessToken = await getAccessToken();
  final String token = await GetFcmToken.getUserToken(receiverId);
  final String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/pulse-b9de9/messages:send';

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': {
        'token': token,
        'notification': {'title': title, 'body': body},
        'data': {
          "type": "chat",
          "name": title,
          "receiverId": receiverId,
          "imageUrl": imageUrl.toString(),
        }, // Add custom data here

        'android': {
          'notification': {
            "sound": "custom_sound",
            'click_action':
                'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
            'channel_id': 'high_importance_channel',
            'icon': 'ic_notification',
          },
        },
        'apns': {
          'payload': {
            'aps': {"sound": "custom_sound.caf", 'content-available': 1},
          },
        },
      },
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}
