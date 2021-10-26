class Taluk {
  String talukCode;
  String talukName;

  Taluk({required this.talukCode, required this.talukName});

  factory Taluk.fromJson(Map<String, dynamic> json) {
    return Taluk(
      talukCode: json['taluk_code'] as String,
      talukName: json['taluk_name'] as String,
    );
  }
}
