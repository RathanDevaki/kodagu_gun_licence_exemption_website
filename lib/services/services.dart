import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/talluk.dart';
import 'package:http/http.dart' as http;

class Services {
  static const ROOT =
      "http://localhost/kodagu_gun_licence_exemption_website/exemption.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_TALUK';
  static const _ADD_TALUK_ACTION = 'ADD_TALUK';
  static const _UPDATE_TALUK_ACTION = 'UPDATE_TALUK';
  static const _DELETE_TALUK_ACTION = 'DELETE_TALUK';

  static Future<String> createTable() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table Taluk: ${response.body}');
    return response.body;
  }

  static Future<List<Taluk>> getTaluk() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      log('in getTaluk');
      final response = await http.post(Uri.parse(ROOT), body: map);
      //log('in getTaluk 1');
      print('Get details : ${response.body}');
      if (200 == response.statusCode) {
        List<Taluk> list = parseResponse(response.body);
        log('Returns getTaluk:$list');
        return list;
      } else {
        return <Taluk>[];
      }
    } catch (e) {
      return <Taluk>[];
      // print(e);
    }
  }

  static List<Taluk> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Taluk>((json) => Taluk.fromJson(json)).toList();
  }

  static Future<String> addTaluk(String taluk_code, String taluk_name) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_TALUK_ACTION;
      map['taluk_code'] = taluk_code;
      map['taluk_name'] = taluk_name;
      log(taluk_code);

      final response = await http.post(Uri.parse(ROOT), body: map);
      // print('addTaluk response: ${response.body}');
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getTaluk();
        return response.body;
      } else {
        return "Error Adding Taluks";
      }
    } catch (e) {
      log('Exception :$e');
      getTaluk();
      return "Something went wrong";
    }
  }

  static Future<String> updateTaluk(
      String taluk_code, String taluk_name, String sl_no) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_TALUK_ACTION;
      map['taluk_code'] = taluk_code;
      map['taluk_name'] = taluk_name;
      map['sl_no'] = sl_no;
      log(taluk_code);

      final response = await http.post(Uri.parse(ROOT), body: map);
      // print('addTaluk response: ${response.body}');
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getTaluk();
        return response.body;
      } else {
        return "Error Updating Taluk";
      }
    } catch (e) {
      log('Exception :$e');
      getTaluk();
      return "Something went wrong";
    }
  }

  static Future<String> deleteTaluk(Taluk taluk_obj) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_TALUK_ACTION;
      map['taluk_code'] = taluk_obj.talukCode;
      map['sl_no'] = taluk_obj.slNo;
      //  log('Taluk code :${taluk_code} , SL No ${sl_no} ');

      final response = await http.post(Uri.parse(ROOT), body: map);
      // print('addTaluk response: ${response.body}');
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getTaluk();
        return response.body;
      } else {
        return "Error Deleting Taluk";
      }
    } catch (e) {
      log('Exception :$e');
      getTaluk();
      return "Something went wrong";
    }
  }
}
