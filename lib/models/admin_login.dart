class AdminLogin{
  String userName;
  String password;
  AdminLogin({required this.userName,required this.password,});
  factory AdminLogin.fromJson(map<String,dynamic> json){
    return AdminLogin(
        userName: json['username'] as String,
        password: json['password'] as String,
    );

  }

}