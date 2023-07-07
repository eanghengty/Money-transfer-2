import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/make_payment_screen.dart';
import 'package:truemoneyversion2/View/quick_payment_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class QuickPayment extends StatefulWidget {
  const QuickPayment({Key? key}) : super(key: key);

  @override
  State<QuickPayment> createState() => _QuickPaymentState();
}

class _QuickPaymentState extends State<QuickPayment> {

  final serviceselectioncontroller = TextEditingController();
  final servicenamecontroller = TextEditingController();
  final descriptioncontroller=TextEditingController();
  final currentuser=FirebaseAuth.instance;
  final accountidcontroller=TextEditingController();
  final amountcontroller=TextEditingController();
  void dipose(){
    accountidcontroller.dispose();
    descriptioncontroller.dispose();
    servicenamecontroller.dispose();
    serviceselectioncontroller.dispose();
    amountcontroller.dispose();
    dispose();
  }
  Future addquicktransfer() async {
    await FirebaseFirestore.instance.collection('quicktransfer').add({
      'accountid':accountidcontroller.text.trim(),
      'description':descriptioncontroller.text.trim(),
      'amount':amountcontroller.value,
      'servicename':servicenamecontroller,
      'serviceselection':serviceselectioncontroller,
      'uid':currentuser.currentUser!.uid,

    });
  }


  Widget payment({required String icon, required String text, required String description}){
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
              'Quick Payment',
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const QuickPaymentAdd()));
          },
          child:Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue[800],
        ),
        body:SingleChildScrollView(
            child:
            Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  payment(icon:'lib/Assets/payment.png',text:'Payment A',
                      description: 'Utilities'),
                  payment(icon:'lib/Assets/payment.png',text:'Payment B', description: 'Utilities'),
                  payment(icon:'lib/Assets/payment.png',text:'Payment C', description: 'Education')

                ],
              ),
            )
        )
    );;
  }
}
