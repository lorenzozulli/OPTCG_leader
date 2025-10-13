import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
import 'package:optcgcounter_flutter/utils/themes/yellow_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final String leaderImage = prefs.getString('leaderImage') ?? '';
  final String leaderJson = prefs.getString('leader') ?? '';
  final bool isNewLeader = prefs.getBool('isNewLeader') ?? false;

  Map<String, dynamic> leaderMap = jsonDecode(leaderJson);
  Leader leader = Leader.fromJson(leaderMap);

  runApp(MyApp(
    isFirstTime: isFirstTime, 
    leader: leader, 
    leaderImage: leaderImage, 
    isNewLeader: isNewLeader
  ));
} 

class MyApp extends StatefulWidget {
  final Leader leader;
  final String leaderImage;
  final bool isFirstTime;
  final bool isNewLeader; const MyApp({
    super.key,
    required this.isFirstTime,
    required this.leader,
    required this.leaderImage,
    required this.isNewLeader
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
      UserHome(
        leader: widget.leader, 
        leaderImage: widget.leaderImage, 
        isNewLeader: widget.isNewLeader
      ),
      LeaderSelection(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      //darkTheme: AppTheme.dark,
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
          ],
        ),
      ),
    );
  }
}

