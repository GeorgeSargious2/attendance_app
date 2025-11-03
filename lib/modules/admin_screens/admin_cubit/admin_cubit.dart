import 'dart:typed_data';
import 'package:attendance_app/shared/networks/remote/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/announcement _model.dart';
import '../../../models/meeting_model.dart';
import '../../../models/user_model.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final FirebaseService firebaseService;

  AdminCubit(this.firebaseService) : super(AdminInitial()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    emit(AdminLoading());
    try {
      final users = await firebaseService.getAllUsers();
      final announcements = await firebaseService.getAnnouncements();
      final meetings = await firebaseService.getAllMeetings();
      emit(AdminLoaded(
        users: users,
        announcements: announcements,
        meetings: meetings,
      ));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> createMeeting(String name, int points) async {
    if (state is! AdminLoaded) return;

    emit(AdminLoading());
    try {
      final meeting = Meeting(
        id: '',
        name: name,
        points: points,
        createdAt: DateTime.now(),
        qrCodeData: 'meeting_${DateTime.now().millisecondsSinceEpoch}',
      );

      final meetingId = await firebaseService.createMeeting(meeting);
      emit((state as AdminLoaded).copyWith(
        currentMeeting: meeting.copyWith(id: meetingId),
      ));
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> createAnnouncement(
      String title, String? description, Uint8List? image) async {
    if (state is! AdminLoaded || image == null) return;

    emit(AdminLoading());
    try {
      final imageUrl = await firebaseService.uploadImage(
        'announcements/${DateTime.now().millisecondsSinceEpoch}.jpg',
        image,
      );

      final announcement = Announcement(
        id: '',
        title: title,
        imageUrl: imageUrl,
        description: description,
        createdAt: DateTime.now(),
      );

      await firebaseService.createAnnouncement(announcement);
      await loadInitialData();
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> resetAllPoints() async {
    if (state is! AdminLoaded) return;

    emit(AdminLoading());
    try {
      await firebaseService.resetAllPoints();
      await loadInitialData();
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    if (state is! AdminLoaded) return;

    emit(AdminLoading());
    try {
      await firebaseService.deleteAnnouncement(announcementId);
      await loadInitialData();
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }
}
