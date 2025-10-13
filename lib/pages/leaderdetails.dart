import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderdetails extends StatefulWidget{
  final Leader leader;
  const Leaderdetails({super.key, required this.leader});

  @override
  State<Leaderdetails> createState() => _LeaderDetailsState();
}

class _LeaderDetailsState extends State<Leaderdetails>{

  Future<void> _completeOnBoarding(String imagetype) async{
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('isFirstTime', false);
    widget.leader.setSavedLeader(widget.leader);
    await prefs.setString('leaderImage', imagetype);
    await prefs.setBool('isNewLeader', true);

    if(mounted){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => 
          MyApp(
            isFirstTime: false, 
            leader: widget.leader, 
            leaderImage: imagetype, 
            isNewLeader: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              child: Transform.scale(
                scale: 1.11,
                child: Transform.translate(
                  offset: const Offset(0.0, -90.0),
                  child: Image.network(widget.leader.images.imageEn),
                )
              ),
            ),
            buttonArrow(context),
            scroll(),
          ],
        ),
      )
    );
  }

  Padding buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DraggableScrollableSheet scroll() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.leader.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.leader.id,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Effect",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.leader.effect,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Images",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){
                      _completeOnBoarding(widget.leader.images.imageEn);
                    },
                    child: Image.network(
                      widget.leader.images.imageEn,
                      height: 300,
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.leader.images.imagesAlt.length,
                    itemBuilder: (context, index) => altLeaders(context, index),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Padding altLeaders(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              _completeOnBoarding(widget.leader.images.imagesAlt[index]);
            },
            child: Image.network(
              widget.leader.images.imagesAlt[index],
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}