import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/getaccountinfo.dart';
import 'package:truemoneyversion2/View/getdata.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/transaction_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  List<String> docIDs=['test'];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
              print(document.reference);
          setState(() {
            docIDs.add(document.reference.id);
          });
        })
    );
  }

  void dispose(){
    super.dispose();
  }

  void initState(){
    super.initState();
    getDocId();
    print(docIDs.length);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MTA My Wallet',
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
        body: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const TransactionLog()));
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Stack(
              children:[ Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Text(
                        //   'Eang Hengty\'s wallet',
                        //   style: TextStyle(color: Colors.white, fontSize: 16),
                        // ),
                        docIDs.length==2? getdata(documentid: docIDs[1]):Text(
                          'Your wallet',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: 3,color: Colors.white))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'USD',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              docIDs.length==2? getaccountinfo(documentid: docIDs[1],currency:'usdmoney'):Text(
                                '00.00',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border: Border(left: BorderSide(width: 3, color: Colors.white))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'KHR',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              docIDs.length==2? getaccountinfo(documentid: docIDs[1],currency:'khmoney'):Text(
                                '00.00',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              Positioned(child: Container(
                width: 150,
                height: 150,
                child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_q8mar8hq.json'),
              ),
              bottom: 0,
              right: 0,),
                Positioned(child: Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('lib/Assets/chip.png'),
                ),
                  bottom: 50,
                  left: 30,)]
            ),
          ),
        ));
  }
}
