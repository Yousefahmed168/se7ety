import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيت الطبيب'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              pushReplacement(context, Routes.welcome);
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'مرحباً بك دكتور!',
          style: TextStyles.title.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
