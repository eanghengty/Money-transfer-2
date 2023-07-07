import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getdata extends StatelessWidget {
  final String documentid;

  const getdata({required this.documentid});

  @override
  Widget build(BuildContext context) {
    CollectionReference customer=FirebaseFirestore.instance.collection('customer');


    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(documentid).get(),
      builder: ((context,snapshot){
      if(snapshot.connectionState==ConnectionState.done){
        Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
        return Text(data['fullname'],style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.white));
      }
      return Text('loading');
    }),);
  }
}
