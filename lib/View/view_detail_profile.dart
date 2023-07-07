import'package:flutter/material.dart';
import'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
class ViewDetail extends StatefulWidget {
  const ViewDetail({Key? key}) : super(key: key);

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  Widget list_of_detail({required String title, required Icon icon_data, required String description}){
    return Container(
      padding: EdgeInsets.only(top:5,bottom: 5,right:30,left: 5),
      decoration: BoxDecoration(
          border:Border(bottom: BorderSide(width: 1))
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [


          Row(
            children: [
              SizedBox(width: 10,),
              icon_data,
              Expanded(child: Text(description,textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),),

            ],
          ),
          SizedBox(height: 3,),
          Container(
            width: double.infinity,
            child: Text(title,),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Account Details',
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,

          child: Column(
            children: [
              Container(
                  color: Colors.blue[800],
                padding: EdgeInsets.all(16),
                height: 250,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_z3pnisgt.json'),
                      ),
                      SizedBox(height: 16,),
                      Text('Hi, Hengty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),)
                    ],
                  ),
                )
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color:Colors.grey[200],
                child: Text('Your information',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),),
              ),
              Column(
                children: [
                  list_of_detail(title:'Full Name',
                      icon_data:Icon(Icons.account_circle_rounded,size: 35,),
                  description: 'Eang Hengty'),
                  list_of_detail(title:'Phone Number',
                      icon_data:Icon(Icons.phone_android_rounded,size: 35,),
                      description: '010 XXX XXXX'),
                  list_of_detail(title:'Date of Birth',
                      icon_data:Icon(Icons.date_range_rounded,size: 35,),
                      description: '03-Jan-2001'),
                  list_of_detail(title:'Province',
                      icon_data:Icon(Icons.place_sharp,size: 35,),
                      description: 'Battambang'),
                  list_of_detail(title:'Career type',
                      icon_data:Icon(Icons.work,size: 35,),
                      description: 'Employment'),
                  list_of_detail(title:'Deposit Range',
                      icon_data:Icon(Icons.monetization_on,size: 35,),
                      description: '> 300\$'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
