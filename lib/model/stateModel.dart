// To parse this JSON data, do
//
//     final stateDate = stateDateFromJson(jsonString);

import 'dart:convert';

StateDate stateDateFromJson(String str) => StateDate.fromJson(json.decode(str));

String stateDateToJson(StateDate data) => json.encode(data.toJson());

class StateDate {
  StateDate({
    this.states,
    this.ttl,
  });

  List<Stateindia> states;
  int ttl;

  factory StateDate.fromJson(Map<String, dynamic> json) => StateDate(
    states: List<Stateindia>.from(json["states"].map((x) => Stateindia.fromJson(x))),
    ttl: json["ttl"],
  );

  Map<String, dynamic> toJson() => {
    "states": List<dynamic>.from(states.map((x) => x.toJson())),
    "ttl": ttl,
  };
}

class Stateindia {
  Stateindia({
    this.stateId,
    this.stateName,
  });

  int stateId;
  String stateName;

  factory Stateindia.fromJson(Map<String, dynamic> json) => Stateindia(
    stateId: json["state_id"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_name": stateName,
  };
}
