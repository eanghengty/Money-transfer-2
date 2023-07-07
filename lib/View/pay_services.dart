import'package:lottie/lottie.dart';
import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/list_of_services.dart';

class PayServices extends StatefulWidget {
  const PayServices({Key? key}) : super(key: key);

  @override
  State<PayServices> createState() => _PayServicesState();
}

class _PayServicesState extends State<PayServices> {
  Widget feature_service({required String icon, required String text, required String description}){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> ListService()));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
            children: [
        Container(

        child:Image.asset(icon),

        width: 40,
        height: 40,
      ),
      SizedBox(width: 15,),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,

            child: Text(text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
         ),
          ),
          SizedBox(height: 3,),
          Container(
            width: 300,

            child: Text(description),
          )
        ],
      )
            ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MTA Pay Services',
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
        body:SingleChildScrollView(
          child:
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                feature_service(icon:'lib/Assets/telephone.png',text:'Mobile top-up',
                description: 'Top up your phone or other phones'),
                feature_service(icon:'lib/Assets/utility.png',text:'Utilities', description: 'Pay for electric or bills'),
                feature_service(icon:'lib/Assets/education.png',text:'Education', description: 'Pay for school fees')

              ],
            ),
          )
          )

    );
  }
}
