import 'package:flutter/material.dart';
import 'package:truemoneyversion2/View/authscreen.dart';
import 'package:truemoneyversion2/View/splash_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import'package:flutter/services.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarBrightness: Brightness.dark,
  //   statusBarColor: Colors.lightBlue
  // ));
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home:Scaffold(
        appBar: AppBar(title: Center(child:Text('')),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,),
        body:SplashScreen()
      )
    );
  }
}
