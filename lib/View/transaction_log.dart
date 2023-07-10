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
  List<String> colorchange=[];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('transactionlog').where('uidowner',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            loglistdate.add(document['trandate']);
            loglistrec.add(document['tranrecname']);
            loglistsend.add(document['transendername']);
            currentamount.add(document['tranamount']);
            currencytype.add(document['currency']);
            currentrecid.add(document['tranreceiver']);
            currentsenderid.add(document['transenderid']);
            if(document['currency']=='USD' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' USD');
              colorchange.add('1');
            }else if(document['currency']=='USD' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("+ " + document['tranamount' ]+' USD');
              colorchange.add('0');
            }else if(document['currency']=='KH' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' KHR');
              colorchange.add('1');
            }else if(document['currency']=='KH' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid) {
              loglistamount.add("+ " + document['tranamount' ] + ' KHR');
              colorchange.add('0');
            }
            print(loglistdate[0]);
            // print(accountid.length);
            // listdocument.add(document.reference.id);
          });
        })
    );
  }
  List<String> currencytype=[];
  List<String> currentamount=[];
  List<String> currentsenderid=[];
  List<String> currentrecid=[];
  Future getDocId2() async{
    await FirebaseFirestore.instance.collection('transactionlog').where('uiddrec',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            loglistdate.add(document['trandate']);
            loglistrec.add(document['tranrecname']);
            loglistsend.add(document['transendername']);
            currentamount.add(document['tranamount']);
            currencytype.add(document['currency']);
            currentrecid.add(document['tranreceiver']);
            currentsenderid.add(document['transenderid']);
            if(document['currency']=='USD' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' USD');
              colorchange.add('0');
            }else if(document['currency']=='USD' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("+ " + document['tranamount' ]+' USD');
              colorchange.add('1');
            }else if(document['currency']=='KH' && document['tranreceiver'] == FirebaseAuth.instance.currentUser!.uid){
              loglistamount.add("- "+ document['tranamount' ]+' KHR');
              colorchange.add('0');
            }else if(document['currency']=='KH' && document['tranreceiver'] != FirebaseAuth.instance.currentUser!.uid) {
              loglistamount.add("+ " + document['tranamount' ] + ' KHR');
              colorchange.add('1');
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
  Widget log_show({required String date, required String log,required String name, required colors,required String sendername, required String recievername, required
  String currency, required amount, required senderid, required recid}){
    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (context)=>AlertDialog(
          title:Text(""),
          content:SingleChildScrollView(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_bdsthrsj.json'),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1)
                      ),
                      width:double.infinity,
                      padding:EdgeInsets.all(16),
                      margin:EdgeInsets.only(bottom: 20,top:5,left: 10,right: 10),
                      child: Column(
                          children: [
                            Center(child: Text('transfer from ' + sendername + " to " + recievername,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.white,
                              ),textAlign: TextAlign.center,),),
                            SizedBox(height: 20,),
                            Center(child: Text('Sender: ' + sendername + " - " + senderid,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.white,
                              ),textAlign: TextAlign.center,),),
                            SizedBox(height: 20,),
                            Center(child: Text('Reciever: ' + recievername+ " - " + recid,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.white,
                              ),textAlign: TextAlign.center,),),
                            SizedBox(height: 20,),

                            Text('Transfer amount: '+ double.parse(amount).toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white
                              ),),
                            SizedBox(height: 16,),
                            Text('Date: ' + date,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white
                              ),),
                            SizedBox(height: 16,),

                            Text('Currency: ' + currency.toString().toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white
                              ),),
                            SizedBox(height: 16,),

                          ])
                  ),]),


          ),
        ),);
      },
      child: Container(

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
                          Icon(Icons.currency_exchange),
                          SizedBox(width: 10,),
                          Text(sendername + ' transferred to ' + recievername, style: TextStyle(fontSize: 12),)
                        ],
                      )),
                      Container(child: Text(log,
                        style:TextStyle(
                          // color: log >= 0? Colors.green:Colors.red,
                          color: colors=='1'? Colors.red:Colors.red,
                        ),
                        textAlign: TextAlign.end,),)
                    ],
                  )
              )
            ],
          )
        ],
      ),
    ),) ;
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
            return log_show(date:loglistdate[index],log:loglistamount[index],name:loglistrec[index],colors:colorchange[index], sendername: loglistsend[index], recievername: loglistrec[index], currency: currencytype[index], amount: currentamount[index]
            ,senderid: currentsenderid[index],recid: currentrecid[index]);
          })
    );
  }
}
