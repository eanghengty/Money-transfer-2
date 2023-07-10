import'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/Drawbar_view/setting.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ViewDetail extends StatefulWidget {
  const ViewDetail({Key? key}) : super(key: key);

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {

  List<String> getaccountinfo=[];
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('customer').where(
        'uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot) =>
            snapshot.docs.forEach((document) {
              setState(() {
                getaccountinfo.add(document['fullname']);
                getaccountinfo.add(document['phonenumber']);
                getaccountinfo.add(document['jobselection']);
                getaccountinfo.add(document['dateofbirth']);
                getaccountinfo.add(document['province']);
                getaccountinfo.add(document['avgdeposit']);
                print(getaccountinfo[0]);
                print(getaccountinfo[1]);
                print(getaccountinfo[2]);
                print(getaccountinfo[3]);
              });
            })
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocId();
  }
  Widget list_of_detail({required String title, required Icon icon_data, required String description}){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5,right:30,left: 5),
      decoration: BoxDecoration(
          border:Border(bottom: BorderSide(width: 1))
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [


          Row(
            children: [
              SizedBox(width: 10,),
              icon_data,
              Expanded(child: Text(description,textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),),

            ],
          ),
          SizedBox(height: 3,),
          Container(
            width: double.infinity,
            child: Text(title,),
          ),
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
            'Account Details',
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
                CupertinoPageRoute(builder: (ctx) => const Setting()));
          },
        ),
      ),
      body: getaccountinfo.length==6?SingleChildScrollView(
        child: Container(
          width: double.infinity,

          child: Column(
            children: [
              Container(
                  color: Colors.blue[800],
                padding: EdgeInsets.all(16),
                height: 250,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_z3pnisgt.json'),
                      ),
                      SizedBox(height: 16,),
                      Text('Hi, '+ getaccountinfo[0],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),)
                    ],
                  ),
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color:Colors.grey[200],
                child: Text('Your information',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),),
              ),
              Column(
                children: [
                  list_of_detail(title:'Full Name',
                      icon_data:Icon(Icons.account_circle_rounded,size: 35,),
                  description: getaccountinfo[0]),
                  list_of_detail(title:'Phone Number',
                      icon_data:Icon(Icons.phone_android_rounded,size: 35,),
                      description: getaccountinfo[1]),
                  list_of_detail(title:'Date of Birth',
                      icon_data:Icon(Icons.date_range_rounded,size: 35,),
                      description: getaccountinfo[3]),
                  list_of_detail(title:'Province',
                      icon_data:Icon(Icons.place_sharp,size: 35,),
                      description: getaccountinfo[4]),
                  list_of_detail(title:'Career type',
                      icon_data:Icon(Icons.work,size: 35,),
                      description: getaccountinfo[2]),
                  list_of_detail(title:'Deposit Range',
                      icon_data:Icon(Icons.monetization_on,size: 35,),
                      description: getaccountinfo[5]+' \$'),
                ],
              )
            ],
          ),
        ),
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_a2chheio.json'),
            ),
            SizedBox(height: 16,),
            Text('setting up transaction limit')
          ],
        ),
      ),
    );
  }
}
