import'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/quick_transfer.dart';

class LoadingTransferCompleted extends StatefulWidget {
  const LoadingTransferCompleted({Key? key}) : super(key: key);

  @override
  State<LoadingTransferCompleted> createState() => _LoadingTransferCompletedState();
}

class _LoadingTransferCompletedState extends State<LoadingTransferCompleted> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_quick_add_transfer();
  }
  shift_to_quick_add_transfer(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const QuickTransfer() )));
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
              Text('Adding quick transfer')
            ],
          ),
        )
    );
  }
}
