import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
void main(){
  final Leader defaultLeader = Leader(
    name: 'Kozuki Oden', // Provide a default name
    id: 'EB01-001',       // Provide a default ID
    images: Images(imageEn: "https://en.onepiece-cardgame.com/images/cardlist/card/EB01-001.png?250701", imagesAlt: []), // Provide default images
    life: '4',           // Provide default life
    power: '5000',          // Provide default power
    colors: ['green','red'],        // Provide default colors
  );
  runApp(MyApp(leader: defaultLeader, imageString: defaultLeader.images.imageEn,));
}

class MyApp extends StatefulWidget {
  final Leader leader;
  final String imageString;

  const MyApp({super.key, required this.leader, required this.imageString});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  int pageIndex = 0;

    // Lazily initialize pages or pass widget.leader correctly
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages here, where widget.leader is available
    pages = [
      UserHome(leader: widget.leader, imageString: widget.imageString), // Access leader via widget.leader
      const LeaderSelection() // LeaderSelection doesn't seem to need a leader, so added const
    ];
  }
  
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

