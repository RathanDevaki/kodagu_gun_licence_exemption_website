import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/models/va_circle.dart';
import 'package:admin/models/village.dart';
import 'package:http/http.dart' as http;

class VillageServices {
  static const ROOT =
      "http://localhost/kodagu_gun_licence_exemption_website/va_circle_data.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE_VILLAGE';
  static const _GET_VILLAGE_ACTION = 'GET_VILLAGE';
  static const _ADD_VILLAGE_ACTION = 'ADD_VILLAGE';
  static const _UPDATE_VILLAGE_ACTION = 'UPDATE_VILLAGE';
  static const _DELETE_VILLAGE_ACTION = 'DELETE_VILLAGE';
  static const _GET_TALUK = 'GET_TALUK';
  static const _GET_HOBLI = 'GET_HOBLI';
  static const _GET_VA_CIRCLE = 'GET_VA_CIRCLE';

  static Future<String> createTable() async
  {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table Village: ${response.body}');
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

  static Future<List<Hobli>> getHobliForDropdown() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_HOBLI;
      log('in Hobli');
      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details hobli: ${response.body}');

      if (200 == response.statusCode)
      {
        log('Response Code: ${response.statusCode}');
        List<Hobli> hobli_list = parseResponseHobli(response.body);
        log('Returns getHobli:$hobli_list');
        return hobli_list;
      } else
      {
        return <Hobli>[];
      }
    }
    catch (e) {
      return <Hobli>[];
      // print(e);
    }
  }
  static List<Hobli> parseResponseHobli(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Hobli>((json) => Hobli.fromJson(json)).toList();
  }


  static Future<List<VACircle>> getVAForDropdown() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_VA_CIRCLE;
      log('in VA');
      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details VA Circle: ${response.body}');

      if (200 == response.statusCode)
      {
        log('Response Code: ${response.statusCode}');
        List<VACircle> va_circle_list = parseResponseVACircle(response.body);
        log('Returns getHobli:$va_circle_list');
        return va_circle_list;
      } else
      {
        return <VACircle>[];
      }
    }
    catch (e) {
      return <VACircle>[];
      // print(e);
    }
  }
  static List<VACircle> parseResponseVACircle(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<VACircle>((json) => VACircle.fromJson(json)).toList();
  }

  //Get Village
  static Future<List<Village>> getVillage() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_VILLAGE_ACTION;
      log('in Village');
      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details Village: ${response.body}');

      if (200 == response.statusCode)
      {
        log('Response Code : ${response.statusCode}');
        List<Village> village_list = parseResponseVillage(response.body);
        log('Returns getVACircle:$village_list');
        return village_list;
      } else {
        return <Village>[];
      }
    } catch (e) {
      return <Village>[];
      // print(e);
    }
  }

  static List<Village> parseResponseVillage(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Village>((json) => Village.fromJson(json)).toList();
  }

  static Future<String> addVillage(String selectedTaluk, String selectedHobli,String selectedVACircle,
      String villageCode, String villageName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_VILLAGE_ACTION;

      map['village_code']=villageCode;
      map['village_name'] = villageName;
      map['taluk_code'] = selectedTaluk;
      map['hobli_code'] = selectedHobli;
      map['va_circle_code'] = selectedVACircle;
      log('Selected $selectedTaluk');

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();

      if (200 == response.statusCode) {
        log('Response string Adding:$v');
        getVillage();
        return response.body;
      } else {
        return "Error Adding Village";
      }
    }
    catch (e) {
      log('Exception :$e');
      getVillage();
      return "Something went wrong";
    }
  }

  static Future<String> updateVACircle(
      VACircle selected, String vaCircleCode, String vaCircleName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_VILLAGE_ACTION;
      map['va_circle_code'] = vaCircleCode;
      map['va_circle_name'] = vaCircleName;
      map['hobli_code'] = selected.hobliName;
      map['sl_no'] = selected.slNo;
      map['taluk_code'] = selected.talukName;
      map['constraints']=selected.VACircleCode;

      log('Ser_tqCOde'+selected.talukName);

      final response = await http.post(Uri.parse(ROOT), body: map);
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getVillage();
        return response.body;
      } else {
        return "Error Updating VA Circle";
      }
    } catch (e) {
      log('Exception :$e');
      getVillage();
      return "Something went wrong";
    }
  }

  static Future<String> deleteVACircle(VACircle vaCircle) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_VILLAGE_ACTION;
      map['va_circle_code'] = vaCircle.VACircleCode;
      map['sl_no'] = vaCircle.slNo;

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getVillage();
        return response.body;
      } else {
        return "Error Deleting VA Circle";
      }
    } catch (e) {
      log('Exception :$e');
      getVillage();
      return "Something went wrong";
    }
  }
}
