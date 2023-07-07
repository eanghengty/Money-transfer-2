import'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/quick_payment.dart';
class LoadingCompleted extends StatefulWidget {
  const LoadingCompleted({Key? key}) : super(key: key);

  @override
  State<LoadingCompleted> createState() => _LoadingCompletedState();
}

class _LoadingCompletedState extends State<LoadingCompleted> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_quick_add_payment();
  }
  shift_to_quick_add_payment(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const QuickPayment() )));
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
                child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_vuliyhde.json'),
              ),
              SizedBox(height: 16,),
              Text('Adding quick payment')
            ],
          ),
        )
    );
  }
}
