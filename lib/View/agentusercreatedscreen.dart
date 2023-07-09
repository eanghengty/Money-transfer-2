import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
class agentusercreated extends StatefulWidget {
  const agentusercreated({super.key});

  @override
  State<agentusercreated> createState() => _agentusercreatedState();
}

class _agentusercreatedState extends State<agentusercreated> {
  List<String> name = [];
  List<String> date = [];
  List<String> verifystatus = [];
  List<String> accountid = [];
  List<String> uidlist = [];
  List<String> doc = [];
  List<String> accountstatus = [];



  void dispose() {
    super.dispose();
    getDocId();
  }
  List<String> enamount=[];
  List<String> khamount=[];
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('customer').where(
        'userrole', isNotEqualTo: 'admin').get().then(
            (snapshot) =>
            snapshot.docs.forEach((document) {
              setState(() {
                name.add(document['fullname']);
                date.add(document['createddate']);
                accountid.add(document['accountid']);
                uidlist.add(document['uid']);
                verifystatus.add(document['verifystatus']);
                accountstatus.add(document['accountactivated']);
                enamount.add(document['enmoney']);
                khamount.add(document['khmoney']);
                doc.add(document.reference.id);

              }

                // print(accountid.length);
                // listdocument.add(document.reference.id);
              );
            })
    );
  }

// Future getuserverificationstatus() async{
//   await FirebaseFirestore.instance.collection('accountverify').where('userrole',isNotEqualTo: 'admin').get().then(
//           (snapshot)=>snapshot.docs.forEach((document) {
//         setState(() {
//           name.add(document['fullname']);
//           date.add(document['createddate']);
//           accountid.add(document['accountid']);
//           uidlist.add(document['uid']);
//
//
//         }
//
//           // print(accountid.length);
//           // listdocument.add(document.reference.id);
//         );
//       })
//   );
// }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocId();
  }
  final nameupdatecontroller=TextEditingController();
  final phonenumberupdatecontroller=TextEditingController();
  final jobtitleupdatecontroller=TextEditingController();
  final uidupdatecontroller=TextEditingController();
  final dobupdatecontroller=TextEditingController();







  Future updatestatus(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'verifystatus': 'yes'});
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'accountactivated': 'yes'});
    print('status change to selected');
  }







  Widget list_user(
      {required String name, required String date, required String accountid, required int num, required String verify, required String status, required String kh, required String en}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1)
      ),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20, top: 5, left: 10, right: 10),
      child: Column(
        children: [
          Text('New user created ' + accountid + ' - ' + name,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 20,),
          Text('User created on ' + date,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text(verify == 'no'
              ? 'Identity not verify'
              : 'Identity already verified',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text(status == 'no'
              ? 'this status account: disactivated'
              : 'this status account: activated',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text('Current USD: '+ en,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Text('Current KHR: '+ kh,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("verify account", style:
                TextStyle(color: Colors.white,)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  elevation: 0,

                ),
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    title: "Activate and verify account",
                    desc: "Are you sure?",
                    btnOkOnPress: () {
                      setState(() {
                        updatestatus(num);
                      });
                    },

                  ).show();

                },),
              SizedBox(width: 20,),


            ],
          ),



        ],
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'User account mgmt',
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
                  CupertinoPageRoute(
                      builder: (ctx) => const AgentHomeScreen()));
            },
          ),
        ),
        body: name.length == 0 ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 350,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/temp/lf20_U1CPFF.json'),
            ),
            SizedBox(height: 16,),
            Text('Currently, no user created',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),)

          ],
        )) : ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {
              return list_user(name: name[index],
                date: date[index],
                accountid: accountid[index],
                num: index,
                verify: verifystatus[index],
                status:accountstatus[index],
                kh:khamount[index],
                en:enamount[index],);
            })

    );
  }

}

