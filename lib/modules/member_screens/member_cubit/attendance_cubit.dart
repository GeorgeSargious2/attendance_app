import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/announcement _model.dart';
import '../../../../models/attendance_model.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/networks/remote/firebase_services.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final FirebaseService firebaseService;

  AttendanceCubit(this.firebaseService) : super(AttendanceInitial()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    emit(AttendanceLoading());
    try {
      final user = await firebaseService.getCurrentUser();
      final announcements = await firebaseService.getAnnouncements();
      emit(AttendanceLoaded(user: user, announcements: announcements));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> scanQrCode(String qrData) async {
    if (state is! AttendanceLoaded) return;

    final currentState = state as AttendanceLoaded;
    emit(AttendanceLoading());

    try {
      final meeting = await firebaseService.getMeeting(qrData);
      if (meeting == null) {
        emit(AttendanceError('Invalid QR Code'));
        return;
      }

      final record = AttendanceRecord(
        meetingId: meeting.id,
        meetingName: meeting.name,
        scannedAt: DateTime.now(),
        pointsEarned: meeting.points,
      );

      await firebaseService.addAttendanceRecord(currentState.user!.uId, record);
      await firebaseService.updateUserPoints(
          currentState.user!.uId, meeting.points);

      final updatedUser = await firebaseService.getCurrentUser();
      emit(AttendanceLoaded(
        user: updatedUser,
        announcements: currentState.announcements,
        scanSuccess: true,
        lastScan: record,
      ));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> refreshData() async {
    await loadInitialData();
  }
}
