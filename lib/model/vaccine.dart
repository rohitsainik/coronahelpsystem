// To parse this JSON data, do
//
//     final vaccineData = vaccineDataFromJson(jsonString);

import 'dart:convert';

VaccineData vaccineDataFromJson(String str) => VaccineData.fromJson(json.decode(str));

String vaccineDataToJson(VaccineData data) => json.encode(data.toJson());

class VaccineData {
  VaccineData({
    this.centers,
  });

  List<vCenters> centers;

  factory VaccineData.fromJson(Map<String, dynamic> json) => VaccineData(
    centers: List<vCenters>.from(json["centers"].map((x) => vCenters.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "centers": List<dynamic>.from(centers.map((x) => x.toJson())),
  };
}

class vCenters {
  vCenters({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pincode,
    this.lat,
    this.long,
    this.from,
    this.to,
    this.feeType,
    this.sessions,
  });

  int centerId;
  String name;
  String address;
  var stateName;
  var districtName;
  String blockName;
  int pincode;
  int lat;
  int long;
  String from;
  String to;
  var feeType;
  List<Session> sessions;

  factory vCenters.fromJson(Map<String, dynamic> json) => vCenters(
    centerId: json["center_id"],
    name: json["name"],
    address: json["address"],
    stateName: json["state_name"],
    districtName: json["district_name"],
    blockName: json["block_name"],
    pincode: json["pincode"],
    lat: json["lat"],
    long: json["long"],
    from: json["from"],
    to: json["to"],
    feeType: json["fee_type"],
    sessions: List<Session>.from(json["sessions"].map((x) => Session.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "center_id": centerId,
    "name": name,
    "address": address,
    "state_name": stateName,
    "district_name": districtName,
    "block_name": blockName,
    "pincode": pincode,
    "lat": lat,
    "long": long,
    "from": from,
    "to": to,
    "fee_type": feeType,
    "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
  };
}



class Session {
  Session({
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.minAgeLimit,
    this.vaccine,
    this.slots,
  });

  String sessionId;
  var date;
  int availableCapacity;
  int minAgeLimit;
  var vaccine;
  List<String> slots;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    sessionId: json["session_id"],
    date: json["date"],
    availableCapacity: json["available_capacity"],
    minAgeLimit: json["min_age_limit"],
    vaccine: json["vaccine"],
    slots: List<String>.from(json["slots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "session_id": sessionId,
    "date": date,
    "available_capacity": availableCapacity,
    "min_age_limit": minAgeLimit,
    "vaccine": vaccine,
    "slots": List<dynamic>.from(slots.map((x) => x)),
  };
}

