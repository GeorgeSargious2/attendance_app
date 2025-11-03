part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<UserModel> users;
  final List<Announcement> announcements;
  final Meeting? currentMeeting;
  final List<Meeting> meetings;

  const AdminLoaded({
    required this.users,
    required this.announcements,
    this.currentMeeting,
    required this.meetings,
  });

  AdminLoaded copyWith({
    List<UserModel>? users,
    List<Announcement>? announcements,
    Meeting? currentMeeting,
    List<Meeting>? meetings,
  }) {
    return AdminLoaded(
      users: users ?? this.users,
      announcements: announcements ?? this.announcements,
      currentMeeting: currentMeeting ?? this.currentMeeting,
      meetings: meetings ?? this.meetings, // Add this
    );
  }

  @override
  List<Object> get props => [users, announcements, currentMeeting ?? ''];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
