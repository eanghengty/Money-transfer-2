
import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import 'package:truemoneyversion2/Drawbar_view/exchange_rate.dart';
import 'package:truemoneyversion2/Drawbar_view/location.dart';
import 'package:truemoneyversion2/Drawbar_view/setting.dart';
import 'package:truemoneyversion2/Drawbar_view/term_and_condition.dart';
import 'package:truemoneyversion2/View/admin_post.dart';
import 'package:truemoneyversion2/View/admin_transaction_log.dart';
import 'package:truemoneyversion2/View/admin_user_created_screen.dart';
import 'package:truemoneyversion2/View/agent_post.dart';
import 'package:truemoneyversion2/View/adminrequest.dart';
import 'package:truemoneyversion2/View/agent_transaction_log.dart';

import 'package:truemoneyversion2/View/notification_agent_screen.dart';
import 'package:truemoneyversion2/View/notificationadminscreen.dart';
import 'package:truemoneyversion2/View/paymentmgmt.dart';
import 'package:truemoneyversion2/View/promotionmgmt.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class adminhomescreen extends StatefulWidget {
  const adminhomescreen({Key? key}) : super(key: key);

  @override
  State<adminhomescreen> createState() => _adminhomescreenState();
}

// Future createnewuser(){
//   return showDialog(context: context, builder: (context)=>AlertDialog(
//     title:Text('Create new user'),
//     content:SingleChildScrollView(
//       child: Column(
//         children: [
//           TextField(
//             autofocus: true,
//             controller: namecontroller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'create user fullname',
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           TextField(
//             controller: phonenumbercontroller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'create user phone number',
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           TextField(
//             controller: jobtitlecontroller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'create user job title',
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           TextField(
//             controller: uidupdatecontroller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'update uid',
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           TextField(
//             controller: dobupdatecontroller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'update date of birth',
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       TextButton(onPressed: (){
//         AwesomeDialog(
//             context: context,
//             dialogType: DialogType.warning,
//             animType: AnimType.topSlide,
//             showCloseIcon: true,
//             title: "Update information",
//             desc: "Are you sure to change this?",
//             btnOkOnPress: () {
//               setState(() {
//                 if(nameupdatecontroller.text.trim().toString()!=""){
//                   updatename(num);
//                 }
//                 if(dobupdatecontroller.text.trim().toString()!=""){
//                   updatedob(num);
//                 }
//                 if(uidupdatecontroller.text.trim().toString()!=""){
//                   uidupdate(num);
//                 }
//                 if(jobtitleupdatecontroller.text.trim().toString()!=""){
//                   updatejob(num);
//
//                 }
//                 if(phonenumberupdatecontroller.text.trim().toString()!=""){
//                   updatephonenumber(num);
//
//                 }
//               });
//             },
//             btnCancelOnPress: () {
//
//             }
//         ).show();
//       }, child: Text('Change'))
//     ],
//   ),
//
//   );
// }





class _adminhomescreenState extends State<adminhomescreen> {

  // final descriptioncontroller=TextEditingController();
  // final discountcontroller=TextEditingController();
  //
  // final typecontroller=TextEditingController();
  // final servicesntroller=TextEditingController();
  //
  // Future createservices() async{
  //   await FirebaseFirestore.instance.collection('quickservices').add({
  //     'description':descriptioncontroller.text.trim(),
  //     'discount':discountcontroller.text.trim(),
  //     // 'tranreceiver':senttoaccountid.text.trim(),
  //     'enddate':enddatecontroller.text.trim(),
  //     'services':servicesntroller.text.trim(),
  //     'startdate':startdatecontroller.text.trim(),
  //     'type':typecontroller.text.trim(),
  //
  //   });
  // }
  final descriptionpaymentcontroller=TextEditingController();
  final namepaymentcontroller=TextEditingController();
  final accountidcontroller=TextEditingController();
  final paymentcurrencycontroller=TextEditingController();
  final paymentcategorycontroller=TextEditingController();

  Future createpayment() async{
    await FirebaseFirestore.instance.collection('quickpayment').add({
      'description':descriptionpaymentcontroller.text.trim(),
      'name':namepaymentcontroller.text.trim(),
      'accountid':accountidcontroller.text.trim(),
      'currency':paymentcurrencycontroller.text.trim(),
      'amount':'0'
    });
  }

  final descriptionpromotioncontroller=TextEditingController();
  final namepromotioncontroller=TextEditingController();
  // final promotioncategorycontroller=TextEditingController();
  final promotiondiscountpercentagecontroller=TextEditingController();
  final promotiondiscountcodecontroller=TextEditingController();
  final promotionenddatecontroller=TextEditingController();
  final promotionstartdatecontroller=TextEditingController();


  Future createpromotions() async{
    await FirebaseFirestore.instance.collection('quickpromotion').add({
      'description':descriptionpromotioncontroller.text.trim(),
      'name':namepromotioncontroller.text.trim(),
      // 'category':promotioncategorycontroller.text.trim(),
      'discount':promotiondiscountpercentagecontroller.text.trim(),
      'code':promotiondiscountcodecontroller.text.trim(),
      'endate':promotionenddatecontroller.text.trim(),
      'startdate':promotionstartdatecontroller.text.trim()
    });
  }

  Future createquickservice(){
    return showDialog(context:context, builder: (context)=>AlertDialog(
      title:Text('Create new service'),
      content:SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller:descriptionpromotioncontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create service description',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: promotiondiscountpercentagecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create discount percentage',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller:promotionenddatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create end date dd:mm:yy',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: promotionstartdatecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create start date dd:mm:yy',
              ),
            ),

            SizedBox(
              height: 16,
            ),
            TextField(
              controller: namepromotioncontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create services name',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller:promotiondiscountcodecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create code',
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
              title: "Create new services",
              desc: "Are you sure to create this?",
              btnOkOnPress: () {
                  setState(() {
                    createpromotions();
                  });
              },
              btnCancelOnPress: () {

              }
          ).show();
        }, child: Text('Create'))
      ],
    ),

    );
  }

  showpaymentmgmt(){
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> paymentmgmt()));

  }
  showpromotionmgmt(){
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> promotionmgmt()));

  }

  Future createpaymentservices(){
    return showDialog(context:context, builder: (context)=>AlertDialog(
      title:Text('Payment mgmt'),
      content:SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: descriptionpaymentcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create payment description',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: namepaymentcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create payment name',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: accountidcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create payment accountid',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: paymentcurrencycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create payment currency',
              ),
            ),
            TextField(
              controller: paymentcurrencycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'create payment category',
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
              title: "Create new payment service",
              desc: "Are you sure to create this?",
              btnOkOnPress: () {
                setState(() {
                  createpayment();
                });
              },
              btnCancelOnPress: () {

              }
          ).show();
        }, child: Text('Create',style:TextStyle(fontSize: 16,color: Colors.blue)),)
      ],
    ),

    );
  }

  List<String> admininfo=[];
  List<String> adminaccountid=[];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('customer').where('userrole',isEqualTo: 'admin').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
              admininfo.add(document['fullname']);
              adminaccountid.add(document['accountid']);

            }

            // print(accountid.length);
            // listdocument.add(document.reference.id);
          );
        })
    );
  }







  var is_load_home = true;
  void signout(){
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> SignInScreen()));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocId();

    // load_home();

  }

  void dispose(){
    super.dispose();
  }
  List menu = [ExchangeRate(), TermAndCondition(), Location(),Setting(),SignInScreen()];
  List feature_menu=[adminpost()];
  Widget feature_row(
      {required int color_num,
        required String title_text,
        required String description_text,
        required String animation,
        required int ID}) {
    return InkWell(
      onTap: (){
        if(ID==3){
          createquickservice();
        }else if(ID==2){
          createpaymentservices();
        }else{
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (ctx) => feature_menu[ID]));
        }

      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border(top: BorderSide(width: 2, color: Colors.white30))),
        child: Row(
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue[color_num],
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Text(
                                title_text,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(description_text,
                                  style: TextStyle(color: Colors.white54))
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        child: Lottie.network(animation),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  List main_menu_grid=[adminusercreatedaccount(),adminrequest(),admintransactionlog()];
  Widget feature_grid(Icon icon_data, String text,{required int id}) {
    return Expanded(
      child: InkWell(
        onTap: (){
          if(id==3){
            showpaymentmgmt();
          }else if(id==4) {
            showpromotionmgmt();
          }else{
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => main_menu_grid[id]));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(width: 2, color: Colors.white30),
                left: BorderSide(width: 2, color: Colors.white30)),
            color: Colors.blue[700],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon_data,
                SizedBox(
                  height: 16,
                ),
                Text(text, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }

  load_home() {
    Future.delayed(Duration(seconds: 3)).then((value) => setState(() {
      is_load_home = true;
    }));
  }

  Widget drawer_feature_tile(
      {required Icon icon_data, required String text, required int id}) {
    return ListTile(
      onTap: () {
        if(id==4){
          signout();
          Navigator.of(context)
              .pushReplacement(CupertinoPageRoute(builder: (ctx) => SignInScreen()));
        }else{
          Navigator.of(context)
              .pushReplacement(CupertinoPageRoute(builder: (ctx) => menu[id]));
        }
      },
      leading: icon_data,
      title: Text(text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Mgmt',
            style: TextStyle(color: Colors.white),
          ),
          // leading: Icon(Icons.menu_outlined,color: Colors.white,),
          actions: [
            InkWell(
              onTap: (){
                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> notificationadmin()));
              },
              child: Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20,)


          ],
          backgroundColor: Colors.blue[500],
          bottomOpacity: 0,
          elevation: 0,
        ),
        drawer: Drawer(
            child: Stack(
              children: [
                Container(
                    color: Colors.blue[900],
                    child: ListView(
                      children: [
                        DrawerHeader(
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                            'https://www.istockphoto.com/photos/user-profile'),
                                      ),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        border:
                                        Border.all(width: 3, color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      )),
                                  SizedBox(height: 16),
                                  Text(admininfo.length==0?'Welcome, admin':'Welcome, ' + admininfo[0],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                                  Text(adminaccountid.length==0?'AID: loading...':'AID: ' + adminaccountid[0],
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                                ],
                              ),
                            )),
                        SizedBox(height: 16),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16),
                        drawer_feature_tile(
                            icon_data: Icon(
                              Icons.currency_exchange_outlined,
                              color: Colors.white,
                            ),
                            text: 'Exchange rates',
                            id: 0),
                        drawer_feature_tile(
                            icon_data: Icon(
                              Icons.library_books_outlined,
                              color: Colors.white,
                            ),
                            text: 'Term & condition',
                            id: 1),
                        drawer_feature_tile(
                            icon_data: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            text: 'Agent & location',
                            id: 2),
                        drawer_feature_tile(
                            icon_data: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            text: 'Logout',
                            id: 4),
                      ],
                    )),
                Positioned(
                  child: Text(
                    'Version: 0.0.1',
                    style: TextStyle(color: Colors.white),
                  ),
                  bottom: 10,
                  right: 10,
                ),
                Positioned(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_06a6pf9i.json'),
                  ),
                  bottom: 10,
                  left: 10,
                )
              ],
            )),
        body: SingleChildScrollView(
            child: Visibility(
              visible: is_load_home,
              child: Column(
                children: [

                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        border: Border(
                          top: BorderSide(width: 2, color: Colors.white30),
                        )),
                    child: Row(
                      children: [
                        feature_grid(
                            Icon(
                              Icons.supervisor_account,
                              color: Colors.white,
                              size: 48,
                            ),
                            'User mgmt',
                            id:0),
                        feature_grid(
                            Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 48,
                            ),
                            'Transaction logs',id:2),
                        feature_grid(
                            Icon(
                              Icons.miscellaneous_services,
                              color: Colors.white,
                              size: 48,
                            ),
                            'Transaction Request',id:1),

                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        border: Border(
                          top: BorderSide(width: 2, color: Colors.white30),
                        )),
                    child: Row(
                      children: [
                        feature_grid(
                            Icon(
                              Icons.payment_outlined,
                              color: Colors.white,
                              size: 48,
                            ),
                            'Payment services mgmt',id:3),
                        feature_grid(
                            Icon(
                              Icons.star_border,
                              color: Colors.white,
                              size: 48,
                            ),
                            'Promotions mgmt',id:4),

                      ],
                    ),
                  ),
                  feature_row(
                      color_num: 900,
                      title_text: 'Agent Posts',
                      description_text: 'This feature offer you the possibilty of '
                          'view all agent transaction Posts',
                      animation:
                      'https://assets3.lottiefiles.com/packages/lf20_q0vtqaxf.json',
                      ID:0),
                  feature_row(
                      color_num: 800,
                      title_text: 'Create user',
                      description_text: 'This feature offer you the possibilty of '
                          'created user with different roles.',
                      animation:
                      'https://assets6.lottiefiles.com/packages/lf20_ad1buz0z.json',
                      ID:1),
                  feature_row(
                      color_num: 900,
                      title_text: 'Create payment services',
                      description_text: 'This feature offer you the possibilty of '
                          'created different payment services for user',
                      animation:
                      'https://assets2.lottiefiles.com/packages/lf20_3tryizhw.json',
                      ID:2),
                  feature_row(
                      color_num: 800,
                      title_text: 'Create promotions',
                      description_text: 'This feature offer you the possibilty of '
                          'created different promotions for user',
                      animation:
                      'https://assets1.lottiefiles.com/packages/lf20_pms7gseb.json',
                      ID:3),

                ],
              ),
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
            )));
  }
}
