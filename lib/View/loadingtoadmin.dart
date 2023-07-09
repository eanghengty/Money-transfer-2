import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import'package:truemoneyversion2/View/transfer_success.dart';
class loadingtoadmin extends StatefulWidget {
  const loadingtoadmin({Key? key}) : super(key: key);

  @override
  State<loadingtoadmin> createState() => _loadingtoadminState();
}

class _loadingtoadminState extends State<loadingtoadmin> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_make_transfer();
  }
  shift_to_make_transfer(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const adminhomescreen() )));
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
                child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_Xcjavr.json'),
              ),
              SizedBox(height: 16,),
              Text('loading to admin...')
            ],
          ),
        )
    );
  }
}
