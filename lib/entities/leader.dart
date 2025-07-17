class Leader {
  final String name;
  final String id;
  final Images images;
  final String life;
  final String power;
  final List<String> colors;

  const Leader({
    required this.name, 
    required this.id, 
    required this.images, 
    required this.life,
    required this.power,
    required this.colors});

factory Leader.fromJson(Map<dynamic, dynamic> json) {
    return Leader(
      name: json['name'] as String,
      id: json['id'] as String,
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      life: json['life'] as String,
      power: json['power'] as String,
      colors: List<String>.from(json['colors'] as List),
    );
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
}