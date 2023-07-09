import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';

class AgentPost extends StatefulWidget {
  const AgentPost({Key? key}) : super(key: key);

  @override
  State<AgentPost> createState() => _AgentPostState();
}

class _AgentPostState extends State<AgentPost> {
  Widget list_agent(){
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
          Text('10010 - Agent 1',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 20,),
          Text('Total deposit: 950 USD | 1,000,000 KH',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text('Total withdraw: 150 USD | 2,000,000 KH',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
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
              'Agent Daily Post',
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
                  CupertinoPageRoute(builder: (ctx) => const adminhomescreen()));
            },
          ),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              list_agent(),
              list_agent(),
              list_agent(),
              list_agent(),
              list_agent(),
              list_agent(),

            ],
          ),
        )
    );
  }
}
