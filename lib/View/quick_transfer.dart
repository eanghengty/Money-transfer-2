import'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/quick_transfer_add.dart';
import'package:truemoneyversion2/View/make_transfer_screen.dart';
class QuickTransfer extends StatefulWidget {
  const QuickTransfer({Key? key}) : super(key: key);

  @override
  State<QuickTransfer> createState() => _QuickTransferState();
}

class _QuickTransferState extends State<QuickTransfer> {
  Widget user({required String icon, required String text, required String description}){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (ctx) => const MakeTransfer()));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(

              child:Image.asset(icon),

              width: 40,
              height: 40,
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,

                  child: Text(text,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: 3,),
                Container(
                  width: 300,

                  child: Text(description),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(
          child: Text(
            'Quick Transfer',
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (ctx) => const QuickTransferAdd()));
          },
          child:Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue[800],
        ),
      body:SingleChildScrollView(
      child:
      Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          user(icon:'lib/Assets/user.png',text:'User A',
              description: '00011'),
          user(icon:'lib/Assets/user.png',text:'User B', description: '00012'),
          user(icon:'lib/Assets/user.png',text:'User C', description: '00013')

        ],
      ),
    )
    )
    );
  }
}
