import'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
class MoneyTransferService extends StatefulWidget {
  const MoneyTransferService({Key? key}) : super(key: key);

  @override
  State<MoneyTransferService> createState() => _MoneyTransferServiceState();
}

class _MoneyTransferServiceState extends State<MoneyTransferService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Money Transfer Service',
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
                  CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
            },
          ),
        ),
      body: Container(
              width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shopping'),
                SizedBox(height:16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1)
                  ),
                    width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height:150,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network('https://images.pexels.com/photos/3985062/pexels-photo-3985062.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
                                ,fit: BoxFit.cover,),
                            ),
                          ),
                          Positioned(
                            top:6,
                            left: 6,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('15% off',
                                style:TextStyle(color:Colors.white),),
                            ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage('lib/Assets/store_logo/luckystore.png') ),
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Luck Supermaket',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),),
                                SizedBox(height: 3,),
                                Text('This offer 15% off when you get in.')
                              ],
                            )
                          ],
                        ),
                      )
                    ],

                  )
                ),

              ],
            ),
          ),


    );
  }
}
