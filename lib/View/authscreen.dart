import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truemoneyversion2/View/confirm_lock.dart';
import 'package:truemoneyversion2/View/loading_to_home_screen.dart';
import 'home_screen_view.dart';
import 'sign_in_screen_view.dart';
class authscreen extends StatefulWidget {
  const authscreen({super.key});

  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),
    builder: (context,snapshot){
    if(snapshot.hasData){
    return ConfirmLock();
    }
    else{
    return SignInScreen();
  }
        }
    ),
    );
}
}
