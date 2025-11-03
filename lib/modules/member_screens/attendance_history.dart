import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'member_cubit/attendance_cubit.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is AttendanceInitial || state is AttendanceLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AttendanceError) {
          return Center(child: Text(state.message));
        }

        final user = (state as AttendanceLoaded).user;
        final records = user?.attendanceRecords ?? [];

        if (records.isEmpty) {
          return const Center(child: Text('No attendance records yet'));
        }

        return RefreshIndicator(
          onRefresh: () => context.read<AttendanceCubit>().refreshData(),
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.qr_code, color: Colors.blue),
                  title: Text(record.meetingName),
                  subtitle: Text(
                    '${record.scannedAt.day}/${record.scannedAt.month}/${record.scannedAt.year} ${record.scannedAt.hour}:${record.scannedAt.minute}',
                  ),
                  trailing: Chip(
                    label: Text('+${record.pointsEarned}'),
                    backgroundColor: Colors.blue.withValues(alpha: 0.2),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
