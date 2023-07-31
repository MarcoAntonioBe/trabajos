import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notificaciones_wear/notification_services.dart';
import "package:http/http.dart" as http;
class HomeScreen extends StatefulWidget{
  const HomeScreen({Key?key}): super(key: key);
  @override
  State<HomeScreen>createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  final title=TextEditingController();
  final body=TextEditingController();
  NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print("Device token");
      print(value);
    });
    
  }
 
  @override
Widget build(BuildContext context) {

  return Scaffold(
  backgroundColor: Colors.black,
  body: Container(
    color: Colors.black,
    child: Center(
      child: TextButton(
        onPressed: () {
          notificationServices.getDeviceToken().then((value) async {
            var data = {
              "to": "dO7Nhp_iQzi7xGtk8ZWI_a:APA91bFHJ5937NLWWfolOUagx654DXL-MWHpXnp2X96CZ8euvTibCBU93Y7Ln9yv-ap4Kh5m6sIa7zhIuTm6CH3v8HkCd9wV4WsYpj6gfKFPMLaPtBmR-rSm4ecdLU9OyGPr-XTqmtWg",
              "priority": "high",
              "notification": {
                "title": "Prueba de notificacion",
                "body": "Notificacion",
              },
              "data": {
                "type": "msj",
                "id": "1"
              }
            };
            await http.post(
              Uri.parse("https://fcm.googleapis.com/fcm/send"),
              body: jsonEncode(data),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization": "key=AAAA5ZUloiw:APA91bGvXCRnX6TOS_udWAkBYqkU3R8QqplZMJad6X-pjvjUxdpIpfaLPCm0NC3p3iB-36e2tEVqcnZpGDfWxvtCtP1tcOSZYa4kdpnhr-TF1D5c4jUxEfxCnY65l_lD74NN8E8vEy1O"
              },
            );
          });
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: const Text('Enviar'),
      ),
    ),
  ),
);
}
}