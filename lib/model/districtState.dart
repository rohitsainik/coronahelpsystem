// To parse this JSON data, do
//
//     final districtData = districtDataFromJson(jsonString);

import 'dart:convert';

DistrictData districtDataFromJson(String str) => DistrictData.fromJson(json.decode(str));

String districtDataToJson(DistrictData data) => json.encode(data.toJson());

class DistrictData {
  DistrictData({
    this.districts,
    this.ttl,
  });

  List<District> districts;
  int ttl;

  factory DistrictData.fromJson(Map<String, dynamic> json) => DistrictData(
    districts: List<District>.from(json["districts"].map((x) => District.fromJson(x))),
    ttl: json["ttl"],
  );

  Map<String, dynamic> toJson() => {
    "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
    "ttl": ttl,
  };
}

class District {
  District({
    this.districtId,
    this.districtName,
  });

  int districtId;
  String districtName;

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json["district_id"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId,
    "district_name": districtName,
  };
}
