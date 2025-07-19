import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';

class UserHome extends StatefulWidget{
  final Leader leader;

  const UserHome ({super.key, required this.leader});

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
                  Center(
                    child: Text(
                      "Ability Used",
                    ),
                  );
                },
                child: Image.network(
                  widget.leader.images.imageEn,
                  width: 400,
                  height: 500,),  
                )
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