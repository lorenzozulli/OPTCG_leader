import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/main.dart';

class Leaderdetails extends StatelessWidget {
  final Leader leader;
  const Leaderdetails({super.key, required this.leader});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(leader.images.imageEn),
          ),
          buttonArrow(context),
          scroll(),
        ],
      ),
    ));
  }

  buttonArrow(BuildContext context) {
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

  scroll() {
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
                    leader.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    leader.id,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    leader.id,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Alt Images",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp(leader: leader),
                        ),
                      );
                    },
                    child: Image.network(
                      leader.images.imageEn,
                      width: 200,
                      height: 500,
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: leader.images.imagesAlt.length,
                    itemBuilder: (context, index) => altLeaders(context, index),
                  ),
                ],
              ),
            ),
          );
        });
  }

  altLeaders(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyApp(leader: leader),
                ),
              );
            },
            child: Image.network(
              leader.images.imagesAlt[index],
              width: 200,
              height: 500,
            ),
          ),
        ],
      ),
    );
  }

}