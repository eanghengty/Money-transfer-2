import 'package:flutter/material.dart';
import'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/first_lock.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:truemoneyversion2/View/view_detail_profile.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List menu_item=[FirstLock(),ViewDetail()];
  Widget menu({required String text, required Icon icon_data, required int id}){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=>menu_item[id]));
      },
      child: Container(

          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(

              children: [
                icon_data,
                SizedBox(width: 10,),
                Text(text,
                  style: TextStyle(
                    fontSize: 16,
                  ),)
              ],
            ),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Setting',
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
        body:Container(

          child: Column(
            
            children: [
              menu(icon_data: Icon(Icons.manage_accounts), text: 'View profile details',id:1),
              menu(icon_data: Icon(Icons.password_outlined), text: 'Change password',id:0)

            ],
          ),
        )
    );
  }
}
