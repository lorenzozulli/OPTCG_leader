import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/entities/themeswitcher.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
import 'package:shared_preferences/shared_preferences.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final String leaderImage = prefs.getString('leaderImage') ?? '';
  final String leaderJson = prefs.getString('leader') ?? '{"name":"Hannyabal","id":"EB01-021","images":{"image_en":"https://en.onepiece-cardgame.com/images/cardlist/card/EB01-021.png?250701","images_alt":["https://en.onepiece-cardgame.com/images/cardlist/card/EB01-021_p1.png?250701","https://en.onepiece-cardgame.com/images/cardlist/card/EB01-021_p2.png?250701"]},"life":"4","power":"5000","colors":["blue","purple"],"effect":"[End of Your Turn] You may return 1 of your {Impel Down} type Characters with a cost of 2 or more to the owner\'s hand: Add up to 1 DON!! card from your DON!! deck and set it as active."}';
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
  late ThemeSwitcher themeSwitcher;
  
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

    themeSwitcher = ThemeSwitcher(color: widget.leader.colors[0]);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeSwitcher.themeSwitcher(true, widget.leader.colors[0]),
      darkTheme: themeSwitcher.themeSwitcher(false, widget.leader.colors[0]),

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

