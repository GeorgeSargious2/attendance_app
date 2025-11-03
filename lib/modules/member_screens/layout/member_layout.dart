import 'package:attendance_app/modules/member_screens/layout/layout_cubit/layout_cubit.dart';
import 'package:attendance_app/modules/member_screens/layout/layout_cubit/layout_states.dart';
import 'package:attendance_app/modules/member_screens/login_screen/login_screen.dart';
import 'package:attendance_app/modules/member_screens/member_cubit/attendance_cubit.dart';
import 'package:attendance_app/modules/member_screens/profile_screen.dart';
import 'package:attendance_app/shared/components.dart';
import 'package:attendance_app/shared/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../attendance_history.dart';
import '../home_screen.dart';

class MemberLayout extends StatefulWidget {
  const MemberLayout({super.key});

  @override
  State<MemberLayout> createState() => _MemberLayoutState();
}

class _MemberLayoutState extends State<MemberLayout> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    const HomeScreen(),
    const AttendanceHistoryScreen(),
    const ProfileScreen(),
  ];
  final List<Widget> _titles = [
    Text('Home'),
    Text('Attendance history'),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<layoutCubit, layoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManager.grey100,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    bool confirmLogout = await layoutCubit
                        .get(context)
                        .showLogoutConfirmationDialog(
                          context,
                          'logut',
                          'logoutqstn',
                          'logut',
                        );
                    if (confirmLogout) {
                      layoutCubit.get(context).logOut();
                      if (mounted) {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                      navigateAndFinish(context, loginScreen());
                    }
                  },
                )
              ],
              title: _titles[_currentIndex],
              backgroundColor: ColorsManager.grey100,
            ),
            body: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceInitial || state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _screens[_currentIndex];
              },
            ),
            bottomNavigationBar: SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child: CurvedNavigationBar(
                key: _bottomNavigationKey,
                index: _currentIndex,
                height: 60,
                color: Colors.blue,
                buttonBackgroundColor: Colors.blue,
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                items: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                letIndexChange: (index) => true,
              ),
            ),
          );
        });
  }
}
