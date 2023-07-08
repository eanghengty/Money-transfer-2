
import'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/quick_payment.dart';
class loadingcompletedsetlimit extends StatefulWidget {
  const loadingcompletedsetlimit({Key? key}) : super(key: key);

  @override
  State<loadingcompletedsetlimit> createState() => _loadingcompletedsetlimitState();
}

class _loadingcompletedsetlimitState extends State<loadingcompletedsetlimit> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_quick_add_payment();
  }
  shift_to_quick_add_payment(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const HomeScreen() )));
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
                child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_a2chheio.json'),
              ),
              SizedBox(height: 16,),
              Text('setting up transaction limit')
            ],
          ),
        )
    );
  }
}
