import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/agent_transaction_request_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truemoneyversion2/View/approvingadminprocess.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class paymentmgmt extends StatefulWidget {
  const paymentmgmt({Key? key}) : super(key: key);

  @override
  State<paymentmgmt> createState() => _paymentmgmtState();
}

class _paymentmgmtState extends State<paymentmgmt> {
  @override

  List<String> paymentname=[];
  List<String> paymentammount=[];
  List<String> paymentcategory=[];
  List<String> paymentid=[];
  List<String> paymentdocument=[];
  List<String> paymentcurrency=[];
  Future getpaymentmgmt() async{
    await FirebaseFirestore.instance.collection('quickpayment').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            paymentname.add(document['name']);
            paymentcategory.add(document['category']);
            paymentid.add(document['accountid']);
            paymentammount.add(document['amount']);
            paymentdocument.add(document.reference.id);
            paymentcurrency.add(document['currency']);

          }


            // print(accountid.length);
            // listdocument.add(document.reference.id);
          );
          print(paymentname.length);
        })
    );
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getpaymentmgmt();



  }





  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Payment services mgmt',
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
        body:paymentname.length == 0 ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 350,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
            ),
            SizedBox(height: 16,),
            Text('Currently, no payment',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),)

          ],
        )) : ListView.builder(
            itemCount: paymentname.length,
            itemBuilder: (context, index) {
              return
                Container(
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)
                ),
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 20, top: 5, left: 10, right: 10),
                child: Column(
                  children: [
                    Text('Payment services: ' + paymentname[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 20,),
                    Text('Payment id: ' + paymentid[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('payment amount: ' + paymentammount[index] + " "+ paymentcurrency[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('payment category: ' + paymentcategory[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('payment description: ' + paymentcategory[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('Currency : '+ paymentcurrency[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text("Edit payment", style:
                          TextStyle(color: Colors.white,)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            elevation: 0,

                          ),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "edit info",
                              desc: "Are you sure?",
                              btnOkOnPress: () {
                                setState(() {
                                  updatestatus(num){

                                  }
                                });
                              },

                            ).show();

                          },),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          child: Text("Delete payment ", style:
                          TextStyle(color: Colors.white,)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            elevation: 0,

                          ),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "Delete",
                              desc: "Are you sure to delete this payment",
                              btnOkOnPress: () {
                                setState(() {
                                  deletepayment(num){

                                  }
                                });
                              },

                            ).show();
                          },),
                        SizedBox(width: 20,),

                      ],
                    ),

                  ],
                ),
              );
            }),
    );
  }
}
