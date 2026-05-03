import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../core/services/firebase/firestore_provider.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
import '../../patient/booking/data/appointment_model.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مواعيد المرضى')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseProvider.getBookedAppointmentsByDoctorId(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/no_scheduled.svg',
                      width: 250,
                    ),
                    Text('لا يوجد حجوزات حالياً', style: TextStyles.body),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                AppointmentModel model = AppointmentModel.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>,
                );
                String documentId = snapshot.data!.docs[index].id;
                return _AppointmentCard(
                  model: model,
                  documentId: documentId,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatefulWidget {
  final AppointmentModel model;
  final String documentId;
  const _AppointmentCard({required this.model, required this.documentId});

  @override
  State<_AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<_AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    final bool isToday = _isToday(widget.model.date);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withValues(alpha: .15),
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColors.accentColor,
        collapsedBackgroundColor: AppColors.accentColor,
        title: Text(widget.model.name, style: TextStyles.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.yMMMMd('ar').format(widget.model.date),
                    style: TextStyles.body,
                  ),
                  const SizedBox(width: 12),
                  if (isToday)
                    Text(
                      'اليوم',
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.jm('ar').format(widget.model.date),
                    style: TextStyles.body,
                  ),
                ],
              ),
              if (widget.model.isComplete) ...[
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'مكتمل',
                    style: TextStyles.small.copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _infoRow(Icons.phone, widget.model.phone),
                const SizedBox(height: 8),
                _infoRow(Icons.location_on_rounded, widget.model.location),
                if (widget.model.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _infoRow(Icons.notes, widget.model.description),
                ],
                if (!widget.model.isComplete) ...[
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteColor,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        FirebaseProvider.markAppointmentComplete(widget.documentId)
                            .then((value) {
                          if (mounted) setState(() {});
                        });
                      },
                      child: const Text('إكمال الحجز'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyles.body)),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }
}
