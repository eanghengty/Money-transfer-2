import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/scanqrnow.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'authscreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class qrscanner extends StatefulWidget {
  const qrscanner({Key? key}) : super(key: key);

  @override
  State<qrscanner> createState() => _qrscannerState();
}


class _qrscannerState extends State<qrscanner> {
  @override

  List<String> customer=[];
  Future getinfo() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
           customer.add(document['accountid']);

          }
          );
          print(customer.length);

        })
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getinfo();

  }

  @override
  final qr = TextEditingController();
  Widget build(BuildContext context) {

    return MaterialApp(
        home:Scaffold(
          appBar: AppBar(title: Center(child:Text('Show QR for transfer')),),
          backgroundColor: Colors.grey[200],
          body: customer.length ==0 ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_psckabiq.json'),
                ),
                SizedBox(height: 16,),
                Text('Loading to QC.')
              ],
            ),
          )
        :Center(
              child:Container(
                height: 500,
                child: Column(

                  children: [
                    Text('Account id: ' + customer[0],style: TextStyle(fontSize: 18,color: Colors.black),),
                    SizedBox(
                      height: 16,
                    ),
                    QrImageView(
                      data: qr.text,
                      size:200,
                      backgroundColor: Colors.white,),
                    SizedBox(
                      height: 16,
                    ),
                    AnimatedButton(
                      text:'Scan QR',
                      color: Colors.orange,
                      pressEvent: (){
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "QR Scan",
                            desc: "Want to scan other QR?",
                            btnOkOnPress: (){
                              // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const scanqrnow()) );
                            },
                            btnCancelOnPress: (){
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const HomeScreen()) );
                            }
                        ).show();
                      },
                    )


                  ],
                ),
              )
          ),
        )
    );
  }
}
