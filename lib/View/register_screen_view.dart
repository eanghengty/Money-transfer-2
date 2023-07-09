import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';
import 'package:truemoneyversion2/View/first_lock.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'package:lottie/lottie.dart';
import'package:file_picker/file_picker.dart';
import 'package:truemoneyversion2/View/verify_code_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class RegisterString extends StatefulWidget {
  const RegisterString({Key? key}) : super(key: key);

  @override
  State<RegisterString> createState() => _RegisterStringState();
}

class _RegisterStringState extends State<RegisterString> {
  final firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;


  List list_item=[
    'Bank','Worker'
  ];
  String select_value='Bank';

  my_form_state(){
    select_value=list_item[0];
  }
  PlatformFile? pickedfile;
  FilePickerResult? result;
  String? file_name;
  bool is_loading=false;

  Future uploadfile() async{
    final path='files/${pickedfile!.name}';
    final file=File(pickedfile!.path!);
    final ref=firebase_storage.FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  void picked_file() async{
    try{
      setState(() {
        is_loading=true;
      });
      result=await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['png','jpg']
      );
      if (result!=null){
        file_name=result!.files.first.name;
        pickedfile=result!.files.first;

      }

      setState(() {
        is_loading=false;
      });
    }catch(e){
      print(e);
    }
  }
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final confirmedpasswordcontroller=TextEditingController();
  final fullnamecontroller=TextEditingController();
  String dateofbirthcontroller= "";
  DateTime showdate1=DateTime.now();
  String showdate2="";
  final jobselectioncontroller=TextEditingController();
  final phonenumbercontroller=TextEditingController();
  final usdmoneycontroller="0.00";

  final khmoneycontroller="0.00";
  final transactioncontroller="0";
  final accountcreateddate=DateTime.timestamp();
  final currentuser = FirebaseAuth.instance;
  final userrolecontroller="customer";
  String userverifycontroller="no";


  // Future signup() async{
  //   if(passwordconfirmed()){
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
  //     adduserdetail(fullnamecontroller.text.trim(), emailcontroller.text.trim(), dateofbirthcontroller.text.trim(),
  //         jobselectioncontroller.text.trim(), phonenumbercontroller.text.trim());
  //   }
  //
  // }


  // Future adduserdetail(String fullname,String email,String dateofbirth,String jobselection, String phonenumber) async{
  //   await FirebaseFirestore.instance.collection('customer').add({
  //     'fullname':fullname,
  //     'email':email,
  //     'dateofbirth':dateofbirth,
  //     'jobselection':jobselection,
  //     'phonenumber':phonenumber
  //   });
  // }

  final user = FirebaseAuth.instance.currentUser!;

  // emailverfied(){
  //   if(user.emailVerified){
  //     setState(() {
  //       userverifycontroller="verified";
  //     });
  //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
  //         builder: (ctx) => const VerifyCode()));
  //   }
  // }
  List<String> phonenumber=[];
  Future getphonenumber() async{
    await FirebaseFirestore.instance.collection('customer').get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            phonenumber.add(document['phonenumber']);
            print("total phonen: " + phonenumber.length.toString());
          });

        })
    );}
  void initState(){
    // emailverfied();
    getphonenumber();
    getcustomer();

    super.initState();
  }

  Future adduserdetail() async{
    await FirebaseFirestore.instance.collection('customer').add({
      'fullname':fullnamecontroller.text.trim(),
      'dateofbirth':dateofbirthcontroller,
      'jobselection':jobselectioncontroller.text.trim(),
      'phonenumber':phonenumbercontroller.text.trim(),
      'enmoney':usdmoneycontroller,
      'khmoney':khmoneycontroller,
      'uid':currentuser.currentUser!.uid,
      'userrole':userrolecontroller,
      'userverify':userverifycontroller,
      'accountid':phonenumbercontroller.text.trim(),
      'createddate':DateTime.now().toString(),
      'status':"enabled",
      'accountactivated':'yes'

    });
  }

  List<dynamic> getcustomerinfo=[];
  Future getcustomer() async{
    await FirebaseFirestore.instance.collection('customer').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          print(document.reference.id);
          setState(() {

            getcustomerinfo.add(document['uid']);
            print('customer uid: '+getcustomerinfo[0]);

            if(FirebaseAuth.instance.currentUser!.uid == getcustomerinfo[0]){

              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  title: "Your account info is already register",
                  desc:"Please continue to set up password.",
                  btnOkOnPress: () {

                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const FirstLock()));
                  }
              ).show();
            }

          });
        })
    );
  }

  List<String> phone=[];
  void passwordconfirmedone(){
    for(int i=0;i<phonenumber.length;i++){
      if(phonenumbercontroller.text.trim()!=phonenumber[i]){
        setState(() {
          phone.add('1');
          print('1. '+ phonenumbercontroller.text.trim());
        });
      }else{
        setState(() {
          phone.add('0');
          print('0. '+ phonenumbercontroller.text.trim());
        });
      }
    }
  }
  bool passwordconfirmtwo(){
    if(phone.contains('0')){
      return false;
    }else{
      return true;
    }
  }
  void dispose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmedpasswordcontroller.dispose();
    fullnamecontroller.dispose();

    jobselectioncontroller.dispose();
    phonenumbercontroller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register information')),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const SignInScreen()));
          },
          child: Icon(Icons.arrow_circle_left_outlined),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    height: 200,
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_wzAk0pBKAp.json')),
                TextFormField(
                  controller: fullnamecontroller,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter the email";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full name',

                  ),
                ),
                SizedBox(
                  height: 16,
                ),
            //TextField(
                //   controller: emailcontroller,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'email',
                //   ),),
                SizedBox(height: 16,),
                // DropdownButtonFormField(
                //   onChanged:(new_value){
                //   setState(() {
                //     select_value=new_value as String;
                //   });},
                //   items: list_item.map((value_item){
                //     return DropdownMenuItem(child: Text(value_item),value: value_item,);
                //   }).toList(),
                //   decoration: InputDecoration(
                //     labelText: 'Job Selection'
                //   ),
                // ),
                TextField(
                  controller: jobselectioncontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Job title',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phonenumbercontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',

                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              TextField(
                    enabled: false,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date of birth: ' + showdate2,
                    ),
                  ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                      onPressed: (){
                        showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(1900),lastDate: DateTime(2030)).then((value) =>
                            setState((){
                              showdate1=value!;
                              showdate2=showdate1.toString();
                              dateofbirthcontroller=showdate2;
                            }));},
                      color: Colors.blue,
                      child:Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Choose Date',style: TextStyle(color: Colors.white,fontSize: 16),),

                      )
                  ),
                // Row(
                //   children: [
                //     TextField(
                //       enabled: false,
                //
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         labelText: 'Date of birth: ' + showdate2,
                //       ),
                //     ),
                //     MaterialButton(
                //         onPressed: (){
                //           showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(2000),lastDate: DateTime(2010)).then((value) =>
                //               setState((){
                //                 showdate1=value!;
                //                 showdate2=showdate1.toString();
                //                 dateofbirthcontroller=showdate2;
                //               }));},
                //         color: Colors.blue,
                //         child:Padding(
                //           padding: EdgeInsets.all(15.0),
                //           child: Text('Choose Date',style: TextStyle(color: Colors.white,fontSize: 16),),
                //
                //         )
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                // TextField(
                //   controller: passwordcontroller,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'password',
                //   ),),
                // SizedBox(height: 16,),
                // TextField(
                //   controller: confirmedpasswordcontroller,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'confirm password',
                //   ),),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'National ID card'
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: (){
                    picked_file();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:Border.all(width: 2)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border:Border.all(width: 1)
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Text('-------------------'),
                            Text('----------------'),
                            Text('-----------------------'),
                            Text('----------------------'),
                            Text('---------------------'),

                          ],
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    'Tap on this "Register" button to register new account for your starting your money transfer process.'),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: Text("Confirm information",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,
                  ),
                  onPressed: () {

                    // Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    //     builder: (ctx) => const VerifyCode()));
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "Creating account",
                      desc:"Please kindly wait.",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {

                          passwordconfirmedone();
                       print(phone.length);
                        if(passwordconfirmtwo()){
                        adduserdetail();
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(
                            builder: (ctx) => const VerifyCode()));
                      }else{
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "This phone number has already use",
                              desc:"Please kindly try another.",
                              btnCancelOnPress: () {
                                phone.clear();
                              },).show();
                      }

                          }
                      ).show();

                  },
                ),

              ],
            )),

      ),
    );
  }
}
