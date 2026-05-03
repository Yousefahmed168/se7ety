import 'package:flutter/material.dart';
import '../../appointments/appointments_list.dart';

class MyAppointmentsHistory extends StatelessWidget {
  const MyAppointmentsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyAppointmentList(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
