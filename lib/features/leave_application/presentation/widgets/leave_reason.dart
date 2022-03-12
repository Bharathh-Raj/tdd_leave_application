import 'package:flutter/material.dart';

class LeaveReasonWidget extends StatelessWidget {
  const LeaveReasonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      const Text("Reason"),
      const SizedBox(
        height: 8,
      ),
      TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        decoration: InputDecoration.collapsed(
            hintText: "Type your reason here...", filled: true, fillColor: Color(0xffF7F6F6)),
      )
    ]);
  }
}
