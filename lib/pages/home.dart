import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';

class UserHome extends StatefulWidget{
  final Leader leader;
  final String imageString;

  const UserHome ({super.key, required this.leader, required this.imageString});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  
  int power = 0;

  void increasePower(){
    setState(() {
      power = power+1000;
    });
  }

  void decreasePower(){
    setState(() {
      power = power-1000;
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


  @override
  void initState(){
    super.initState();
      try{
        life = int.parse(widget.leader.life);
      } catch (e) {
        print(e);
      }
  }

    @override
    Widget build(BuildContext context){
      return MaterialApp(
        home: Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget>[
              ElevatedButton(onPressed: decreasePower, child: const Text('-')),
              Text('$power'),
              ElevatedButton(onPressed: increasePower, child: const Text('+'))
            ],
          ),

          Row(
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
                              widget.imageString,
                              width: 400,
                              height: 500
                            ),
                          )
                        : Image.network(
                          widget.imageString,
                          width: 400,
                          height: 500,
                        ),

                    // Il testo che appare solo quando l'abilità è usata
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
    )
      );
    }
}