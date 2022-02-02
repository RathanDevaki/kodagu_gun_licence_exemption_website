import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/station.dart';
import 'package:admin/models/talluk.dart';
import 'package:http/http.dart' as http;

class StationServices {
  static const ROOT = "http://localhost/kodagu_gun_licence_exemption_website/police_station_data.php";

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE_POLICE_STATION';
  static const _GET_STATION_ACTION = 'GET_STATION';
  static const _ADD_STATION_ACTION = 'ADD_STATION';
  static const _UPDATE_STATION_ACTION = 'UPDATE_STATION';
  static const _DELETE_STATION_ACTION = 'DELETE_STATION';
  static const _GET_TALUK = 'GET_TALUK';

  static Future<String> createTable() async {
    var map = Map<String, dynamic>();
    map['action'] = _CREATE_TABLE_ACTION;
    final response = await http.post(Uri.parse(ROOT), body: map);
    print('Create table STATION: ${response.body}');
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

      if (200 == response.statusCode)
      {
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

  static List<Taluk> parseResponseTaluk(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Taluk>((json) => Taluk.fromJson(json)).toList();
  }

  static Future<List<Station>> getStation() async {
    try {
      log('in Station');
      var map = Map<String, dynamic>();
      map['action'] = _GET_STATION_ACTION;

      final response = await http.post(Uri.parse(ROOT), body: map);

      log('Get details STation: ${response.body}');

      if (200 == response.statusCode) {
        log('Response Code: ${response.statusCode}');
        List<Station> station_list = parseResponseStation(response.body);
        log('Returns getStation:$station_list');
        return station_list;
      } else {
        return <Station>[];
      }
    } catch (e) {
      return <Station>[];
      // print(e);
    }
  }

  static List<Station> parseResponseStation(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Station>((json) => Station.fromJson(json)).toList();
  }

  static Future<String> addStation(
      String selectedTaluk, String station_code, String station_name_en,String station_name_ka) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_STATION_ACTION;

      map['station_code'] = station_code;
      map['station_name_en'] = station_name_en;
      map['station_name_ka'] = station_name_ka;
      map['taluk_code'] = selectedTaluk;
      log('Selected $selectedTaluk');

      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();

      if (200 == response.statusCode) {
        log('Response string Adding:$v');
        // getHobli();
        return response.body;
      } else {
        return "Error Adding Station";
      }
    } catch (e) {
      log('Exception :$e');
      getStation();
      return "Something went wrong";
    }
  }

  static Future<String> updateStation(String? selectedTalluk, Station selected,
      String station_code, String station_name_en,String station_name_ka) async {
    try {
      var map = Map<String, dynamic>();

      map['action'] = _UPDATE_STATION_ACTION;
      map['station_code'] = station_code;
      map['station_name_en'] = station_name_en;
      map['station_name_ka'] = station_name_ka;
      map['taluk_code'] = selectedTalluk;
      map['constraint'] = selected.station_code;
      map['taluk_name'] = selected.taluk_name;

      log('Datas: selected tq $selectedTalluk , $station_code , $station_name_en , $station_name_ka , '+selected.station_code +'='+ selected.taluk_name);
      final response = await http.post(Uri.parse(ROOT), body: map);
      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getStation();
        return response.body;
      } else {
        return "Error Updating Station";
      }
    } catch (e) {
      log('Exception :$e');
      getStation();
      return "Something went wrong";
    }
  }

  static Future<String> deleteStation(String st_code) async
  {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_STATION_ACTION;
      map['station_code'] = st_code;

      log('sl_nooo'+st_code);
      final response = await http.post(Uri.parse(ROOT), body: map);

      String v = response.statusCode.toString();
      log('Response string :$v');
      if (200 == response.statusCode) {
        getStation();
        return response.body;
      } else {
        return "Error Deleting Hobli";
      }
    }
    catch (e) {
      log('Exception :$e');
      getStation();
      return "Something went wrong $e";
    }
  }
}
