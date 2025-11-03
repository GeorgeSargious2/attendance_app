import 'package:attendance_app/shared/components/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/user_model.dart';
import 'admin_cubit/admin_cubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AdminInitial || state is AdminLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminError) {
          return Center(child: Text(state.message));
        }

        final users = (state as AdminLoaded).users;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Users',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CustomButton(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    label: 'Reset All Points',
                    onPressed: () async {
                      _showResetPointsDialog(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context.read<AdminCubit>().loadInitialData(),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Chip(
                          label: Text(user.totalPoints.toString()),
                          backgroundColor: Colors.blue.withValues(alpha: 0.2),
                        ),
                        onTap: () => _showUserDetails(context, user),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetPointsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Points'),
        content: const Text(
            'Are you sure you want to reset all users points to zero?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminCubit>().resetAllPoints();
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundImage: NetworkImage(user.profileImage),
                ),
              ),
              const SizedBox(height: 16),
              Text('Email: ${user.email}'),
              const SizedBox(height: 8),
              Text('Total Points: ${user.totalPoints}'),
              const SizedBox(height: 16),
              const Text(
                'Attendance Records:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (user.attendanceRecords.isEmpty)
                const Text('No attendance records')
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: user.attendanceRecords.map((record) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '- ${record.meetingName} (${record.scannedAt.day}/${record.scannedAt.month}/${record.scannedAt.year}) +${record.pointsEarned}',
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
