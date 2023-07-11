import'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truemoneyversion2/View/loadingcompletedsetlimit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class QuickTransaction extends StatefulWidget {
  const QuickTransaction({Key? key}) : super(key: key);

  @override
  State<QuickTransaction> createState() => _QuickTransactionState();
}

class _QuickTransactionState extends State<QuickTransaction> {

  List<dynamic> docIDs=['test'];
  String currentdoc="";

  Future getDocId() async{
    await FirebaseFirestore.instance.collection('quicklimit').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {
            currentdoc=document.reference.id;
            docIDs.add(int.parse(document['transferdailylimit']));
            docIDs.add(double.parse(document['enmoney']));
            docIDs.add(double.parse(document['khmoney']));
            docIDs.add(document['setdate']);
            print(docIDs.length);
          });
        })
    );
  }
  final updatetransferdailylimitcontroller=TextEditingController();
  final updatewithdrawamountlimitcontroller=TextEditingController();
  final updatekhlimitcontroller=TextEditingController();
  String updatedatelimitcontroller="";
  Future updatetransactionlimit() async{
   await FirebaseFirestore.instance.collection('quicklimit').doc(currentdoc).update({'transferdailylimit':updatetransferdailylimitcontroller.text.trim(), 'enmoney':updatewithdrawamountlimitcontroller.text.trim(),'setdate':updatedatelimitcontroller
   ,'khmoney':updatekhlimitcontroller.text.trim()});
  }
  void initState(){
    getDocId();
    super.initState();
  }
  final transferdailylimitcontroller = TextEditingController();
  final withdrawamountlimitcontroller=TextEditingController();
  final datelimitcontroller=TextEditingController();
  final currentuser=FirebaseAuth.instance;
  DateTime setcastdatecontroller= DateTime.now();
  String setdatecontroller="";
  final khlimitcontroller=TextEditingController();
  void dipose(){
    transferdailylimitcontroller.dispose();
    withdrawamountlimitcontroller.dispose();
    dispose();
  }
  List<String> date=[];
  Future addquicktransactionlimit() async {
    await FirebaseFirestore.instance.collection('quicklimit').add({
      'transferdailylimit':transferdailylimitcontroller.text.trim(),
      'enmoney':withdrawamountlimitcontroller.text.trim(),
      'khmoney':khlimitcontroller.text.trim(),
      'setdate':date[0],
      'uid':currentuser.currentUser!.uid,

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Quick Transaction Limit',
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
          child: docIDs.length==5?Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,

                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_GXS1DssMnR.json'),
                ),
                SizedBox(height:10),
                Text("Transaction limit",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: updatetransferdailylimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current daily trasaction set to '+ docIDs[1].toString(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: updatewithdrawamountlimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current USD amount set to '+ docIDs[2].toString(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: updatekhlimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current KHR amount set to '+ docIDs[3].toString(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current date set to '+ docIDs[4].toString(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  onPressed: (){
                    showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(2000),lastDate: DateTime(2025)).then((value) =>
                    setState((){
                    setcastdatecontroller=value!;
                    updatedatelimitcontroller=setcastdatecontroller.toString();
                    }));},
                    color: Colors.blue,
                  child:Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Set date',style: TextStyle(color: Colors.white,fontSize: 16),),

                  )
                ),
                SizedBox(
                  height: 16,
                ),
                // Text(
                //     'Tap on this "Confirm" button to confirm new transaction limit for your account'),
                // SizedBox(
                //   height: 16,
                // ),
                // ElevatedButton(
                //   child: Text("Update",
                //       style: TextStyle(
                //         color: Colors.white,
                //       )),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.lightBlue,
                //     elevation: 0,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       updatetransactionlimit();
                //     });
                //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
                //         builder: (ctx) => const loadingcompletedsetlimit()));
                //   },
                // ),
                AnimatedButton(
                  text:'Update',
                  color: Colors.orange,
                  pressEvent: (){
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "update limit now",
                        desc: "Are you sure",
                        btnCancelOnPress: (){},
                        btnOkOnPress: (){
                          setState(() {
                            date=datelimitcontroller.toString().split(" ");
                            updatetransactionlimit();
                          });
                          Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (ctx) => const loadingcompletedsetlimit()));
                        }
                    ).show();
                  },
                ),
              ],
            ),
          ):Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,

                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_GXS1DssMnR.json'),
                ),
                SizedBox(height:10),
                Text("Transaction limit",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: transferdailylimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number of Transfer daily',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                TextField(
                  controller: withdrawamountlimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'limit USD amount',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: khlimitcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'limit KHR amount',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                    onPressed: (){
                      showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(2000),lastDate: DateTime(2025)).then((value) =>
                          setState((){
                            setcastdatecontroller=value!;
                            setdatecontroller=setcastdatecontroller.toString();
                          }));},
                    color: Colors.blue,
                    child:Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Set date',style: TextStyle(color: Colors.white,fontSize: 16),),

                    )
                ),
                SizedBox(
                  height: 16,
                ),
                // Text(
                //     'Tap on this "Confirm" button to confirm new transaction limit for your account'),
                // SizedBox(
                //   height: 16,
                // ),
                // ElevatedButton(
                //   child: Text("Confirm",
                //       style: TextStyle(
                //         color: Colors.white,
                //       )),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.lightBlue,
                //     elevation: 0,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       addquicktransactionlimit();
                //     });
                //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
                //         builder: (ctx) => const loadingcompletedsetlimit()));
                //   },
                // ),
                AnimatedButton(
                  text:'set limit',
                  color: Colors.orange,
                  pressEvent: (){
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "set limit now",
                        desc: "Are you sure",
                        btnCancelOnPress: (){},
                        btnOkOnPress: (){
                              setState(() {
                                date=setdatecontroller.toString().split(" ");
                                addquicktransactionlimit();
                              });
                              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                                  builder: (ctx) => const loadingcompletedsetlimit()));
                        }
                    ).show();
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
