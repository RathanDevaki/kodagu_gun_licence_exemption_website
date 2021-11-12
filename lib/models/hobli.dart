class Hobli {
  String hobliCode;
  String hobliName;
  String slNo;
  String taluk_name;
  Hobli(
      {required this.hobliCode,
      required this.hobliName,
      required this.slNo,
      required this.taluk_name});

  factory Hobli.fromJson(Map<String, dynamic> json) {
    return Hobli(
      hobliCode: json['hobli_code'] as String,
      hobliName: json['hobli_name'] as String,
      slNo: json['sl_no'] as String,
      taluk_name: json['taluk_name'] as String,
    );
  }
}
