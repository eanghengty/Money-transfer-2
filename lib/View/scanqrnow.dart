// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:truemoneyversion2/View/home_screen_view.dart';
// import 'package:truemoneyversion2/View/sign_in_screen_view.dart';
// import 'authscreen.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// class scanqrnow extends StatefulWidget {
//   const scanqrnow({Key? key}) : super(key: key);
//
//   @override
//   State<scanqrnow> createState() => _scanqrnowState();
// }
//
//
// class _scanqrnowState extends State<scanqrnow> {
//   @override
//   List<String> customer = [];
//
//   Future getinfo() async {
//     await FirebaseFirestore.instance.collection('customer').where(
//         'uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
//             (snapshot) =>
//             snapshot.docs.forEach((document) {
//               setState(() {
//                 customer.add(document['accountid']);
//               }
//               );
//               print(customer.length);
//             })
//     );
//   }
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getinfo();
//   }
//
//   @override
//   final qr = TextEditingController();
//   final qrkey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller?.dispose();
//   }
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(title: Center(child: Text('Show QR for transfer')),),
//             backgroundColor: Colors.grey[200],
//             body: Stack(
//               alignment: Alignment.center,
//               children:<Widget> [
//                 buildqr(context)
//               ],
//             )
//         )
//     );
//   }
//   void scanqr(QRViewController controller) {
//     setState(() =>
//     this.controller = controller
//     );
//   }
//     Widget buildqr(BuildContext context)=>QRView(key: qrkey, onQRViewCreated: scanqr);
// }
