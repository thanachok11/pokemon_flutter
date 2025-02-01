class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final double height;
  final double weight;
  final Map<String, int> stats; // เปลี่ยนเป็น Map เพื่อเก็บชื่อ stat กับค่า

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
  });

  // สร้างจาก JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // ดึง URL ของ artwork หรือ fallback ไปที่ sprite เริ่มต้น
    String imageUrl = json["sprites"]["other"]["official-artwork"]
            ["front_default"] ??
        json["sprites"]["front_default"] ??
        "";

    // ดึงค่า stats และแปลงเป็น Map<String, int>
    Map<String, int> stats = {
      "HP": json["stats"][0]["base_stat"],
      "Attack": json["stats"][1]["base_stat"],
      "Defense": json["stats"][2]["base_stat"],
      "Special Attack": json["stats"][3]["base_stat"],
      "Special Defense": json["stats"][4]["base_stat"],
      "Speed": json["stats"][5]["base_stat"],
    };

    return Pokemon(
      name: json["name"],
      imageUrl: imageUrl, // ใช้ artwork URL หรือ sprite fallback
      types: (json["types"] as List)
          .map((type) => type["type"]["name"].toString().capitalize())
          .toList(),
      height: json["height"] / 10, // dm -> m
      weight: json["weight"] / 10, // hg -> kg
      stats: stats, // เก็บ stats ในรูปแบบ Map
    );
  }
}

// Extension ทำให้ตัวอักษรตัวแรกเป็นตัวใหญ่
extension StringCasing on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}
