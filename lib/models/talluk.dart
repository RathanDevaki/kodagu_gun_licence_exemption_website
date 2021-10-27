class Taluk {
  String talukCode;
  String talukName;
  String slNo;
  Taluk({required this.talukCode, required this.talukName, required this.slNo});

  factory Taluk.fromJson(Map<String, dynamic> json) {
    return Taluk(
      talukCode: json['taluk_code'] as String,
      talukName: json['taluk_name'] as String,
      slNo: json['sl_no'] as String,
    );
  }
}
