import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/firebase/firestore_provider.dart';
import '../../../../../core/widgets/cards/doctor_card.dart';
import '../../../../auth/data/model/doctor_model.dart';

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirebaseProvider.sortingDoctors(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          log(snapshot.error.toString());
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot
                  .data
                  ?.docs
                  .length, // all doctors in firebase (has full data)
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>,
                );

                return DoctorCard(doctor: doctor);
              },
            );
          }
        },
      ),
    );
  }
}
