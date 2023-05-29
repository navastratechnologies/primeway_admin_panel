import 'dart:convert';

import 'package:http/http.dart' as http;

void sendPushMessage(token, body, title) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAwrLx8LI:APA91bGOh_1TQnkiHN50HQpOku8ZG7KRZW375T7hqm--kNCJItwA04N5pgWRUToGCC4KtW7qv9Z0snOjA6r-ZDDXBWLjQk3i5AXbqPOX6CgRM1rCiVgyEg8Ufd7-t74wlFnN8HuEcAx6',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print("error push notification $e");
  }
}
