import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/quick_transfer_add.dart';
import'package:truemoneyversion2/View/make_transfer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
class QuickTransfer extends StatefulWidget {
  const QuickTransfer({Key? key}) : super(key: key);

  @override
  State<QuickTransfer> createState() => _QuickTransferState();
}

class _QuickTransferState extends State<QuickTransfer> {

  List<String> accountid=[];
  List<String> description=[];
  String currentdoc="";
  List<String> listdocument=[];
  int number=0;
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('quicktransfer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            accountid.add(document['accountid']);
            description.add(document['description']);
            print(accountid.length);
            listdocument.add(document.reference.id);
          });
        })
    );
  }
  Future updatequicktransferstatus() async{

    await FirebaseFirestore.instance.collection('quicktransfer').doc(currentdoc).update({'status':'selected'});
    print('status change to selected');
  }
  @override
  void initState() {
    getDocId();
    // TODO: implement initState
    super.initState();
  }

  Widget user({required String icon, required String text, required String description, required int num}){
    return InkWell(
      onTap: (){
        setState(() {
          number=num;
          currentdoc=listdocument[number];
        });
        updatequicktransferstatus();
        Navigator.of(context).pushReplacement(

            CupertinoPageRoute(builder: (ctx) => const MakeTransfer()));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(

              child:Image.asset(icon),

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

                  child: Text('AID: '+text,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: 3,),
                Container(
                  width: 300,

                  child: Text('Account info: '+description),
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
            'Quick Transfer',
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const QuickTransferAdd()));
          },
          child:Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue[800],
        ),
      body: accountid.length==0?Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 350,
            child:Lottie.network('https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
          ),
          SizedBox(height: 16,),
          Text('Currently, no user in quick list',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),)
        ],
      )): ListView.builder(
          itemCount: accountid.length,
          itemBuilder: (context,index){
            return user(icon:'lib/Assets/user.png',text:accountid[index],
                description: description[index], num:index);
          })


    );
  }
}
