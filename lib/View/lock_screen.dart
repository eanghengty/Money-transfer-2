import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import'package:flutter/cupertino.dart';
import'package:truemoneyversion2/View/home_screen_view.dart';
class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  Widget num_button({required String text, Icon icon_data=const Icon(Icons.done_rounded,size:16,color: Colors.white,)}){
    if(text=='10'){
      return ElevatedButton(
        onPressed: (){},
        child: icon_data,
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }
    else if(text=='11'){
      return ElevatedButton(
        onPressed: (){
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>const HomeScreen() ));
        },
        child: icon_data,
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }
    else{
      return ElevatedButton(
        onPressed: (){},
        child: Text(text,
          style: TextStyle(color: Colors.white,
              fontSize: 24),),
        style: ElevatedButton.styleFrom(
            elevation:2,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(30),
            side: BorderSide(color: Colors.blue),
            shape: CircleBorder(),
            maximumSize: Size.square(100)
        ),);
    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(title: Center(child: Text('Locked',
      style: TextStyle(
        color: Colors.white
      ),),),
      backgroundColor: Colors.transparent,
      bottomOpacity: 0,
      elevation: 0,),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:Column(
            children: [
              Center(
                  child:Container(
                    width: 150,
                    height: 150,
                    child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_cfcpu6nf.json'),
                  )
              ),
              Center(
                child: Text('Enter passcode',
                    style:TextStyle(
                        color:Colors.white,
                        fontSize: 16
                    )),
              ),
              SizedBox(height: 16,),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle_outlined,color: Colors.white,),
                  SizedBox(width: 10,),
                  Icon(Icons.circle_outlined,color: Colors.white),
                  SizedBox(width: 10,),
                  Icon(Icons.circle_outlined,color: Colors.white),
                  SizedBox(width: 10,),
                  Icon(Icons.circle_outlined,color: Colors.white),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  num_button(text:'1'),
                  SizedBox(width: 30,),
                  num_button(text:'2'),
                  SizedBox(width: 30,),
                  num_button(text:'3'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  num_button(text:'4'),
                  SizedBox(width: 30,),
                  num_button(text:'5'),
                  SizedBox(width: 30,),
                  num_button(text:'6'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  num_button(text:'7'),
                  SizedBox(width: 30,),
                  num_button(text:'8'),
                  SizedBox(width: 30,),
                  num_button(text:'9'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  num_button(text:'10',icon_data: Icon(Icons.cancel_outlined,size:16,color: Colors.white,)),
                  SizedBox(width: 30,),
                  num_button(text:'2'),
                  SizedBox(width: 30,),
                  num_button(text:'11'),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
