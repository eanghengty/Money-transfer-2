import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import'package:truemoneyversion2/View/transfer_success.dart';
class LoadingTransferSuccess extends StatefulWidget {
  const LoadingTransferSuccess({Key? key}) : super(key: key);

  @override
  State<LoadingTransferSuccess> createState() => _LoadingTransferSuccessState();
}

class _LoadingTransferSuccessState extends State<LoadingTransferSuccess> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_make_transfer();
  }
  shift_to_make_transfer(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const TransferSuccess() )));
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
                child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_jufcgpuf.json'),
              ),
              SizedBox(height: 16,),
              Text('Transfer is processing')
            ],
          ),
        )
    );
  }
}
