import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/admin_login.dart';
import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/screens/admin_login.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  static const ROOT =
      "http://localhost/kodagu_gun_licence_exemption_website/login_data.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE_LOGIN';
  static const _GET_ADMIN = 'GET_ADMIN_LOGIN';
  static const _GET_ADMIN1 = 'GET_ADMIN_LOGIN1';
  // static const _ADD_TALUK_ACTION = 'ADD_TALUK';
  // static const _UPDATE_TALUK_ACTION = 'UPDATE_TALUK';
  // static const _DELETE_TALUK_ACTION = 'DELETE_TALUK';

  // static const _GET_HOBLI = 'GET_HOBLI';

  static Future<String> createTableAdmin() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table Admin Login: ${response.body}');
    return response.body;
  }

  static Future<List<AdminLogin>> getAdminLogin(String _user_id,String _password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ADMIN;
      map['user_id']= _user_id;
      map['password'] = _password;
      log('in getAdmin');
      final response = await http.post(Uri.parse(ROOT), body: map);
      //log('in getTaluk 1');
      print('Get details : ${response.body}');
      log(response.statusCode.toString());
      if (200 == response.statusCode) {
        List<AdminLogin> list = parseResponse(response.body);
        log('Returns getAdmin: $list');
        return list;
      } else {
        return <AdminLogin>[];
      }
    } catch (e) {
      return <AdminLogin>[];
      // print(e);
    }
  }

  static List<AdminLogin> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<AdminLogin>((json) => AdminLogin.fromJson(json)).toList();
  }
  static Future<List<AdminLogin>> getAdminLogin1() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ADMIN1;

      log('in getAdmin');
      final response = await http.post(Uri.parse(ROOT), body: map);
      //log('in getTaluk 1');
      print('Get details : ${response.body}');
      log(response.statusCode.toString());
      if (200 == response.statusCode) {
        List<AdminLogin> list = parseResponse1(response.body);
        log('Returns getAdmin: $list');
        return list;
      } else {
        return <AdminLogin>[];
      }
    } catch (e) {
      return <AdminLogin>[];
      // print(e);
    }
  }

  static List<AdminLogin> parseResponse1(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<AdminLogin>((json) => AdminLogin.fromJson(json)).toList();
  }

}
