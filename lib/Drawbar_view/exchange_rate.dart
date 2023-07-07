import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:truemoneyversion2/View/home_screen_view.dart';
import 'package:intl/intl.dart';

class ExchangeRate extends StatefulWidget {
  const ExchangeRate({Key? key}) : super(key: key);

  @override
  State<ExchangeRate> createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<ExchangeRate> {
  bool is_active = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget desc_exchange({required bool active}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        active == true
            ? Container(


                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(DateFormat('yyyy-MM-dd KK:mm:ss')
                                  .format(DateTime.now()))),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Center(
                                      child: Column(
                                children: [
                                  Text('Buy'),

                                ],
                              ))),
                              Expanded(
                                  child: Center(
                                      child: Column(
                                children: [
                                  Text('Sell'),

                                ],
                              )))
                            ],
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset('lib/Assets/us_flag.png',
                                    width: 50,
                                    height: 50,),
                                ),
                                SizedBox(width: 5,),
                                Text('USD')
                              ],
                            )),
                        Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Column(
                                          children: [
                                            Text('4300,00 riels')
                                          ],
                                        ))),
                                Expanded(
                                    child: Center(
                                        child: Column(
                                          children: [
                                            Text('4100,00 riels')
                                          ],
                                        )))
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )
            : Center(
                child: Text('Not yet implement Currency Exchange Calculator'))
      ],
    );
  }

  Widget top_title_exchange({required String text, required bool active}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        setState(() {
          is_active = !is_active;
        });
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.blue[800],
            border: Border(
                bottom: active == true
                    ? BorderSide(width: 3, color: Colors.red)
                    : BorderSide(width: 3, color: Colors.transparent))),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: active == true ? Colors.white : Colors.white30,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        )),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'MTA Exchange rate',
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
      body: Column(
        children: [
          Row(
            children: [
              top_title_exchange(text: 'Rates', active: is_active),
              top_title_exchange(text: 'Calculator', active: !is_active),
            ],
          ),
          Container(
            child: desc_exchange(active: is_active),
          )
        ],
      ),
    );
  }
}
