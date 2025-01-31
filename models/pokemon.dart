class Pokemon {
  final String name;
  final String imageUrl;
  final String type; // เพิ่ม type
  final double height; // เพิ่ม height
  final double weight; // เพิ่ม weight

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      type: json['types'][0]['type']['name'], // ดึง type
      height: json['height'] / 10, // แปลงเป็นเมตร
      weight: json['weight'] / 10, // แปลงเป็นกิโลกรัม
    );
  }
}
