import'package:flutter/cupertino.dart';
import'package:lottie/lottie.dart';
import'package:flutter/material.dart';
import 'package:truemoneyversion2/View/loading_payment_success.dart';
import 'package:truemoneyversion2/View/quick_payment.dart';
class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  List account_menu=['USD','KH'];
  String select_value='USD';

  my_form_state(){
    select_value=account_menu[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Transfer money',
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
                  CupertinoPageRoute(builder: (ctx) => const QuickPayment()));
            },
          ),
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,

                  child: Lottie.network('https://assets9.lottiefiles.com/private_files/lf30_24lawrru.json'),
                ),
                SizedBox(height:10),
                Text("Make a Payment",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  onChanged:(new_value){
                    setState(() {
                      select_value=new_value as String;
                    });},
                  items: account_menu.map((value_item){
                    return DropdownMenuItem(child: Text(value_item),value: value_item,);
                  }).toList(),
                  decoration: InputDecoration(
                      labelText: 'Credit Account seletection'
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Service Name',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    'Tap on this "Confirm" button to proceed the payment'),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: Text("Confirm",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (ctx) => const LoadingPaymentSuccess()));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
