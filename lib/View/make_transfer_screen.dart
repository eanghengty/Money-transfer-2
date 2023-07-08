import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import'package:flutter/material.dart';
import'package:truemoneyversion2/View/quick_transfer.dart';
import'package:truemoneyversion2/View/loading_transfer_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class MakeTransfer extends StatefulWidget {

  const MakeTransfer({Key? key}) : super(key: key);


  @override
  State<MakeTransfer> createState() => _MakeTransferState();
}

class _MakeTransferState extends State<MakeTransfer> {

  List account_menu=['USD','KH'];
  String select_value='USD';
  List<dynamic> getrecieveramount=[];
  String currentdocrec="";
  String currentdocsen="";
  final senttoaccountid=TextEditingController();
  // String senttoaccountid="";
  final amountupdatecontroller=TextEditingController();
  String currencyupdatecontroller="";
  Future getrecieverid() async{
    await FirebaseFirestore.instance.collection('customer').where('accountid', isEqualTo: quicktransferuser[0]).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {
            getrecieveramount.add(document['enmoney']);
            getrecieveramount.add(document['khmoney']);
            getrecieveramount.add(document['fullname']);
            getrecieveramount.add(document['uid']);
            currentdocrec=document.reference.id;
          });
        })
    );
  }
  List<dynamic> limitset=[];
  Future getlimit() async{
    await FirebaseFirestore.instance.collection('quicklimit').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {
            limitset.add(document['setdate']);
            limitset.add(document['transferdailylimit']);
            limitset.add(document['withdrawamountlimit']);
            currentdocrec=document.reference.id;
          });
        })
    );
  }
  List<dynamic> quicktransferuser=[];
  String quickdocument="";
  Future getquicktransferuser() async{
    await FirebaseFirestore.instance.collection('quicktransfer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);

          if(document['status']=='selected'){
            setState(() {
              quicktransferuser.add(document['accountid']);
              quickdocument=document.reference.id;
              print('found');
              print("length "+quicktransferuser.length.toString());
              currentdocrec=document.reference.id;
            });
          }

        })
    );
  }
  Future updatequicktransferstatus() async{
    await FirebaseFirestore.instance.collection('quicktransfer').doc(quickdocument).update({'status':'unselected'});
    print('status change to selected');
  }
  Future createtransaction() async{
    await FirebaseFirestore.instance.collection('transactionlog').add({
      'tranamount':amountupdatecontroller.text.trim(),
      'trandate':DateTime.now().toString(),
      // 'tranreceiver':senttoaccountid.text.trim(),
      'tranreceiver':quicktransferuser[0],
      'tranrecname':getrecieveramount[2],
      'uidowner':FirebaseAuth.instance.currentUser!.uid,
      'uiddrec':getrecieveramount[3],
      'currency':currencyupdatecontroller,
    });
  }
  Future createnotification() async{
    await FirebaseFirestore.instance.collection('notification').add({
      'tranamount':amountupdatecontroller.text.trim(),
      'trandate':DateTime.now().toString(),
      // 'tranreceiver':senttoaccountid.text.trim(),
      'tranreceiver':quicktransferuser[0],
      'transender':getsenderamount[2],
      'tranrecname':getrecieveramount[2],
      'transenid':getsenderamount[3],
      'uidowner':FirebaseAuth.instance.currentUser!.uid,
      'uiddrec':getrecieveramount[3]
    });
  }

  List<dynamic> getsenderamount=[];
  Future getsenderid() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {
            getsenderamount.add(document['enmoney']);
            getsenderamount.add(document['khmoney']);
            getsenderamount.add(document['fullname']);
            getsenderamount.add(document['accountid']);
            currentdocsen=document.reference.id;
          });
        })
    );
  }
  void initState(){
    getrecieverid();
    getquicktransferuser();
    getlimit();

    getsenderid();
    super.initState();
  }
  Future updatetransactionlimit() async{

    if(currencyupdatecontroller=="USD"){
      int totalrec=int.parse(amountupdatecontroller.text.trim())+int.parse(getrecieveramount[0]);
      int totalsen=int.parse(getsenderamount[0])-int.parse(amountupdatecontroller.text.trim());
      await FirebaseFirestore.instance.collection('customer').doc(currentdocrec).update({'enmoney':totalrec.toString()});
      await FirebaseFirestore.instance.collection('customer').doc(currentdocsen).update({'enmoney':totalsen.toString()});
    }else if(currencyupdatecontroller=="KH"){
      int totalrec=int.parse(amountupdatecontroller.text.trim())+int.parse(getrecieveramount[1]);
      int totalsen=int.parse(getsenderamount[1])-int.parse(amountupdatecontroller.text.trim());
      await FirebaseFirestore.instance.collection('customer').doc(currentdocrec).update({'khmoney':totalrec.toString()});
      await FirebaseFirestore.instance.collection('customer').doc(currentdocsen).update({'enmoney':totalsen.toString()});
    }

  }

  my_form_state(){
    select_value=account_menu[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Transfer money',
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
              updatequicktransferstatus();
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
                Text("Make a Transfer",
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
                DropdownButtonFormField(
                  onChanged:(new_value){
                    setState(() {
                      select_value=new_value as String;
                      currencyupdatecontroller=new_value;
                    });},
                  items: account_menu.map((value_item){
                    return DropdownMenuItem(child: Text(value_item),value: value_item,);
                  }).toList(),
                  decoration: InputDecoration(
                      labelText: 'Credit Account seletection'
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  enabled: false,
                  // controller: senttoaccountid,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: quicktransferuser.length==1?'Account ID: '+quicktransferuser[0]:'Account ID',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: amountupdatecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
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
                // ElevatedButton(
                //   child: Text("Confirm",
                //       style: TextStyle(
                //         color: Colors.white,
                //       )),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.lightBlue,
                //     elevation: 0,
                //   ),
                //
                //   onPressed: () {}
                // ),
                AnimatedButton(
                  text:'tansfer now',
                  color: Colors.green,
                  pressEvent: (){
                    getrecieverid();
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "transfer now",
                        desc: "Are you sure?",
                        btnCancelOnPress: (){},
                        btnOkOnPress: (){
                        print('process start');
                        print(getrecieveramount.length);
                        if(getrecieveramount.length>=3){

                        getsenderid();
                         print('get reciever amount work');
    }

                        if(getsenderamount.length>=3){
                        print('operation work');
                        print(amountupdatecontroller.text.trim().toString());
                        print(getsenderamount[0]);
                        if(currencyupdatecontroller=='USD' && int.parse(amountupdatecontroller.text.trim().toString())>int.parse(getsenderamount[0])){
                          AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Transacion Error",
                       desc: "Your current amount is not enough.",
                        btnOkOnPress: (){
                        }
                        ).show();

                        }else if(currencyupdatecontroller=='USD' && int.parse(amountupdatecontroller.text.trim())<=int.parse(getsenderamount[0])){
                        if(int.parse(amountupdatecontroller.text.trim().toString())<int.parse(limitset[2])){
                          print("limit amount:"+limitset[2]);
                          print("send amount:"+ amountupdatecontroller.text.trim().toString());
                          updatequicktransferstatus();
                          createtransaction();
                          createnotification();
                        updatetransactionlimit();
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(
                         builder: (ctx) => const LoadingTransferSuccess()));
                        }else{
                        AwesomeDialog(
                        context: context, dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Transacion Error",
                        desc: "Your amount that need to send is over limit.",
                        btnOkOnPress: (){
                        }
                        ).show();
                        }

                        }
                if(currencyupdatecontroller=='KH' && int.parse(amountupdatecontroller.text.trim())>int.parse(getsenderamount[1])){
                AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "Transacion Error",
                desc: "Your current amount is not enough.",
                btnOkOnPress: (){
                }
                ).show();
                }else if(currencyupdatecontroller=='KH' && int.parse(amountupdatecontroller.text.trim())<=int.parse(getsenderamount[1])){
                if(int.parse(amountupdatecontroller.text.trim().toString())<int.parse(limitset[2])){
                  updatequicktransferstatus();
                  createtransaction();
                  createnotification();
                updatetransactionlimit();
                Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (ctx) => const LoadingTransferSuccess()));
                }else{
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Transacion Error",
                      desc: "Your amount that need to send is over limit.",
                      btnOkOnPress: (){
                      }
                  ).show();
                }
    }

    }


    },

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
