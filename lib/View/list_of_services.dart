          import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/make_payment_screen.dart';
import 'package:truemoneyversion2/View/pay_services.dart';
class ListService extends StatefulWidget {
  const ListService({Key? key}) : super(key: key);

  @override
  State<ListService> createState() => _ListServiceState();
}

class _ListServiceState extends State<ListService> {
  Widget feature_service({required String icon, required String text, required String description}){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> MakePayment()));
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
                  width: 180,

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
              'Mobile Top-Up',
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
                  CupertinoPageRoute(builder: (ctx) => const PayServices()));
            },
          ),
        ),
        body:SingleChildScrollView(
            child:
            Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  feature_service(icon:'lib/Assets/company_logo/smart.png',text:'Smart',
                      description: ''),
                  feature_service(icon:'lib/Assets/company_logo/cellcard.png',text:'Cellcard', description: ''),
                  feature_service(icon:'lib/Assets/company_logo/metfone.png',text:'Metfone', description: '')

                ],
              ),
            )
        )

    );
  }
}
