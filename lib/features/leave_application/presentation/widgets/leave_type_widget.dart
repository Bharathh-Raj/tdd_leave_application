import 'package:flutter/material.dart';

import '../../domain/leave_type.dart';

typedef LeaveTypeUpdateFunction = void Function(String? selectedType);

class LeaveTypeWidget extends StatelessWidget {
  final String selectedType;
  final LeaveTypeUpdateFunction leaveTypeUpdateFunction;

  const LeaveTypeWidget(
      {Key? key, required this.selectedType, required this.leaveTypeUpdateFunction})
      : super(key: key);
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
              value: selectedType,
              style: const TextStyle(
                  color: Color(0xff132536), fontWeight: FontWeight.w500, fontSize: 14),
              items: LeaveType.values
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: leaveTypeUpdateFunction,
            ),
          ),
        ),
      ],
    );
  }
}
