import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pushnotification/feature/model/notification_model.dart';
import 'package:pushnotification/feature/views/message_screen.dart';
class NotificationController extends GetxController{

  Rx<NotificationBody>notificationBody=Rx(NotificationBody());


 FirebaseMessaging messaging = FirebaseMessaging.instance;
 FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  
firebaseInit(){
print('object');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    print(message.notification?.title.toString());

           notificationBody.value=NotificationBody.fromJson(jsonDecode(jsonEncode(message.data)));
           print(notificationBody.value.body?.name);

    if(Platform.isAndroid){
      showNotification(message);
      inItLocalNotification(message);


    }else{
      showNotification(message);

    }




  });
}
 
 inItLocalNotification(RemoteMessage message){

   var androidInitializationSetting=AndroidInitializationSettings('@mipmap/ic_launcher');
   var iosInitializationSetting=DarwinInitializationSettings();

   var initilizationSetting=InitializationSettings(
       android: androidInitializationSetting,
       iOS: iosInitializationSetting
   );
   _flutterLocalNotificationsPlugin.initialize(initilizationSetting,
   // onDidReceiveBackgroundNotificationResponse:(payload) {
   //   handleMessage(message);
   //
   // } ,
   onDidReceiveNotificationResponse: (payload) {
     handleMessage(message);

   }
   );
 }

showNotification(message){

   AndroidNotificationChannel channel=AndroidNotificationChannel(
    Random.secure().nextInt(100000).toString(),'channel name');

    
   AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
       channel.id, channel.name,
      priority: Priority.high,
      channelDescription: 'Your channel description',
  //     importance: Importanel(
  //      Random.secure().nextInt(100000).toString(),
  //      'High Impotance Notification',
  //  importance: Importance.max
  //  );
// nce.high,
     ticker: 'ticker'

   );

   DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(

     presentAlert: true,
     presentBadge: true,
     presentSound: true
   );

   NotificationDetails notificationDetails=NotificationDetails(
     android: androidNotificationDetails,
     iOS: darwinNotificationDetails,
   );
   Future.delayed(Duration.zero,(){
     _flutterLocalNotificationsPlugin.show(
         0,
         message.notification!.title.toString(),
         message.notification!.body.toString(),
         notificationDetails);
   });
}

 sendNotification()async{

  NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: true,
  criticalAlert: true,
  provisional: true,
  sound: true,

);

  getDeviceToken().then((token)async{
    print(token);
    var body={
      "to":"/topics/topu",
      "notification":{
        "title":"Alert",
        "body":"description"
      },
      "body":{
        "id":"28",
        "name":"alvi"
      },
      "android":{
        "id":"28",
      }
    };


    try{

      return await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: json.encode(body),headers: {
        "Content-Type":"application/json",
        "Authorization":"key=AAAAMxTr-c8:APA91bGO9VIEtlMVLbrVclZm94lXs02XE5ivnR1eKYU50gRxsNiQ0BNE98LHmAJnvfOJ5pTdeY3g-2fuZpH4is7SNgNf3SVkEK5yjMwKNinDSuCXvCKmeI6Qt0fFrCmO3JQS7mxJJtop"
          }).then((value) => print(value.statusCode));

    }catch(e){print(e.toString());}

  });



// if(settings.authorizationStatus==AuthorizationStatus.authorized){
//   print('permission approve');
// }else if(settings.authorizationStatus==AuthorizationStatus.authorized){
//   print('provisional');
// }else{
//   AppSettings.openAppSettings();
//   print('denied');

// }
 }
  subscribe(){

    messaging.subscribeToTopic("topu");
  }
  unsubscribe(){
   messaging.unsubscribeFromTopic('topu');
  }

handleMessage(RemoteMessage message){
   if(message.notification!.title!.isNotEmpty){
     Get.to(()=>MessageScreen());
   }
}

Future<String>getDeviceToken()async{

  String?token=await messaging.getToken();


  return token!;
}

 isRefreshToken(){
   messaging.onTokenRefresh.listen((event) {
     print('refreshhh ${event.toString()}');
   });
 }


}