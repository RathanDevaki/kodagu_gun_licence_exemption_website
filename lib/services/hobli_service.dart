import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:http/http.dart' as http;

class HobliServices {
  static const ROOT =
      "http://localhost/kodagu_gun_licence_exemption_website/hobli_data.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE_HOBLI';
  static const _GET_HOBLI_ACTION = 'GET_HOBLI';
  static const _ADD_HOBLI_ACTION = 'ADD_HOBLI';
  static const _UPDATE_HOBLI_ACTION = 'UPDATE_HOBLI';
  static const _DELETE_HOBLI_ACTION = 'DELETE_HOBLI';
  static const _GET_TALUK = 'GET_TALUK';

  static Future<String> createTable() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table HOBLI: ${response.body}');
    return response.body;
  }

  static Future<List<Taluk>> getTaluk() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_TALUK;
      log('in tlk');
      final response = await http.post(Uri.parse(ROOT), body: map);
      log(response.statusCode.toString());
      //   print('Get details : ${response.body}');

      if (200 == response.statusCode) {
        //    print('Response Code: ${response.statusCode}');
        List<Taluk> taluk_names = parseResponseHobliTaluk(response.body);
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

  static List<Taluk> parseResponseHobliTaluk(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Taluk>((json) => Taluk.fromJson(json)).toList();
  }

  static Future<List<Hobli>> getHobli() async {
    try {
      log('in Hobli');
      var map = Map<String, dynamic>();
      map['action'] = _GET_HOBLI_ACTION;

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

  static Future<String> addHobli(
      String selectedTaluk, String hobli_code, String hobli_name) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_HOBLI_ACTION;

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

  static Future<String> updateHobli(String? selectedTalluk, Hobli selected,
      String hobli_code, String hobli_name) async {
    try {
      var map = Map<String, dynamic>();

      map['action'] = _UPDATE_HOBLI_ACTION;
      map['hobli_code'] = hobli_code;
      map['hobli_name'] = hobli_name;
      map['taluk_code'] = selectedTalluk;
      map['constraint'] = selected.hobliCode;
      // map['taluk_code']
      log('Datas' +
          selectedTalluk.toString() +
          '--' +
          selected.hobliCode +
          '--' +
          hobli_code);
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

  static Future<String> deleteHobli(Hobli hobli_obj) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_HOBLI_ACTION;
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
