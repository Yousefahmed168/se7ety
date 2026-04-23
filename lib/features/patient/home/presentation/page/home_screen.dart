import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialists_widget.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/top_rated_widget.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key, required this.onSearch});
  final Function() onSearch;

  @override
  State<PatientHomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeScreen> {
  final TextEditingController _doctorName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              pushReplacement(context, Routes.welcome);
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.notifications_active,
                color: AppColors.darkColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: TextStyles.title.copyWith(color: AppColors.darkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مرحبا، ',
                      style: TextStyles.body.copyWith(fontSize: 18),
                    ),
                    TextSpan(
                      text: currentUser?.displayName,
                      style: TextStyles.title.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: TextStyles.title.copyWith(
                  color: AppColors.darkColor,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),

              _searchBar(context),
              const SizedBox(height: 20),
              const SpecialistsBanner(),
              const SizedBox(height: 10),
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: TextStyles.title.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }

  Container _searchBar(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:.3),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: true,
        onTap: widget.onSearch,
        textInputAction: TextInputAction.search,
        controller: _doctorName,
        cursorColor: AppColors.primaryColor,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintStyle: TextStyles.body,
          filled: true,
          hintText: 'ابحث عن دكتور',
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(17),
            ),
            child: IconButton(
              iconSize: 20,
              splashRadius: 20,
              color: Colors.white,
              icon: const Icon(Icons.search),
              onPressed: widget.onSearch,
            ),
          ),
        ),
        style: TextStyles.body,
        onFieldSubmitted: (String value) {
          if (_doctorName.text.isNotEmpty) {
            // pushTo(
            //   context,
            //   Routes.homeSearch,
            //   extra: _doctorName.text,
            // );
          }
        },
      ),
    );
  }
}
