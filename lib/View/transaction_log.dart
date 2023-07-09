import'package:lottie/lottie.dart';
import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionLog extends StatefulWidget {
  const TransactionLog({Key? key}) : super(key: key);

  @override
  State<TransactionLog> createState() => _TransactionLogState();
}

class _TransactionLogState extends State<TransactionLog> {

  List<String> transaction=[];
  // Future getlog() async{
  //   await FirebaseFirestore.instance.collection('transactionlog').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
  //           (snapshot)=>snapshot.docs.forEach((document) {
  //         setState(() {
  //           transaction.add(document['tranamount']);
  //           transaction.add(document['trandate']);
  //           transaction.add(document['tranreceiver']);
  //           transaction.add(document['tranrecname']);
  //           print(transaction.length);
  //         });
  //
  //       })
  //   );}
  List<String> loglistdate=[];
  List<String> loglistamount=[];
  List<String> loglistrec=[];
  List<String> loglistsend=[];
  // List<String> description=[];
  // String currentdoc="";
  List<String> listdocument=[];
  int number=0;
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('transactionlog').where('uidowner',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            loglistdate.add(document['trandate']);
            loglistrec.add(document['tranreceiver']);
            if(document['currency']=='USD' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' USD');
            }else if(document['currency']=='USD' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("+ " + document['tranamount' ]+' USD');
            }else if(document['currency']=='KHR' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' KHR');
            }else if(document['currency']=='KHR' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid) {
              loglistamount.add("+ " + document['tranamount' ] + ' KHR');
            }
            print(loglistdate[0]);
            // print(accountid.length);
            // listdocument.add(document.reference.id);
          });
        })
    );
  }
  Future getDocId2() async{
    await FirebaseFirestore.instance.collection('transactionlog').where('uiddrec',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            loglistdate.add(document['trandate']);
            loglistrec.add(document['tranreceiver']);
            if(document['currency']=='USD' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' USD');
            }else if(document['currency']=='USD' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("+ " + document['tranamount' ]+' USD');
            }else if(document['currency']=='KHR' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' KHR');
            }else if(document['currency']=='KHR' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid) {
              loglistamount.add("+ " + document['tranamount' ] + ' KHR');
            }
            print(loglistdate[0]);
            // print(accountid.length);
            // listdocument.add(document.reference.id);
          });
        })
    );
  }

  void initState(){
    getDocId();
    getDocId2();
    super.initState();
  }
  Widget log_show({required String date, required String log,required String name}){
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
                          Text(name),
                          SizedBox(width: 10,),
                        ],
                      )),
                      Expanded(child: Text(log,
                        style:TextStyle(
                          // color: log >= 0? Colors.green:Colors.red,
                          color: Colors.green
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
                  CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
            },
          ),
        ),
        // body:SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         height: 150,
        //         color: Colors.blue[800],
        //         child: Center(
        //           child:Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text('Eang Hengty\'s Wallet',
        //               style:TextStyle(color:Colors.white)),
        //               SizedBox(height: 10,),
        //               Text('AID:00010',
        //               style: TextStyle(color:Colors.white
        //               ),)
        //             ],
        //           )
        //         ),
        //       ),


            // ],

        //   ),
        // )
      body:loglistamount.length==0?Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 350,
            child:Lottie.network('https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
          ),
          SizedBox(height: 16,),
          Text('Currently, no transaction log',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),)
        ],
      )): ListView.builder(
          itemCount: loglistamount.length,
          itemBuilder: (context,index){
            return log_show(date:loglistdate[index],log:loglistamount[index],name:loglistrec[index]);
          })
    );
  }
}
