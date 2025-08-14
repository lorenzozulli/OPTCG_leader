import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/pages/home.dart';
import 'package:optcgcounter_flutter/pages/leaderselection.dart';
void main(){
  final Leader defaultLeader = Leader(
    name: 'Kozuki Oden',
    id: 'EB01-001',
    images: Images(imageEn: "https://en.onepiece-cardgame.com/images/cardlist/card/EB01-001.png?250701", imagesAlt: []),
    life: '4',
    power: '5000',
    colors: ['green','red'],
    effect: ''
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

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      UserHome(leader: widget.leader, imageString: widget.imageString),
      const LeaderSelection()
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
            child: Row(children: [
                const SizedBox(
                  height: 10,
                  width: 100,
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

