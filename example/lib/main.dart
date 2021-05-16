import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Bar Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Bottom Bar Sheet Demo'),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey.shade800,
        child: Center(
          child: Text('Demo', style: TextStyle(color: Colors.white),),
        ),
      ),
      bottomSheet: BottomBarSheet(
        buttonPosition: ButtonBottomBarPosition.center,
        innerChild: Center(child: Text('Bottom sheet'),),
        children: [
          BottomSheetBarIcon(
            icon: Icon(Icons.home),
            color: Colors.redAccent, 
            onTap: (){
            },
          ),
          BottomSheetBarIcon(
            icon: Icon(Icons.person),
            color: Colors.blueAccent, 
            onTap: (){
            },
          ),
          BottomSheetBarIcon(
            icon: Icon(Icons.edit),
            color: Colors.blue[800], 
            onTap: (){
            },
          ),
          BottomSheetBarIcon(
            icon: Icon(Icons.star),
            color: Colors.orangeAccent, 
            onTap: (){
            },
          ),
        ],
      ),
    );
  }
}

class BottomBarSheetIcon {
}
