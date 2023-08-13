import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pushnotification/feature/controller/notificationcontroller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    controller.firebaseInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Send Notification',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print('unsubcribe');
                  controller.unsubscribe();
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (_) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _.sendNotification();
                    },
                    child: Text('Send Notification')),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print('Subscribed');
                      _.subscribe();
                    },
                    child: Text('Subscription')),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
