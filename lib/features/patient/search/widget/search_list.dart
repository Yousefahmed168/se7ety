import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/widgets/cards/doctor_card.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/patient/search/widget/no_doctor_found.dart';

class SearchList extends StatefulWidget {
  final String searchKey;
  const SearchList({super.key, required this.searchKey});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseProvider.searchDoctorsByName(widget.searchKey),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data!.docs.isEmpty
            ? const NoDoctorFound()
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DoctorModel doctor = DoctorModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    if (doctor.specialization == '') {
                      return const SizedBox();
                    }
                    return DoctorCard(doctor: doctor);
                  },
                ),
              );
      },
    );
  }
}
