import 'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/first_lock.dart';

class ProcessVerification extends StatefulWidget {
  const ProcessVerification({Key? key}) : super(key: key);

  @override
  State<ProcessVerification> createState() => _ProcessVerificationState();
}

class _ProcessVerificationState extends State<ProcessVerification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_home();
  }
  shift_to_home(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const FirstLock() )));
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
                child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_zb4cwi18.json'),
              ),
              SizedBox(height: 16,),
              Text('Processing Verification OTP')
            ],
          ),
        )
    );
  }
}
