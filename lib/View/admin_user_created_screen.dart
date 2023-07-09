import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/View/adminhomescreen.dart';
import 'package:truemoneyversion2/View/agent_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
class adminusercreatedaccount extends StatefulWidget {
  const adminusercreatedaccount({Key? key}) : super(key: key);

  @override
  State<adminusercreatedaccount> createState() => _AdminUserCreatedAccountState();
}

class _AdminUserCreatedAccountState extends State<adminusercreatedaccount> {

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
  Future openeditbox(int num){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title:Text('Edit '+ name[num] + " information"),
      content:SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: nameupdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'update name',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: phonenumberupdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'update phone number',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: jobtitleupdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'update job title',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: uidupdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'update uid',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: dobupdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'update date of birth',
              ),
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
              title: "Update information",
              desc: "Are you sure to change this?",
              btnOkOnPress: () {
                setState(() {
                  if(nameupdatecontroller.text.trim().toString()!=""){
                      updatename(num);
                  }
                  if(dobupdatecontroller.text.trim().toString()!=""){
                      updatedob(num);
                  }
                  if(uidupdatecontroller.text.trim().toString()!=""){
                      uidupdate(num);
                  }
                  if(jobtitleupdatecontroller.text.trim().toString()!=""){
                    updatejob(num);

                  }
                  if(phonenumberupdatecontroller.text.trim().toString()!=""){
                    updatephonenumber(num);

                  }
                });
              },
              btnCancelOnPress: () {

              }
          ).show();
        }, child: Text('Change'))
      ],
    ),

    );
  }

  Future updatename(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'fullname': nameupdatecontroller.text.trim()});
    print('status change to selected');
  }
  Future updatephonenumber(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'phonenumber': phonenumberupdatecontroller.text.trim()});
    print('status change to selected');}
  Future uidupdate(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'uid': uidupdatecontroller.text.trim()});
    print('status change to selected');}
  Future updatedob(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'dateofbirth': dobupdatecontroller.text.trim()});
    print('status change to selected');}
  Future updatejob(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'fullname': jobtitleupdatecontroller.text.trim()});
    print('status change to selected');}


  Future updatestatus(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'verifystatus': 'yes'});
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'accountactivated': 'yes'});
    print('status change to selected');
  }

  Future changetoadmin(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'userrole': 'admin'});
    print('status change to selected');
  }

  Future changetocustomer(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'userrole': 'customer'});
    print('status change to selected');
  }

  Future changetoagent(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'userrole': 'agent'});
    print('status change to selected');

  }
  Future disactivated(int num) async {
    await FirebaseFirestore.instance.collection('customer')
        .doc(doc[num])
        .update({'accountactivated': 'no'});
    print('status change to selected');

  }
    Widget list_user(
        {required String name, required String date, required String accountid, required int num, required String verify, required String status}) {
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
                ElevatedButton(
                  child: Text("change to admin ", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 0,

                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Change role to admin",
                        desc: "Are you sure to change this user to admin",
                        btnOkOnPress: () {
                          setState(() {
                            changetoadmin(num);
                          });
                        },
                        btnCancelOnPress: () {

                        }
                    ).show();
                  },),
                SizedBox(width: 20,),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("change to customer", style:
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
                      title: "Change role to customer",
                      desc: "Are you sure to change this user to customer",
                      btnOkOnPress: () {
                        setState(() {
                          changetocustomer(num);
                        });
                      },

                    ).show();
                  },),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text("change to agent", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 0,

                  ),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Change role to agent",
                      desc: "Are you sure to change this user to agent",
                      btnOkOnPress: () {
                        setState(() {
                          changetoagent(num);
                        });
                      },

                    ).show();
                  },),
                SizedBox(width: 20,),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("view national id", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,

                  ),
                  onPressed: () {

                  },),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text("Deactivate account ", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 0,

                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Disactivated account",
                        desc: "Are you sure?",
                        btnOkOnPress: () {
                          setState(() {
                            disactivated(num);
                          });
                        },

                    ).show();
                  },),
                SizedBox(width: 20,),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("edit info", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,

                  ),
                  onPressed: () {
                      setState(() {
                        openeditbox(num);
                      });
                  },),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text("add credit", style:
                  TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    elevation: 0,

                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        title: "Password not match",
                        desc: "Please try again",
                        btnOkOnPress: () {

                        },
                        btnCancelOnPress: () {

                        }
                    ).show();
                  },),
                SizedBox(width: 20,),

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
                        builder: (ctx) => const adminhomescreen()));
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
                status:accountstatus[index]);
              })

      );
    }

}
