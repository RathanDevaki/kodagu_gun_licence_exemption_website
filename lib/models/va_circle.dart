class VACircle {
  String slNo;
  String talukName;
  String hobliName;
  String VACircleCode;
  String VACircleName;

  VACircle({
    required this.hobliName,
    required this.talukName,
    required this.slNo,
    required this.VACircleCode,
    required this.VACircleName,
  });

  factory VACircle.fromJson(Map<String, dynamic> json) {
    return VACircle(
      hobliName: json['hobli_name'] as String,
      talukName: json['taluk_name'] as String,
      slNo: json['sl_no'] as String,
      VACircleCode: json['va_circle_code'] as String,
      VACircleName: json['va_circle_name'] as String,
    );
  }
}
