class Hobli {
  String hobliCode;
  String hobliName;
  String slNo;
  String taluk_code;

  Hobli({
    required this.hobliCode,
    required this.hobliName,
    required this.slNo,
    required this.taluk_code,
  });

  factory Hobli.fromJson(Map<String, dynamic> json) {
    return Hobli(
      hobliCode: json['hobli_code'] as String,
      hobliName: json['hobli_name'] as String,
      slNo: json['sl_no'] as String,
      taluk_code: json['taluk_code'] as String,
    );
  }
}
