import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/functions/image_uploader.dart';
import '../../../core/routes/navigations.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/firebase/firestore_provider.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
import '../../auth/data/model/doctor_model.dart';
import '../../patient/search/doctor_profile/widgets/item_tile.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  String? _imagePath;
  File? file;
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
      String? profileUrl = await uploadImageToCloudinary(file!);
      FirebaseProvider.updateDoctor(
        DoctorModel(uid: userId, imageUrl: profileUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text('الحساب الشخصي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.whiteColor),
            onPressed: () {
              pushTo(context, Routes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('doctor')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: CircularProgressIndicator());
            }
            DoctorModel model = DoctorModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.whiteColor,
                              child: CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                radius: 60,
                                backgroundImage:
                                    (model.imageUrl?.isNotEmpty == true)
                                    ? NetworkImage(model.imageUrl!)
                                    : (_imagePath != null)
                                    ? FileImage(File(_imagePath!))
                                          as ImageProvider
                                    : const AssetImage(
                                        AppImages.docPlaceholder,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'د. ${model.name ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.title,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                model.specialization ?? '',
                                style: TextStyles.body.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const Gap(15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (model.bio?.isNotEmpty == true) ...[
                      Text(
                        'نبذة تعريفية',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(model.bio ?? '', style: TextStyles.small),
                      const SizedBox(height: 20),
                    ],
                    const Divider(),
                    const SizedBox(height: 15),
                    Text(
                      'معلومات التواصل',
                      style: TextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor,
                      ),
                      child: Column(
                        children: [
                          TileWidget(
                            text: model.email ?? '',
                            icon: Icons.email,
                          ),
                          if (model.phone1?.isNotEmpty == true) ...[
                            const SizedBox(height: 12),
                            TileWidget(
                              text: model.phone1 ?? '',
                              icon: Icons.call,
                            ),
                          ],
                          if (model.phone2?.isNotEmpty == true) ...[
                            const SizedBox(height: 12),
                            TileWidget(
                              text: model.phone2 ?? '',
                              icon: Icons.call_outlined,
                            ),
                          ],
                          if (model.address?.isNotEmpty == true) ...[
                            const SizedBox(height: 12),
                            TileWidget(
                              text: model.address ?? '',
                              icon: Icons.location_on_rounded,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (model.openHour?.isNotEmpty == true &&
                        model.closeHour?.isNotEmpty == true) ...[
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 15),
                      Text(
                        'ساعات العمل',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.accentColor,
                        ),
                        child: TileWidget(
                          text:
                              'من ${model.openHour}:00 إلى ${model.closeHour}:00',
                          icon: Icons.watch_later_outlined,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
