import 'package:flutter/material.dart';
class RequestForm extends StatefulWidget {
  const RequestForm({Key key}) : super(key: key);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
