import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:truemoneyversion2/View/agent_transaction_request_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class agentrequest extends StatefulWidget {
  const agentrequest({Key? key}) : super(key: key);

  @override
  State<agentrequest> createState() => _agentrequestState();
}

class _agentrequestState extends State<agentrequest> {

  List<String> listagentid=[];
  List<String> listcurrencytype=[];
  List<String> listcustomeruid=[];
  List<String> listdepositamount=[];
  List<String> listtransactionstatus=[];
  List<String> listwithdrawamount=[];
  List<String> listdate=[];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('agent').get().then(
            (snapshot) =>
            snapshot.docs.forEach((document) {
              setState(() {
                listagentid.add(document['agentuid']);
                listcurrencytype.add(document['currencytype']);
                listcustomeruid.add(document['customeruid']);
                listdepositamount.add(document['depositamount']);
                listtransactionstatus.add(document['transactionstatus']);
                listwithdrawamount.add(document['withdrawamount']);
                listdate.add(document['createddate'][0]);

              }

                // print(accountid.length);
                // listdocument.add(document.reference.id);
              );
            })
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocId();
  }





  @override
  Widget list_request({required agentid, required currency, required customerid, required amount, required status, required widthraw,required date, required int num}){
    return Container(
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
          Text('New request From user ' + agentid,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Status:  ' + status,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.white
                ),),
              SizedBox(width: 20,),
              ElevatedButton(
                child: Text("View details", style:
                TextStyle(color: Colors.white,)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  elevation: 0,

                ),
                onPressed: () {
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
                                    Text('request from ' + agentid + " to " + customerid,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.white
                                      ),),
                                    SizedBox(height: 20,),
                                    Text(double.parse(widthraw)>0? 'transfer status : withdraw': 'transfer status : deposit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.white
                                      ),),
                                    SizedBox(height: 20,),
                                    Text('current status : ' + status,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.white
                                      ),),
                                    SizedBox(height: 20,),
                                    Text('Transfer amount: '+ (double.parse(widthraw)>0?double.parse(amount).toStringAsFixed(2):double.parse(widthraw).toStringAsFixed(2)),
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
                                    Text('To: ' + customerid,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white
                                      ),),
                                    SizedBox(height: 16,),
                                    Text('Currency: ' + currency[num].toUpperCase(),
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

                },),
            ],
          )
        ],
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MTA transaction requests',
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
                  CupertinoPageRoute(builder: (ctx) => const AgentHomeScreen()));
            },
          ),
        ),
        body:listtransactionstatus.length == 0 ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 350,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
            ),
            SizedBox(height: 16,),
            Text('Currently, no user request',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),)

          ],
        )) : ListView.builder(
            itemCount: listtransactionstatus.length,
            itemBuilder: (context, index) {
              return list_request(date: listdate[index],
                agentid: listagentid[index],
                amount: listdepositamount[index],
                widthraw: listwithdrawamount[index],
                currency: listcurrencytype,
                status:listtransactionstatus[index],
                customerid: listcustomeruid[index],
                num:index
              );
            })
    );
  }
}
