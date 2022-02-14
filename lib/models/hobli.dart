class Hobli {
  String hobliCode;
  String hobliName;
  String hobliName_ka;
  String slNo;
  String taluk_name;
String taluk_code;

  Hobli({
    required this.hobliCode,
    required this.hobliName,
    required this.hobliName_ka,
    required this.slNo,
    required this.taluk_name,
    required this.taluk_code,
  });

  factory Hobli.fromJson(Map<String, dynamic> json) {
    return Hobli(
      slNo: json['sl_no'] as String,
      hobliCode: json['hobli_code'] as String,
      hobliName: json['hobli_name'] as String,
      hobliName_ka: json['hobli_name_ka'] as String,
      taluk_name: json['taluk_name'] as String,
      taluk_code: json['taluk_code'] as String,
    );
  }
}
