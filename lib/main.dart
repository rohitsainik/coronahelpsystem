import 'package:coronahelpsystem/bloc/vaccine_bloc.dart';
import 'package:coronahelpsystem/repo/vaccinerepo.dart';
import 'package:coronahelpsystem/ui/register/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => VaccineBloc(vaccineRepository: VaccineRepositoryImpl()),
        child: SelectState(),
      ),
    );
  }
}

