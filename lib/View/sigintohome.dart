import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';

class signintohome extends StatefulWidget {
  const signintohome({Key? key}) : super(key: key);

  @override
  State<signintohome> createState() => _signintohomeState();
}

class _signintohomeState extends State<signintohome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_home();
  }
  shift_to_home(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const ConfirmLock() )));
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
                child: Lottie.network('https://assets1.lottiefiles.com/private_files/lf30_fkfbivy0.json'),
              ),
              SizedBox(height: 16,),
              Text('Loading to user mode...')
            ],
          ),
        )
    );
  }
}
