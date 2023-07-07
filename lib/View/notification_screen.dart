import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'MTA Notification',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue[900],
        leading: InkWell(
          child: Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
          },
        ),
      ),
      body:Container(
          padding: EdgeInsets.all(16),

          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child:Lottie.network('https://assets7.lottiefiles.com/packages/lf20_wdqpqy2q.json'),
              ),
              SizedBox(height: 16,),
              Text('Currently, no notification',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),)
            ],
          ),
        ),

    );
  }
}
