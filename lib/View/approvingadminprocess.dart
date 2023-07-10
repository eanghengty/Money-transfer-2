import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';

class approvingprocess extends StatefulWidget {
  const approvingprocess({Key? key}) : super(key: key);

  @override
  State<approvingprocess> createState() => _approvingprocessState();
}

class _approvingprocessState extends State<approvingprocess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_home();
  }
  shift_to_home(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const adminhomescreen()) ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_gazeozku.json'),
              ),
              SizedBox(height: 16,),
              Text('Loading to user mode...')
            ],
          ),
        )
    );
  }
}
