import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class SendNotiToCustomerCall {
  static Future<ApiCallResponse> call({
    String tittle = '',
    String message = '',
    String uid = '',
  }) {
    final body = '''
{
  "notification": {
    "title": "${tittle}",
    "body": "${message}",
    "sound": "default",
    "mutable_content": true
  },
  "to": "/topics/${uid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendNotiToCustomer',
      apiUrl: 'https://fcm.googleapis.com/fcm/send',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAADCThSWc:APA91bET9DXW6PM-5o21X1fU56ZhiZz720EMW5ZQkHINsVIYUFzxjt_sPfv1gQDSxCV4Kuxz7DL-hLjn_Ycl4EptyMQsF3XAocibFiKlE1WIl2lfcf0cMDCVrKI0e-BGkPxjTwemz047',
      },
      params: {
        'Tittle': tittle,
        'Message': message,
        'uid': uid,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}
