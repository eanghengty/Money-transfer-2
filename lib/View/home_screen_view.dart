import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truemoneyversion2/Drawbar_view/exchange_rate.dart';
import 'package:truemoneyversion2/Drawbar_view/location.dart';
import 'package:truemoneyversion2/Drawbar_view/setting.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';
import 'package:truemoneyversion2/View/getaccountinfo.dart';
import 'package:truemoneyversion2/View/getdata.dart';
import 'package:truemoneyversion2/View/lock_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/Drawbar_view/term_and_condition.dart';
import 'package:truemoneyversion2/View/money_transfer_service.dart';
import 'package:truemoneyversion2/View/my_wallet.dart';
import 'package:truemoneyversion2/View/notification_screen.dart';
import 'package:truemoneyversion2/View/pay_services.dart';
import 'package:truemoneyversion2/View/quick_payment.dart';
import 'package:truemoneyversion2/View/quick_transaction_limit.dart';
import 'package:truemoneyversion2/View/quick_transfer.dart';
import 'package:truemoneyversion2/View/transaction_log.dart';
import'package:truemoneyversion2/View/sign_in_screen_view.dart';
import'package:truemoneyversion2/View/contact_hotline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var is_load_home = true;
  List<String> docIDs=['test'];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
        (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        })
    );
  }

  @override
  void initState() {
    getDocId();
    // TODO: implement initState
    super.initState();
    load_home();
  }
  void signout(){
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> SignInScreen()));
  }

  List menu = [ExchangeRate(), TermAndCondition(), Location(),Setting()];
  List feature_menu=[QuickTransfer(),QuickPayment(),MoneyTransferService(),QuickTransaction()];
  Widget feature_row(
      {required int color_num,
      required String title_text,
      required String description_text,
      required String animation,
      required int ID}) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (ctx) => feature_menu[ID]));
      },
      child: Container(
        width: double.infinity,
        height: 170,
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
  List main_menu_grid=[MyWallet(),PayServices(),TransactionLog()];
  Widget feature_grid(Icon icon_data, String text,{required int id}) {
    return Expanded(
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (ctx) => main_menu_grid[id]));
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
    if(docIDs.length==1){
      return Scaffold(
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_psckabiq.json'),
                ),
                SizedBox(height: 16,),
                Text('Welcome to mobile money...')
              ],
            ),
          )
      );
    }else {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Mobile Money',
              style: TextStyle(color: Colors.white,fontSize: 16),
            ),
            // leading: Icon(Icons.menu_outlined,color: Colors.white,),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                      builder: (ctx) => NotificationScreen()));
                },
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (ctx) => ContactHotline()));
                },
                child: Icon(
                  Icons.phone_in_talk,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                            builder: (ctx) => const ConfirmLock()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[500], elevation: 0),
                  child: Icon(
                    Icons.lock_open_outlined,
                    color: Colors.white,
                  )),
              SizedBox(width: 20),
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
                                              'https://yt3.ggpht.com/yti/AHXOFjVZBdHodAPo6iTd5-gErFvDOEjLTWTjU4ATNhE3lw=s88-c-k-c0x00ffffff-no-rj-mo'),
                                        ),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          border:
                                          Border.all(
                                              width: 3, color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              50),
                                        )),
                                    SizedBox(height: 16),
                                    getdata(documentid: docIDs[1]),
                                    Text('User AID: 00010',
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
                                Icons.settings,
                                color: Colors.white,
                              ),
                              text: 'Setting',
                              id: 3),
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
                                Icons.wallet,
                                color: Colors.white,
                                size: 48,
                              ),
                              'My Wallet',
                              id: 0),
                          feature_grid(
                              Icon(
                                Icons.history,
                                color: Colors.white,
                                size: 48,
                              ),
                              'Transaction logs', id: 2),
                          feature_grid(
                              Icon(
                                Icons.miscellaneous_services,
                                color: Colors.white,
                                size: 48,
                              ),
                              'Pay services', id: 1),
                        ],
                      ),
                    ),
                    feature_row(
                        color_num: 900,
                        title_text: 'Quick Transfer',
                        description_text: 'This feature offer you the possibilty of '
                            'making a money transfer in a second',
                        animation:
                        'https://assets4.lottiefiles.com/packages/lf20_GTEqBh.json',
                        ID: 0),
                    feature_row(
                        color_num: 700,
                        title_text: 'Money Transfer Service',
                        description_text: 'This feature offer you a list of '
                            'service that we provided to you',
                        animation:
                        'https://assets8.lottiefiles.com/private_files/lf30_GoIWGN.json',
                        ID: 2),
                    feature_row(
                        color_num: 900,
                        title_text: 'Quick Transaction limit',
                        description_text: 'This feature offer you the possibilty of '
                            'making a money limitation in a second',
                        animation:
                        'https://assets8.lottiefiles.com/packages/lf20_ml0yft0o.json',
                        ID: 3),
                    feature_row(
                        color_num: 700,
                        title_text: 'Quick Payment',
                        description_text: 'This feature offer you the possibilty of '
                            'making a payment in a second',
                        animation:
                        'https://assets9.lottiefiles.com/packages/lf20_ltbqacam.json',
                        ID: 1),
                  ],
                ),
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
              )));
    }
  }
}
