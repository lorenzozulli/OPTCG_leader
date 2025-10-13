import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget{
  final Leader leader;
  final String leaderImage;
  final bool isNewLeader;

  const UserHome ({super.key,
    required this.leader,
    required this.leaderImage,
    required this.isNewLeader
  });

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late int power;
  late String leaderName;
  late String leaderId;
  late int life;
  late String leaderColors;
  bool isAbilityUsed = false;
  String lint = '';

  void increasePower(){
    setState(() {
      power = power+1000;
      if(power>0) lint = '+';
      setPower(power);
    });
  }

  void decreasePower(){
    setState(() {
      power = power-1000;
      if(power<=0) lint = '';
      setPower(power);
    });
  }

  void increaseLife(){
    setState(() {
      life = life+1;
      setLife(life);
    });
  }

  void decreaseLife(){
    setState(() {
      if(life>0) life = life-1;
      setLife(life);
    });
  }

  Future<void> setPower(int power) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('power', power);
    await prefs.setBool('isNewLeader', false);
  }

  Future<void> getPower() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      power = prefs.getInt('power') as int;
      if(power>0) lint = '+';
    });
  }

  Future<void> setLife(int life) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('life', life);
    await prefs.setBool('isNewLeader', false);
  }

  Future<void> getLife() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      life = prefs.getInt('life') as int;
    });
  }
  
  Future<void> _initializeLeaderState() async {
    if (widget.isNewLeader) {
      resetStats();
    } else {
      setState(() {
        getPower();
        getLife();
      });
    }
  }

  void resetStats(){
    setState(() {
      life = int.parse(widget.leader.life);
      power = 0; 
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeLeaderState();
    leaderName = widget.leader.name;
    leaderId = widget.leader.id;
    
    if(widget.leader.colors.length == 1){
      leaderColors = widget.leader.colors[0];
    } else {
      leaderColors = "${widget.leader.colors[0]}_${widget.leader.colors[1]}";
    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "$leaderName - ($leaderId)",
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          )
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgrounds/$leaderColors.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.1), 
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(onPressed: decreasePower, child: const Text('-')),
                    Text('$lint$power'),
                    ElevatedButton(onPressed: increasePower, child: const Text('+'))
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isAbilityUsed = !isAbilityUsed;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          isAbilityUsed ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.color,
                            ),
                            child: Image.network(
                              widget.leaderImage,
                              width: 600,
                              height: 400
                            ),
                          )
                          : Image.network(
                              widget.leaderImage,
                              width: 600,
                              height: 400,
                            ),

                          if (isAbilityUsed)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffeb7233),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                )
                              ),
                              child: const Text('Ability Used',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: <Widget>[
                    ElevatedButton(onPressed: decreaseLife, child: const Text('-')),
                    Text('$life'),
                    ElevatedButton(onPressed: increaseLife, child: const Text('+'))
                  ],
                ),
              ]
            ),
            
          ],
        ),

        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.leader.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.leader.id),
              const SizedBox(
                height: 10,
              ),
              Text("power: ${widget.leader.power}"),
              const SizedBox(
                height: 10,
              ),
              Text("(${widget.leader.life}) LIFE"),
              const SizedBox(
                height: 10,
              ),
              Text(widget.leader.effect),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: resetStats,
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      )
    );
  }
}