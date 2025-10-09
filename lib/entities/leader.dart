import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Leader {
  final String name;
  final String id;
  final Images images;
  final String life;
  final String power;
  final List<String> colors;
  final String effect;

  const Leader({
    required this.name, 
    required this.id, 
    required this.images, 
    required this.life,
    required this.power,
    required this.colors,
    required this.effect});

  factory Leader.fromJson(Map<dynamic, dynamic> json) {
    return Leader(
      name: json['name'] as String,
      id: json['id'] as String,
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      life: json['life'] as String,
      power: json['power'] as String,
      colors: List<String>.from(json['colors'] as List),
      effect: json['effect'] as String
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'id': id,
      'images': images.toJson(),
      'life': life,
      'power': power,
      'colors': colors,
      'effect': effect
    };
  }

  Future<void> saveLeader(Leader leader) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> leaderMap = leader.toJson();
    String leaderJson = jsonEncode(leaderMap);
    await prefs.setString('leader', leaderJson);
  }

  Future<Leader?> loadLeader() async {
    final prefs = await SharedPreferences.getInstance();
    String? leaderJson = prefs.getString('leader');

    if(leaderJson == null){
      return null;
    }

    Map<String, dynamic> leaderMap = jsonDecode(leaderJson);
    Leader leader = Leader.fromJson(leaderMap);

    return leader;
  }
}

class Images{
  final String imageEn;
  final List<String> imagesAlt;

  Images({
    required this.imageEn,
    required this.imagesAlt
  });

  factory Images.fromJson(Map<dynamic, dynamic> json) {
    return Images(
      imageEn: json['image_en'] as String,
      imagesAlt: List<String>.from(json['images_alt'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_en': imageEn,
      'images_alt': imagesAlt,
    };
  }
}