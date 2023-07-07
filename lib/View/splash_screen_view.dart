  import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'authscreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sign_in();
  }
  sign_in() async{
      Future.delayed(Duration(seconds: 10)).then((value){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const authscreen() ));
      });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Money Transfer', style:
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
            textAlign: TextAlign.center,),
          Container(
              width: double.infinity,
              height: 300,
              child:Lottie.network('https://assets1.lottiefiles.com/packages/lf20_fusf7urk.json')
          ),
          SizedBox(height: 100,),
          Text('This is the money transfer project that, I made by using flutter for Semester 1 project')
        ],
      ),
    );
  }
}
