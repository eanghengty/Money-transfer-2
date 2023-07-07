import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
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
              Text('Payment succeed'),
              SizedBox(height: 16,),
              Text('Tap on this "Go back" button to return back to home screen.',textAlign: TextAlign.center,),
              SizedBox(height: 16,),
              ElevatedButton(
                child: Text("Go back", style:
                TextStyle(color: Colors.white,)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  elevation: 0,

                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const HomeScreen() ));
                },
              ),
            ],
          ),
        )
    );
  }
}
