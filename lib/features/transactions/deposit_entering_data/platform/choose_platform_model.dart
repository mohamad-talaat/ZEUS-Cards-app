
class Platform {
  final int id;
  final String platform;
  final String code; // Add the 'code' property to your Platform class

  Platform({required this.id, required this.platform, required this.code});

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['id'],
      platform: json['platform'],
      code: json['code'], // Parse the 'code' from your JSON response
    );
  }
}