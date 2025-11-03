import 'package:attendance_app/modules/member_screens/login_screen/login_screen.dart';
import 'package:attendance_app/shared/components.dart';
import 'package:attendance_app/shared/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance_app/modules/admin_screens/users_screen.dart';
import '../admin_cubit/admin_cubit.dart';
import '../announcments_screen.dart';
import '../generate_meeting_screen.dart';
import '../meetings_screen.dart';
import 'admin_layout_cubit/admin_layout_cubit.dart';
import 'admin_layout_cubit/admin_layout_states.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    const MeetingsListScreen(),
    const AnnouncementsScreen(),
    const UsersScreen(),
  ];
  final List<Widget> _titles = [
    const Text('All meetings'),
    const Text('Announcements'),
    const Text('Users'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminLayoutCubit, AdminLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManager.grey100,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const GenerateQrScreen()),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    bool confirmLogout = await AdminLayoutCubit.get(context)
                        .showLogoutConfirmationDialog(
                      context,
                      'logut',
                      'logoutqstn',
                      'logut',
                    );
                    if (confirmLogout) {
                      AdminLayoutCubit.get(context).logOut();
                      if (mounted) {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                      navigateAndFinish(context, loginScreen());
                    }
                  },
                ),
              ],
              title: _titles[_currentIndex],
              backgroundColor: ColorsManager.grey100,
            ),
            body: BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) {
                if (state is AdminInitial || state is AdminLoading) {
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
                  const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.announcement,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.people,
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
