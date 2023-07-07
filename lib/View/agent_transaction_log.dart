import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';

class AgentTransactionLog extends StatefulWidget {
  const AgentTransactionLog({Key? key}) : super(key: key);

  @override
  State<AgentTransactionLog> createState() => _AgentTransactionLogState();
}

class _AgentTransactionLogState extends State<AgentTransactionLog> {
  Widget log_show({required String date, required int log}){
    return Container(

      child: Column(

        children: [
          Container(
            width: double.infinity,
            color:Colors.grey[300],
            child:Text(date),
            padding: EdgeInsets.all(5),
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              Container(

                  padding: EdgeInsets.all(5),
                  child:Row(
                    children: [
                      Expanded(child: Row(
                        children: [
                          Icon(Icons.shopping_basket_outlined),
                          SizedBox(width: 10,),
                          Text('00010 - Hengty'),
                          SizedBox(width: 10,),
                        ],
                      )),
                      Expanded(child: Text(log.toString() + " USD",
                        style:TextStyle(
                          color: log >= 0? Colors.green:Colors.red,
                        ),
                        textAlign: TextAlign.end,),)
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MTA Transaction Log',
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
              Container(
                padding: EdgeInsets.all(16),
                height: 150,
                color: Colors.blue[800],
                child: Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Agent 1 transaction log',
                            style:TextStyle(color:Colors.white)),
                        SizedBox(height: 10,),
                        Text('AID:10010',
                          style: TextStyle(color:Colors.white
                          ),)
                      ],
                    )
                ),
              ),

              log_show(date:'Yesterday',log:-10),
              log_show(date:'Feb 03, 2023', log:20),
            ],
          ),
        )
    );
  }
}
