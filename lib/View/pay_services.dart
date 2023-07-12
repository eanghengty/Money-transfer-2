import'package:lottie/lottie.dart';
import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/list_of_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PayServices extends StatefulWidget {
  const PayServices({Key? key}) : super(key: key);

  @override
  State<PayServices> createState() => _PayServicesState();
}

class _PayServicesState extends State<PayServices> {

  List<String> getaccountid=[];
  List<String> getamount=[];
  List<String> getcategroy=[];
  List<String> getcurrency=[];
  List<String> getdescription=[];
  List<String> getname=[];
  List<String> getdoc=[];
  Future getpaymentservices() async{
    await FirebaseFirestore.instance.collection('quickpayment').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {
            getaccountid.add(document['accountid']);
            getamount.add(document['amount']);
            getcategroy.add(document['category']);
            getcurrency.add(document['currency']);
            getname.add(document['name']);
            getdescription.add(document['description']);
            getdoc.add(document.reference.id);
          });
          // getmydoc();
          getcustomer();
          for (int i=0; i<getaccountid.length;i++){
            createtransaction(i);
          }
              print(getaccountid.length);
        })
    );
  }
  List<String> date = [];
  Future createtransaction(int num) async {
    await FirebaseFirestore.instance.collection('transactionlog').add({
      'tranamount': getcurrentuseramount[0],
      'trandate': date[0],
      // 'tranreceiver':senttoaccountid.text.trim(),
      'tranreceiver': getaccountid[num],
      'tranrecname': getname[num],
      'uidowner': FirebaseAuth.instance.currentUser!.uid,
      'uiddrec': getamount[num],
      'currency': getcurrency[num],
      'transendername': getcurrentcustomername[num],
      'transenderid': getcurrentcustomerid[num],
    });
  }
  List<String> getcurrentuseramount=[];
  List<String> getcustomerdoc=[];
  List<String> getcurrentcustomername=[];
  List<String> getcurrentcustomerid=[];
  Future getcustomer() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            getcurrentuseramount.add(document['enmoney']);
            getcurrentcustomerid.add(document['accountid']);
            getcustomerdoc.add(document.reference.id);
            getcurrentcustomername.add(document['fullname']);

          }

            // print(accountid.length);
            // listdocument.add(document.reference.id);
          );
        })
    );
  }

  final buyamountcontroller=TextEditingController();


  void initState(){
    super.initState();
    getpaymentservices();

  }

  Future payment(int num) async{
        double totalrec=double.parse(getcurrentuseramount[0])+double.parse(getamount[num]);
        double totalsen=double.parse(getcurrentuseramount[0])-double.parse(buyamountcontroller.text.trim().toString());
        await FirebaseFirestore.instance.collection('quickpayment').doc(getdoc[num]).update({'amount':totalrec.toStringAsFixed(2)});
        await FirebaseFirestore.instance.collection('customer').doc(getcustomerdoc[num]).update({'enmoney':totalsen.toStringAsFixed(2)});
        print(getcurrentuseramount[0]);
        print(totalrec);
  }


  Widget feature_service({ required String name, required String description, required int num}){
    return InkWell(
      onTap: (){
        showDialog(context:context, builder: (context)=>AlertDialog(
          title:Text('Create new service'),
          content:SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  enabled: false,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account id: ' + getaccountid[num],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Account name: ' + getname[num],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Currency: ' + getcurrency[num],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: buyamountcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the amount',
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Make payment",
                  desc: "Make payment now?",
                  btnOkOnPress: () {
                    setState(() {
                      createtransaction(num);
                      payment(num);
                    });
                  },
                  btnCancelOnPress: () {

                  }
              ).show();
            }, child: Text('Pay'))
          ],
        ),);
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
            children: [
        Container(

        child:Image.asset('lib/Assets/payment.png'),

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

            child: Text(name,
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
              'MTA Pay Services',
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
        body:getaccountid.length == 0 ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 350,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
            ),
            SizedBox(height: 16,),
            Text('Currently, no payment services',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),)

          ],
        )) : ListView.builder(
            itemCount: getaccountid.length,
            itemBuilder: (context, index) {
              return feature_service(name: getname[index],
                description: getdescription[index], num:index);
            })
    );
  }
}
