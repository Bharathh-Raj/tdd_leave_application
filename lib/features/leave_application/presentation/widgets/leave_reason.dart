import 'package:flutter/material.dart';

typedef LeaveReasonUpdateFunction = void Function(String value);

class LeaveReasonWidget extends StatelessWidget {
  final String? reason;
  final LeaveReasonUpdateFunction updateFunction;
  const LeaveReasonWidget({Key? key, required this.updateFunction, this.reason}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      const Text("Reason"),
      const SizedBox(
        height: 8,
      ),
      TextFormField(
        initialValue: reason,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        onChanged: updateFunction,
        decoration: const InputDecoration.collapsed(
            hintText: "Type your reason here...", filled: true, fillColor: Color(0xffF7F6F6)),
      )
    ]);
  }
}
