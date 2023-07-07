import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
class ContactHotline extends StatefulWidget {
  const ContactHotline({Key? key}) : super(key: key);

  @override
  State<ContactHotline> createState() => _ContactHotlineState();
}

class _ContactHotlineState extends State<ContactHotline> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MTA Hotline',
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
        body: Container(
            padding: EdgeInsets.all(16),

            width: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,


              children: [
                Container(
                  width: 150,
                  height: 150,
                  child:Lottie.network('https://assets2.lottiefiles.com/packages/lf20_2yqxcdkb.json'),
                ),
                SizedBox(height: 16,),
                Text('Want to contact to our hotline?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 16,),
                Text('012 XXX XXXX',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),)
              ],
            ),

        )
    );
  }
}
