import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
import 'package:lottie/lottie.dart';
import'package:file_picker/file_picker.dart';
import 'package:truemoneyversion2/View/verify_code_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RegisterString extends StatefulWidget {
  const RegisterString({Key? key}) : super(key: key);

  @override
  State<RegisterString> createState() => _RegisterStringState();
}

class _RegisterStringState extends State<RegisterString> {

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


  void picked_file() async{
    try{
      setState(() {
        is_loading=true;
      });
      result=await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false
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
  final dateofbirthcontroller=TextEditingController();
  final jobselectioncontroller=TextEditingController();
  final phonenumbercontroller=TextEditingController();
  final usdmoneycontroller=0;
  final khmoneycontroller=0;
  final transactioncontroller=0;
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
    await FirebaseFirestore.instance.collection('customer')..get().then(
            (snapshot)=>snapshot.docs.forEach((document) {
          setState(() {
            phonenumber.add(document['phonenumber']);
            print(phonenumber.length);
          });

        })
    );}
  void initState(){
    // emailverfied();
    getphonenumber();

    super.initState();
  }

  Future adduserdetail() async{
    await FirebaseFirestore.instance.collection('customer').add({
      'fullname':fullnamecontroller.text.trim(),
      'dateofbirth':dateofbirthcontroller.text.trim(),
      'jobselection':jobselectioncontroller.text.trim(),
      'phonenumber':phonenumbercontroller.text.trim(),
      'usdmoney':usdmoneycontroller,
      'khmoney':khmoneycontroller,
      'uid':currentuser.currentUser!.uid,
      'userrole':userrolecontroller,
      'userverify':userverifycontroller,
    });
  }




  bool passwordconfirmed(){
    if(phonenumbercontroller==confirmedpasswordcontroller){
      return true;
    }else{
      return false;
    }
  }
  void dispose(){
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmedpasswordcontroller.dispose();
    fullnamecontroller.dispose();
    dateofbirthcontroller.dispose();
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
                TextField(
                  controller: fullnamecontroller,
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
                TextField(
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
                  controller: dateofbirthcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date of birth',
                  ),
                ),
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
                      title: "Permission verification",
                      desc:"Please proceed verify your account",
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                      adduserdetail();
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                          builder: (ctx) => const VerifyCode()));
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
