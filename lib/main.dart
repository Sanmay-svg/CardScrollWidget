import 'package:flutter/material.dart';
import 'package:testproj/cardScrollWidget.dart';
import 'data.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false,
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets do it once again'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          // Stack(
          //   children: <Widget>[
          //     CardScrollWidget(
          //       padding: 20,
          //       horizontalInsetValue: 2,
          //       cards: images,
          //     ),

          //   ],
          // )
          CardScrollWidget(
            images: images,
            padding: 20,
            horizontalInsetValue: 2,
            verticalInset: 20
          )
        ],
      )
    );
  }
}