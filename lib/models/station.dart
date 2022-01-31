class Station {
String slNo;
String station_code;
String station_name_en;
String station_name_ka;
String taluk_code;
String taluk_name;
Station({required this.station_name_en,required this.station_code,required this.station_name_ka,required this.slNo,required this.taluk_code,required this.taluk_name});

factory Station.fromJson(Map<String,dynamic> json){
  return Station(
    station_name_en: json['station_name_en'] as String,
    station_code:json['station_code'] as String,
    station_name_ka: json['station_name_ka']as String,
    slNo: json['slNO']as String,
    taluk_code: json['taluk_code']as String,
    taluk_name: json['taluk_name'] as String,
  );
}
}
