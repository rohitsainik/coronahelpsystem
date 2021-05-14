import 'dart:convert';

import 'package:coronahelpsystem/model/vaccine.dart';
import 'package:http/http.dart' as http;
import 'package:coronahelpsystem/base/appApi.dart';

abstract class VaccineRepository {
  Future<List<vCenters>> getVaccineSlots();
}

class VaccineRepositoryImpl implements VaccineRepository {

  @override
  Future<List<vCenters>> getVaccineSlots() async {
    var response = await http.get(
      Uri.parse(AppApi.vaccineByPin),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<vCenters> articles = VaccineData.fromJson(data).centers;

      return articles;
    } else {
      throw Exception();
    }
  }

}