import 'package:flutter/material.dart';

import '../../domain/leave_type.dart';

class LeaveTypeWidget extends StatefulWidget {
  const LeaveTypeWidget({Key? key}) : super(key: key);

  @override
  State<LeaveTypeWidget> createState() => _LeaveTypeWidgetState();
}

class _LeaveTypeWidgetState extends State<LeaveTypeWidget> {
  String _selectedType = LeaveType.values.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text("Type of Leaves"),
        const SizedBox(
          height: 8,
        ),
        Container(
          color: const Color(0xffF7F6F6),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              value: _selectedType,
              style: const TextStyle(
                  color: Color(0xff132536), fontWeight: FontWeight.w500, fontSize: 14),
              items: LeaveType.values
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (selectedType) {
                setState(() {
                  _selectedType = selectedType!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
