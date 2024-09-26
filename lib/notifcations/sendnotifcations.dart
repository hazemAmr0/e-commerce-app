

// abstract class sendOneSignalNotificatios{
//  static Future<void>  sendOneSignalNotification() async {
//       const String url = "https://onesignal.com/api/v1/notifications";
//       const String apiKey='Y2NlY2ZkZDQtMDQ5ZS00N2E1LWI5NzUtYTg1MTZlZWIwZDIx';
//       const String appId='7f6cc79a-99b1-4398-b4d5-fe76186562f8';
//       final Map<String, dynamic> requestBody = {
             
//       'included_segments': ['All'],
//       'headings': {'en': 'wellcome to buyit'},
//       'contents': {'en': 'hi hello buyit users'},
//       'ios_interruption_level': 'critical',
//       'app_id': appId,
//       'large_icon': 'assets/images/icon.png',
//       'data': {
//         'foo': 'additional data which you want to send with notification',
//       },
// 'big_picture': 'assets/images/icon.png',
//       };
//       final Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Basic $apiKey',
//         'Accept': 'application/json',
//       };
//       try {
//        final http.Response response = await http.post(
//          Uri.parse(url),
//          headers: headers,
//          body: jsonEncode(requestBody),
//        );
//         if (response.statusCode == 200) {
//           print('notification sent');
//         } else {
//           print('notification failed');
//         }
//       } catch (e) {
//         print('notification failed');
//       }
    
      
   

// }
// final id =OneSignal.User.pushSubscription.id;
// Print(id);
// }