import'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:lottie/lottie.dart';
class QuickTransaction extends StatefulWidget {
  const QuickTransaction({Key? key}) : super(key: key);

  @override
  State<QuickTransaction> createState() => _QuickTransactionState();
}

class _QuickTransactionState extends State<QuickTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Quick Transaction Limit',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[900],
          leading: InkWell(
            child: Icon(
              Icons.arrow_circle_left_outlined,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
            },
          ),
        ),
        body:Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
                Container(
                  width: 150,
                  height: 150,

                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_GXS1DssMnR.json'),
                ),
              SizedBox(height:10),
              Text("Transaction limit",
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              )),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of Transfer daily',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Withdraw amount per transfer',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  'Tap on this "Confirm" button to confirm new transaction limit for your account'),
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
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (ctx) => const HomeScreen()));
                },
              ),
            ],
          ),
        )
    );
  }
}
