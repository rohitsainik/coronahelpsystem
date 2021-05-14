import 'dart:convert';

import 'package:coronahelpsystem/base/appApi.dart';
import 'package:coronahelpsystem/model/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class vaccine extends StatefulWidget {

  final String distId;
  const vaccine({Key key,this.distId}) : super(key: key);

  @override
  _vaccineState createState() => _vaccineState();
}

class _vaccineState extends State<vaccine> {
  Future<List<vCenters>> getVaccineData() async {
    print('yes');
    final DateTime now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    String url = AppApi.vaccineBydistrict + "?district_id=${widget.distId}&date=$formatted";
    final response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    List<vCenters> articles = VaccineData.fromJson(data).centers;
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<vCenters>>(
      stream: Stream.periodic(Duration(seconds: 3))
          .asyncMap((i) => getVaccineData()),
      // i is null here (check periodic docs)
      builder: (context, snapshot) {
        List<vCenters> vaccine = snapshot.data;
        print(vaccine);
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            child: Center(
              child: Text(
                'Please Try Again Later',
                style: GoogleFonts.robotoMono(color: Colors.red, fontSize: 25),
              ),
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(child: Center(child: CircularProgressIndicator()));
          default:
            if (vaccine.length == 0)
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Slot Available',
                    style:
                        GoogleFonts.robotoMono(color: Colors.red, fontSize: 25),
                  ),
                ),
              );
            else
              return ListView.builder(
                  itemCount: vaccine.length,
                  itemBuilder: (_, index) {
                    var cardColors = vaccine[index].sessions[0].availableCapacity >0 ? Colors.green :Colors.red;
                    return Card(
                      // shape: RoundedRectangleBorder(
                      //   side: BorderSide(
                      //     color: cardColors,
                      //     width: 2.0,
                      //   ),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    vaccine[index].name.toString(),
                                    style: GoogleFonts.robotoMono(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(
                                  vaccine[index].sessions[0].date.toString(),
                                  style: GoogleFonts.robotoMono(
                                      color: cardColors,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(vaccine[index].address.toString(),
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            Text(
                                '${vaccine[index].blockName.toString()} (${vaccine[index].districtName.toString()})',
                                style: GoogleFonts.robotoMono(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                  color: cardColors,
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                        'Slots : ${vaccine[index].sessions[0].availableCapacity.toString()}',
                                        style: GoogleFonts.robotoMono(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                    ),
                                  ),
                                ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        color: cardColors,
                                        padding: const EdgeInsets.all(5),
                                        child: Center(
                                          child: Text(
                                            '${vaccine[index].sessions[0].vaccine.toString()}',
                                            style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        color: cardColors,
                                        padding: const EdgeInsets.all(5),
                                        child: Center(
                                          child: Text(
                                            'Age : +${vaccine[index].sessions[0].minAgeLimit.toString()}',
                                            style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  });
        }
      }, // builder should also handle the case when data is not fetched yet
    );
  }
}
