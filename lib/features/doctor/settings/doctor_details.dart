import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/firebase/firestore_provider.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/main_button.dart';

class AccountInfoDoctorScreen extends StatefulWidget {
  const AccountInfoDoctorScreen({super.key});

  @override
  _AccountInfoDoctorScreenState createState() =>
      _AccountInfoDoctorScreenState();
}

class _AccountInfoDoctorScreenState extends State<AccountInfoDoctorScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List labelName = [
    "الاسم",
    "النوع",
    "رقم الهاتف",
    "المدينة",
    "نبذه تعريفية",
    "العمر",
  ];

  List value = ["name", "gender", "phone", "city", "bio", "age"];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.darkColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text('اعدادات الحساب'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: FirebaseProvider.getCurrentPatient(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var userData = snapshot.data?.data() as Map<String, dynamic>?;
            return ListView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                labelName.length,
                (index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        var con = TextEditingController(
                          text:
                              userData?[value[index]] == '' ||
                                  userData?[value[index]] == null
                              ? ''
                              : userData?[value[index]].toString(),
                        );
                        var form = GlobalKey<FormState>();
                        return SimpleDialog(
                          alignment: Alignment.center,
                          contentPadding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          children: [
                            Form(
                              key: form,
                              child: Column(
                                children: [
                                  Text(
                                    'ادخل ${labelName[index]}',
                                    style: TextStyles.body.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: con,
                                    keyboardType: value[index] == 'phone'
                                        ? TextInputType.phone
                                        : TextInputType.text,
                                    inputFormatters: [
                                      if (value[index] == 'phone')
                                        LengthLimitingTextInputFormatter(11),
                                    ],
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.whiteColor,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل ${labelName[index]}.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    text: 'حفظ التعديل',
                                    onPressed: () {
                                      if (form.currentState!.validate()) {
                                        updateData(value[index], con.text);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.accentColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          labelName[index],
                          style: TextStyles.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (userData?[value[index]] == null ||
                                  userData?[value[index]].toString().isEmpty == true)
                              ? 'Not Added'
                              : userData![value[index]].toString(),
                          style: TextStyles.body,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateData(String key, value) async {
    FirebaseFirestore.instance.collection('doctor').doc(user!.uid).update({
      key: value,
    });
    if (key == "name") {
      await user?.updateDisplayName(value);
    }
    Navigator.pop(context);
  }
}
