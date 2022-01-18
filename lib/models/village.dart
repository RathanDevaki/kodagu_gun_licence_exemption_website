class Village {
  String slNo;
  String talukName;
  String hobliName;
  String VACircleName;
  String villageCode;
  String villageName;

  Village({
    required this.hobliName,
    required this.talukName,
    required this.slNo,
    required this.VACircleName,
    required this.villageCode,
    required this.villageName,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      hobliName: json['hobli_name'] as String,
      talukName: json['taluk_name'] as String,
      slNo: json['sl_no'] as String,
      VACircleName: json['va_circle_name'] as String,
      villageCode: json['village_name'] as String,
      villageName: json['village_code'] as String,
    );
  }
}//https://github.com/flutter/flutter/issues/69398
