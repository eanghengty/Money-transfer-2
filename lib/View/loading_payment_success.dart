import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/payment_success.dart';

class LoadingPaymentSuccess extends StatefulWidget {
  const LoadingPaymentSuccess({Key? key}) : super(key: key);

  @override
  State<LoadingPaymentSuccess> createState() => _LoadingPaymentSuccessState();
}

class _LoadingPaymentSuccessState extends State<LoadingPaymentSuccess> {
  void initState() {
    // TODO: implement initState
    super.initState();
    shift_to_make_transfer();
  }
  shift_to_make_transfer(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const PaymentSuccess() )));
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
                child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_7Ht9wn.json'),
              ),
              SizedBox(height: 16,),
              Text('payment is processing')
            ],
          ),
        )
    );
  }
}
