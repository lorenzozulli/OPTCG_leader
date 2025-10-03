import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
import 'package:shared_preferences/shared_preferences.dart';
 void main() async {
  final Leader defaultLeader = Leader(
    name: 'adsf',
    id: 'asdf',
    images: Images(imageEn: 'asdf', imagesAlt: ['asdf']),
    life: '3',
    power: 'asdf',
    colors: ['asdf'],
    effect: 'asdf:'
  );
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  final String leaderImage = prefs.getString('leaderImage') ?? '';

  final String leaderJson = prefs.getString('leader') ?? '';

  Map<String, dynamic> leaderMap = jsonDecode(leaderJson);
  Leader leader = Leader.fromJson(leaderMap);

  runApp(MyApp(isFirstTime: isFirstTime, leader: leader, leaderImage: leaderImage));
} 

class MyApp extends StatefulWidget {
  final Leader leader;
  final String leaderImage;
  final bool isFirstTime;

  const MyApp({
    super.key,
    required this.isFirstTime,
    required this.leader,
    required this.leaderImage
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  late final List<Widget> pages;
  
  @override
  void initState() {
    super.initState();
    pages = [
      UserHome(leader: widget.leader, leaderImage: widget.leaderImage),
      LeaderSelection(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: widget.isFirstTime ? LeaderSelection() : Scaffold(
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
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Leaders',
              ),
            ]
          ),
        ),
      );
  }
}

