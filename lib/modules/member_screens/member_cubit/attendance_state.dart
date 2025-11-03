part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final UserModel? user;
  final List<Announcement> announcements;
  final bool scanSuccess;
  final AttendanceRecord? lastScan;

  const AttendanceLoaded({
    required this.user,
    required this.announcements,
    this.scanSuccess = false,
    this.lastScan,
  });

  @override
  List<Object> get props =>
      [user ?? '', announcements, scanSuccess, lastScan ?? ''];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object> get props => [message];
}
