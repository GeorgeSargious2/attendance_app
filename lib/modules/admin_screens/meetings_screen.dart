import 'package:attendance_app/models/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'admin_cubit/admin_cubit.dart';

class MeetingsListScreen extends StatelessWidget {
  const MeetingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AdminLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminError) {
          return Center(child: Text(state.message));
        }

        if (state is AdminLoaded) {
          final meetings = state.meetings;

          if (meetings.isEmpty) {
            return const Center(child: Text('No meetings yet'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final meeting = meetings[index];
              return MeetingCard(meeting: meeting);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class MeetingCard extends StatelessWidget {
  final Meeting meeting;

  const MeetingCard({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            QrImageView(
              data: meeting.qrCodeData,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              meeting.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Points: ${meeting.points}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Text(
              'Created: ${DateFormat('MMM dd, yyyy - hh:mm a').format(meeting.createdAt)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
