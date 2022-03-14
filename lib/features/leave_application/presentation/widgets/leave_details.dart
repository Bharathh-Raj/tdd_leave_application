import 'package:flutter/material.dart';
import 'package:leave_application/core/constants/color_constants.dart';
import 'package:leave_application/core/extensions/date_display_extension.dart';
import 'package:leave_application/features/leave_application/domain/leave_application.dart';

class LeaveDetails extends StatelessWidget {
  final LeaveApplication leaveApplication;
  const LeaveDetails({Key? key, required this.leaveApplication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTime.parse(leaveApplication.id).toDisplayDate(),
            style: const TextStyle(
                color: Color(0xff404655), fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Card(
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.5),
            color: Colors.white,
            child: Column(
              children: [
                _DetailCard(
                  title: "Applied Duration",
                  detail: leaveApplication.fromDate.toDisplayDate() +
                      (leaveApplication.toDate?.toDisplayDate() != null
                          ? "  to  " + leaveApplication.toDate!.toDisplayDate()
                          : ""),
                  icon: Icons.calendar_month,
                  iconColor: const Color(0xffB787FC),
                ),
                _DetailCard(
                  title: "Reason",
                  detail: leaveApplication.reason,
                  icon: Icons.help_outline,
                  iconColor: const Color(0xff73DEF3),
                ),
                _DetailCard(
                  title: "Type of Leave",
                  detail: leaveApplication.leaveType,
                  icon: Icons.work,
                  iconColor: const Color(0xffF683C6),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final String detail;
  final IconData icon;
  final Color iconColor;
  const _DetailCard(
      {Key? key,
      required this.title,
      required this.detail,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black.withOpacity(0.64), fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                detail,
                style: const TextStyle(color: Color(0xff4F5357), fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
