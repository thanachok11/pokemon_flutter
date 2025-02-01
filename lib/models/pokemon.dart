class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final double height;
  final double weight;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  // สร้างจาก JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // ดึง URL ของ artwork หรือ fallback ไปที่ sprite เริ่มต้น
    String imageUrl = json["sprites"]["other"]["official-artwork"]
            ["front_default"] ??
        json["sprites"]["front_default"] ??
        "";

    return Pokemon(
      name: json["name"],
      imageUrl: imageUrl, // ใช้ artwork URL หรือ sprite fallback
      types: (json["types"] as List)
          .map((type) => type["type"]["name"].toString().capitalize())
          .toList(),
      height: json["height"] / 10, // dm -> m
      weight: json["weight"] / 10, // hg -> kg
    );
  }

  get url => null;

  Null get artworkUrl => null;
}

// Extension ทำให้ตัวอักษรตัวแรกเป็นตัวใหญ่
extension StringCasing on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}
