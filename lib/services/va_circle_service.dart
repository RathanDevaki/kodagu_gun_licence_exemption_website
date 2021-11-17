import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/models/va_circle.dart';
import 'package:http/http.dart' as http;

class VACircleServices {
  static const ROOT =
      "http://localhost/kodagu_gun_licence_exemption_website/va_circle_data.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE_VACIRCLE';
  static const _GET_VA_CIRCLE_ACTION = 'GET_VA_CIRCLE';
  static const _ADD_VA_CIRCLE_ACTION = 'ADD_VA_CIRCLE';
  static const _UPDATE_VA_CIRCLE_ACTION = 'UPDATE_VA_CIRCLE';
  static const _DELETE_VA_CIRCLE_ACTION = 'DELETE_VA_CIRCLE';
  static const _GET_TALUK = 'GET_TALUK';
  static const _GET_HOBLI = 'GET_HOBLI';

  static Future<String> createTable() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table VA_CIRCLE: ${response.body}');
    return response.body;
  }

  static Future<List<Taluk>> getTaluk() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_TALUK;
      //log('in Taluk');
      final response = await http.post(Uri.parse(ROOT), body: map);
      log(response.statusCode.toString());
      //   print('Get details : ${response.body}');

      if (200 == response.statusCode) {
        //    print('Response Code: ${response.statusCode}');
        List<Taluk> taluk_names = parseResponseTaluk(response.body);
        print('Returns getTaluk:$taluk_names');
        return taluk_names;
      } else {
        return <Taluk>[];
      }
    } catch (e) {
      return <Taluk>[];
      // print(e);
    }
  }

  static List<Taluk> parseResponseTaluk(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Taluk>((json) => Taluk.fromJson(json)).toList();
  }

  static Future<List<Hobli>> getHobli() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_HOBLI;
      log('in Hobli');
      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details hobli: ${response.body}');

      if (200 == response.statusCode) {
        log('Response Code: ${response.statusCode}');
        List<Hobli> hobli_list = parseResponseHobli(response.body);
        log('Returns getHobli:$hobli_list');
        return hobli_list;
      } else {
        return <Hobli>[];
      }
    } catch (e) {
      return <Hobli>[];
      // print(e);
    }
  }

  static List<Hobli> parseResponseHobli(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Hobli>((json) => Hobli.fromJson(json)).toList();
  }

//Get VA Circle
  static Future<List<VACircle>> getVACircle() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_VA_CIRCLE_ACTION;
      log('in CIRCLE');
      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details VA_CIRCLE: ${response.body}');

      if (200 == response.statusCode) {
        log('Response Code: ${response.statusCode}');
        List<VACircle> va_circle_list = parseResponseVACircle(response.body);
        log('Returns getVACircle:$va_circle_list');
        return va_circle_list;
      } else {
        return <VACircle>[];
      }
    } catch (e) {
      return <VACircle>[];
      // print(e);
    }
  }

  static List<VACircle> parseResponseVACircle(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<VACircle>((json) => VACircle.fromJson(json)).toList();
  }

  static Future<String> addVACircle(
      String selectedTaluk, String hobli_code, String hobli_name) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_VA_CIRCLE_ACTION;

      map['hobli_code'] = hobli_code;
      map['hobli_name'] = hobli_name;
      map['taluk_code'] = selectedTaluk;
      log('Selected $selectedTaluk');

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();

      if (200 == response.statusCode) {
        log('Response string Adding:$v');
        // getHobli();
        return response.body;
      } else {
        return "Error Adding Hobli";
      }
    } catch (e) {
      log('Exception :$e');
      getHobli();
      return "Something went wrong";
    }
  }

  static Future<String> updateVACircle(Hobli selected, String vaCircleCode,
      String hobli_code, String hobli_name) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_VA_CIRCLE_ACTION;
      map['va_circle_code'] = vaCircleCode;
      map['hobli_name'] = hobli_name;
      map['sl_no'] = selected.slNo;
      map['taluk_code'] = selected.taluk_code;
      // map['taluk_code']
      log(hobli_code);

      final response = await http.post(Uri.parse(ROOT), body: map);
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getHobli();
        return response.body;
      } else {
        return "Error Updating Hobli";
      }
    } catch (e) {
      log('Exception :$e');
      getHobli();
      return "Something went wrong";
    }
  }

  static Future<String> deleteVACircle(Hobli hobli_obj) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_VA_CIRCLE_ACTION;
      map['hobli_code'] = hobli_obj.hobliCode;
      map['sl_no'] = hobli_obj.slNo;

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getHobli();
        return response.body;
      } else {
        return "Error Deleting Hobli";
      }
    } catch (e) {
      log('Exception :$e');
      getHobli();
      return "Something went wrong";
    }
  }
}
