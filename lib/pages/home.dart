import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';

class UserHome extends StatefulWidget{
  final Leader leader;
  final String leaderImage;

  const UserHome ({super.key, required this.leader, required this.leaderImage});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int power = 0;
  String lint = '';

  void increasePower(){
    setState(() {
      power = power+1000;
      if(power>0){
        lint = '+';
      }
    });
  }

  void decreasePower(){
    setState(() {
      power = power-1000;
      if(power<=0){
        lint = '';
      }
    });
  }

  late int life;

  void increaseLife(){
    setState(() {
      life = life+1;
    });
  }

  void decreaseLife(){
    setState(() {
      if(life>0) life = life-1;
    });
  }

  bool _isAbilityUsed = false;

  void resetLeader(){
    setState(() {
      life = int.parse(widget.leader.life);
      power = 0; 
    });
  }

  late String _leaderName;

  @override
  void initState(){
    super.initState();
        life = int.parse(widget.leader.life);
        _leaderName = widget.leader.name;
      }

    @override
    Widget build(BuildContext context){
      return MaterialApp(
        home: Scaffold(
          
        appBar: AppBar(
          title: Text(_leaderName)),

        body: Column(
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
                    _isAbilityUsed = !_isAbilityUsed;
                  });
                },
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                    // L'immagine che cambia
                    _isAbilityUsed
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.saturation,
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

                    if (_isAbilityUsed)
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
                          child: const Text(
                            'Ability Used',
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

      drawer: Drawer(
        child: Row(children: [
            const SizedBox(
              height: 10,
              width: 100,
            ),
            ElevatedButton(
              onPressed: resetLeader,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    )
      );
    }
}