import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

Future<ApiCallResponse> sendNotiToCustomerCall({
  String uid = '',
  String message = '',
}) {
  final body = '''
{
  "notification": {
    "title": "YOUR ORDER IS ${message}",
    "subtitle": "check your order status!",
    "body": "check your order at Brw.app",
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
      'uid': uid,
      'message': message,
    },
    body: body,
    bodyType: BodyType.JSON,
    returnBody: true,
  );
}
