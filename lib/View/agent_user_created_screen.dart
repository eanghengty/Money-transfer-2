import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
class AgentUserCreatedAccount extends StatefulWidget {
  const AgentUserCreatedAccount({Key? key}) : super(key: key);

  @override
  State<AgentUserCreatedAccount> createState() => _AgentUserCreatedAccountState();
}

class _AgentUserCreatedAccountState extends State<AgentUserCreatedAccount> {
  Widget list_user(){
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
          Text('New user created 00010 - Hengty',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 20,),
          Text('User created on 03-Feb-2023 12:01',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text('Identity already verified',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),

        ],
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'User account created',
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
              list_user(),
              list_user(),
              list_user(),
              list_user(),
              list_user(),
              list_user(),

            ],
          ),
        )
    );
  }
}
