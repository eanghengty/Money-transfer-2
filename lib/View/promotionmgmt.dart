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
class promotionmgmt extends StatefulWidget {
  const promotionmgmt({Key? key}) : super(key: key);

  @override
  State<promotionmgmt> createState() => _promotionmgmtState();
}

class _promotionmgmtState extends State<promotionmgmt> {
  @override

  List<String> promotionname=[];
  List<String> promotiondiscount=[];
  List<String> promotiondescription=[];
  List<String> promotioncode=[];
  List<String> promotionenddate=[];
  List<String> promotionstartdate=[];

  Future getpromotionmgmt() async{
    await FirebaseFirestore.instance.collection('quickpromotion').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            promotionname.add(document['name']);
            promotiondescription.add(document['description']);
            promotioncode.add(document['code']);
            promotiondiscount.add(document['discount']);
            promotionenddate.add(document['endate']);
            promotionstartdate.add(document['startdate']);

          }


            // print(accountid.length);
            // listdocument.add(document.reference.id);
          );
          print(promotionname.length);
        })
    );
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getpromotionmgmt();



  }





  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Promotions service mgmt',
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
      body:promotionname.length == 0 ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 350,
            child: Lottie.network(
                'https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
          ),
          SizedBox(height: 16,),
          Text('Currently, no promotions',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),)

        ],
      )) : ListView.builder(
          itemCount: promotionname.length,
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
                    Text('Promotions name: ' + promotionname[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 20,),
                    Text('start date: ' + promotionstartdate[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('Enddate: ' + promotionenddate[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('description: ' +promotiondescription[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('discount percentage: ' + promotiondiscount[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    SizedBox(height: 16,),
                    Text('promotion discount code: ' + promotioncode[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text("Edit promotions", style:
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
                          child: Text("Delete promotions ", style:
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
