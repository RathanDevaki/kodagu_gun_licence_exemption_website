class VACircle {
  String vaCircleName;
  VACircle({required this.vaCircleName});

  factory VACircle.fromJson(Map<String, dynamic> json) {
    return VACircle(vaCircleName: json['va_circle_name'] as String);
  }
}
