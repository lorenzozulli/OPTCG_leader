class Leader {
  final String name;
  final String id;
  final String image;
  final String life;
  final String power;
  final List<String> colors;

  const Leader({
    required this.name, 
    required this.id, 
    required this.image, 
    required this.life,
    required this.power,
    required this.colors});

factory Leader.fromJson(Map<String, dynamic> json) {
    return Leader(
      name: json['name'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      life: json['life'] as String,
      power: json['power'] as String,
      colors: List<String>.from(json['colors'] as List),
    );
  }
}