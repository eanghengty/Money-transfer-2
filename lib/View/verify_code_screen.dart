import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/process_verification.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/loading_to_home_screen.dart';
import 'package:truemoneyversion2/View/first_lock.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  var time = 60;
  var is_load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stop_time();
    loading();
  }

  loading() {
    Future.delayed(Duration(seconds: 2)).then((value) => {is_load = true});
  }

  stop_time() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        setState(() {
          time = 60;
        });
      }
      setState(() {
        time -= 1;
      });
    });
  }

  Widget code_key() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Code Confirmation')),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (ctx) => const SignInScreen()));
            },
            child: Icon(Icons.arrow_circle_left_outlined),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,
        ),
        body: Visibility(
          visible: is_load,
          child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Lottie.network(
                            'https://assets4.lottiefiles.com/packages/lf20_eg88dyk9.json'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Please Fill in the code',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          code_key(),
                          SizedBox(
                            width: 10,
                          ),
                          code_key(),
                          SizedBox(
                            width: 10,
                          ),
                          code_key(),
                          SizedBox(
                            width: 10,
                          ),
                          code_key()
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('The code will expired soon: ' + time.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: time <= 30
                                  ? Colors.red[600]
                                  : Colors.green[600])),
                      ElevatedButton(
                        child: Text("Send new code",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          primary:
                              time <= 30 ? Colors.lightBlue : Colors.grey[300],
                          elevation: 0,
                        ),
                        onPressed: () {
                          stop_time();
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          'Tap on this "Confirm" button to Login to your money transfer account'),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        child: Text("Confirm",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (ctx) =>
                                      const ProcessVerification()));
                        },
                      ),
                    ],
                  ))),
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
