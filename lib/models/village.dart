class Village {
  String slNo;
  String talukName;
  String taluk_code;
  String hobliName;
  String hobli_code;
  String VACircleCode;
  String VACircleName;
  String villlageCode;
  String villageName;
  String villageName_ka;

  Village({
    required this.hobliName,
    required this.talukName,
    required this.slNo,
    required this.VACircleCode,
    required this.VACircleName,
    required this.taluk_code,
    required this.hobli_code,
    required this.villlageCode,
    required this.villageName,
    required this.villageName_ka,
  });

  factory Village.fromJson(Map<String, dynamic> json)
  {
    return Village(
      hobliName: json['hobli_name'] as String,
      talukName: json['taluk_name'] as String,
      slNo: json['sl_no'] as String,
      VACircleCode: json['va_circle_code'] as String,
      VACircleName: json['va_circle_name'] as String,
      taluk_code: json['taluk_code'] as String,
      hobli_code: json['hobli_code'] as String,
      villageName: json['village_name'] as String,
      villageName_ka: json['village_name_ka'] as String,
      villlageCode: json['village_code'] as String,
    );
  }
}
