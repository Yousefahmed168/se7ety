import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/presentation/page/doctor_home_screen.dart';

class DoctorMainAppScreen extends StatefulWidget {
  const DoctorMainAppScreen({super.key});

  @override
  State<DoctorMainAppScreen> createState() => _DoctorMainAppScreenState();
}

class _DoctorMainAppScreenState extends State<DoctorMainAppScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DoctorHomeScreen(),
    const Center(child: Text('المواعيد')),
    const Center(child: Text('الحساب')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: .2),
            ),
          ],
        ),
        child: GNav(
          curve: Curves.easeOutExpo,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 5,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primaryColor,
          textStyle: TextStyles.body.copyWith(color: AppColors.whiteColor),
          tabs: const [
            GButton(iconSize: 28, icon: Icons.home, text: 'الرئيسية'),
            GButton(
              iconSize: 28,
              icon: Icons.calendar_month_rounded,
              text: 'المواعيد',
            ),
            GButton(iconSize: 29, icon: Icons.person, text: 'الحساب'),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
