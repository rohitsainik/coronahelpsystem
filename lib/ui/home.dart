import 'package:coronahelpsystem/ui/tabs/availablePage.dart';
import 'package:coronahelpsystem/ui/tabs/others.dart';
import 'package:coronahelpsystem/ui/tabs/request.dart';
import 'package:coronahelpsystem/ui/tabs/vaccine.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.distId}) : super(key: key);

  final String title;
  final String distId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Covid Help Center'),
          bottom: TabBar(
            labelPadding: const EdgeInsets.all(10),
            tabs: [
              Text(
                'Requests',
              ),
              Text(
                'Availability',
              ),
              Text(
                'Vaccine',
              ),
              Text(
                'Others',
              ),

            ],
          ),
        ),
        body: Center(
            child: TabBarView(
          children: [
            RequestPage(cityCode: widget.distId,),
            Availabilitypage(citycode: widget.distId,),
            vaccine(distId: widget.distId,),
            Others(),

          ],
        )),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
