import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routes/navigations.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../../core/widgets/main_button.dart';
import '../../data/model/specializations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class UpdateDoctorProfileScreen extends StatefulWidget {
  const UpdateDoctorProfileScreen({super.key});

  @override
  State<UpdateDoctorProfileScreen> createState() =>
      _UpdateDoctorProfileScreenState();
}

class _UpdateDoctorProfileScreenState extends State<UpdateDoctorProfileScreen> {
  String? _imagePath;
  

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        context.read<AuthCubit>().imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          pop(context);
          pushToBase(context, Routes.doctorMainApp);
        } else if (state is AuthErrorState) {
          pop(context);
          showMyDialog(context, state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('إكمال عملية التسجيل')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.whiteColor,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : AssetImage(AppImages.docPlaceholder),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _pickImage();
                            },
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                        child: Row(
                          children: [
                            Text(
                              'التخصص',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // التخصص---------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton<String?>(
                          isExpanded: true,
                          iconEnabledColor: AppColors.primaryColor,
                          hint: Text(
                            'اختر التخصص',
                            style: TextStyles.body.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: cubit.specialization,
                          onChanged: (String? newValue) {
                            setState(() {
                              cubit.specialization = newValue;
                            });
                          },
                          items: [
                            for (var specialization in specializations)
                              DropdownMenuItem(
                                value: specialization,
                                child: Text(specialization),
                              ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'نبذة تعريفية',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: cubit.bioController,
                        maxLines: 4,
                        hintText:
                            'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل النبذة التعريفية';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'عنوان العيادة',
                              style: TextStyles.body.copyWith(
                                color: AppColors.darkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: cubit.addressController,
                        hintText: '5 شارع مصدق - الدقي - الجيزة',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل عنوان العيادة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      _workHours(cubit),
                      _phoneNumbers(cubit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: MainButton(
            onPressed: () async {
              if (cubit.formKey.currentState!.validate()) {
                if (cubit.imageFile != null) {
                  cubit.updateDoctor();
                } else {
                  showMyDialog(
                    context,
                    'من فضلك قم باختيار صورة الصفحة الشخصية',
                  );
                }
              }
            },
            text: "التسجيل",
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthCubit bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'ساعات العمل من',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'الي',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            // ---------- Start Time ----------------
            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: bloc.openHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showStartTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
            const SizedBox(width: 10),

            // ---------- End Time ----------------
            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: bloc.closeHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showEndTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthCubit bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 1',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        CustomTextFormField(
          controller: bloc.phone1Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',
          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        CustomTextFormField(
          controller: bloc.phone2Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthCubit cubit) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      cubit.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthCubit cubit) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
      cubit.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
