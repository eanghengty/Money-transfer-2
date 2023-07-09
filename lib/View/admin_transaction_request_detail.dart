import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/adminrequest.dart';

class admintransactiondetail extends StatefulWidget {
  const admintransactiondetail({Key? key}) : super(key: key);

  @override
  State<admintransactiondetail> createState() => admintransactiondetailstate();
}

class admintransactiondetailstate extends State<admintransactiondetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Transaction Details',
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
                CupertinoPageRoute(builder: (ctx) => const adminrequest()));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
              height: 150,
            child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_bdsthrsj.json'),
          ),
      SizedBox(height: 20,),
      Container(
        decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1)
        ),
        width:double.infinity,
        padding:EdgeInsets.all(16),
        margin:EdgeInsets.only(bottom: 20,top:5,left: 10,right: 10),
        child: Column(
          children: [
            Text('New request #00001 From user 00010',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white
              ),),
            SizedBox(height: 20,),
            Text('Transfer amount 100 USD',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white
              ),),
            SizedBox(height: 16,),
            Text('Date: 03-Jan-2023 12:30',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white
              ),),
            SizedBox(height: 16,),
            Text('To: 10010 - Agent',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white
              ),),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Accept", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,

                  ),
                  onPressed: () {

                  },),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text("Deny", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 0,

                  ),
                  onPressed: () {

                  },),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text("View details", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    elevation: 0,

                  ),
                  onPressed: () {

                  },),
              ],
            )
          ],
        ),
      )
        ],
      ),
    );
  }
}
