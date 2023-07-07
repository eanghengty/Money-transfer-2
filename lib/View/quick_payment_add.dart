import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/loading_payment_completed.dart';
import 'package:truemoneyversion2/View/quick_payment.dart';
import'package:lottie/lottie.dart';
class QuickPaymentAdd extends StatefulWidget {
  const QuickPaymentAdd({Key? key}) : super(key: key);

  @override
  State<QuickPaymentAdd> createState() => _QuickPaymentAddState();
}

class _QuickPaymentAddState extends State<QuickPaymentAdd> {
  List payment_menu=['Mobile Top-up','Utilities','Education'];
  String select_value='Mobile Top-up';

  my_form_state(){
    select_value=payment_menu[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Add Payment',
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

                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_yzoqyyqf.json'),
                ),
                SizedBox(height:10),
                Text("Add quick payment",
                    style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  onChanged:(new_value){
                    setState(() {
                      select_value=new_value as String;
                    });},
                  items: payment_menu.map((value_item){
                    return DropdownMenuItem(child: Text(value_item),value: value_item,);
                  }).toList(),
                  decoration: InputDecoration(
                      labelText: 'Services selection'
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
                    labelText: 'Description',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    'Tap on this "Confirm" button to confirm new transaction limit for your account'),
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
                        builder: (ctx) => const LoadingCompleted()));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
