import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/loading_transfer_completed.dart';
import 'package:truemoneyversion2/View/quick_payment_add.dart';
import 'package:truemoneyversion2/View/quick_transfer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class QuickTransferAdd extends StatefulWidget {
  const QuickTransferAdd({Key? key}) : super(key: key);

  @override
  State<QuickTransferAdd> createState() => _QuickTransferAddState();
}

class _QuickTransferAddState extends State<QuickTransferAdd> {


  final accountidcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final currentuser=FirebaseAuth.instance;
  void dipose(){
    accountidcontroller.dispose();
    descriptioncontroller.dispose();
    dispose();
  }
  Future addquicktransfer() async {
    await FirebaseFirestore.instance.collection('quicktransfer').add({
      'accountid':accountidcontroller.text.trim(),
      'description':descriptioncontroller.text.trim(),
      'uid':currentuser.currentUser!.uid,

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Add Transfer',
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
                  CupertinoPageRoute(builder: (ctx) => const QuickTransfer()));
            },
          ),
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,

                  child: Lottie.network('https://assets9.lottiefiles.com/private_files/lf30_24lawrru.json'),
                ),
                SizedBox(height:10),
                Text("Add quick Transfer",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: accountidcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account ID',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: descriptioncontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    'Tap on this "Confirm" button to confirm new transaction limit for your account'),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: Text("Confirm",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,
                  ),
                  onPressed: () {
                    addquicktransfer();
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (ctx) => const LoadingTransferCompleted()));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
