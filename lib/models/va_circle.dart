class VACircle {
  String slNo;
  String talukCode;
  String hobliCode;
  String VACircleCode;
  String VACircleName;

  VACircle({
    required this.hobliCode,
    required this.talukCode,
    required this.slNo,
    required this.VACircleCode,
    required this.VACircleName,
  });

  factory VACircle.fromJson(Map<String, dynamic> json) {
    return VACircle(
      hobliCode: json['hobli_code'] as String,
      talukCode: json['taluk_code'] as String,
      slNo: json['sl_no'] as String,
      VACircleCode: json['va_circle_code'] as String,
      VACircleName: json['va_circle_name'] as String,
    );
  }
}
