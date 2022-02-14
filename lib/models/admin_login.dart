class AdminLogin{
  String user_id;
  String password;
  String sl_no;
  String user_type;
  AdminLogin({
    required this.user_id,
    required this.password,
    required this.sl_no,
    required this.user_type,
  });
  factory AdminLogin.fromJson(Map<String, dynamic> json) {

    return AdminLogin(
        user_id: json['user_id'] as String,
        password: json['password'] as String,
      sl_no: json['sl_no'] as String,
      user_type: json['user_type'] as String,
    );

  }

}