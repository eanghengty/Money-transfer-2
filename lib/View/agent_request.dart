import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/agent_transaction_request_detail.dart';
class AgentRequest extends StatefulWidget {
  const AgentRequest({Key? key}) : super(key: key);

  @override
  State<AgentRequest> createState() => _AgentRequestState();
}

class _AgentRequestState extends State<AgentRequest> {
  @override
  Widget list_request(){
    return Container(
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
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> TransactionDetails()));

                },),
            ],
          )
        ],
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'MTA transaction requests',
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
                CupertinoPageRoute(builder: (ctx) => const AgentHomeScreen()));
          },
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            list_request(),
            list_request(),
            list_request(),
            list_request(),
            list_request(),
            list_request(),
          ],
        ),
      )
    );
  }
}
