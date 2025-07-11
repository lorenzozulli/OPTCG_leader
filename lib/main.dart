import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  int pageIndex = 0;

  final List<Widget> pages = [
    UserHome(),
    LeaderSelection()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OPTCGcounter')),

          body: pages[pageIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              setState(() {
                pageIndex = index;
              });
            },
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Leaders',
              )
            ]
          ),

          drawer: Drawer(
            child: Text('OPTCGleader, made by Lorenzo Zulli')
          ),
        ),
      );
  }
}

