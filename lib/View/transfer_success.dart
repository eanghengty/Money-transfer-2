import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';

class TransferSuccess extends StatefulWidget {
  const TransferSuccess({Key? key}) : super(key: key);

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
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
              Text('Transfer succeed'),
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
