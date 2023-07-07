import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getaccountinfo extends StatelessWidget {
  final String documentid;
  final String currency;
  const getaccountinfo({required this.documentid, required this.currency});

  @override
  Widget build(BuildContext context) {
    CollectionReference account=FirebaseFirestore.instance.collection('customer');


    return FutureBuilder<DocumentSnapshot>(
      future: account.doc(documentid).get(),
      builder: ((context,snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
          return Text(data[currency].toString(),style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white));
        }
        return Text('loading');
      }),);
  }
}
