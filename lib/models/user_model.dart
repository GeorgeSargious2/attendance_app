import 'attendance_model.dart';

class UserModel {
  final String uId;
  final String name;
  final String email;
  final String address;
  final String profileImage;
  final String token;
  final bool isActive;
  final int totalPoints;
  final String phone;
  final List<AttendanceRecord> attendanceRecords;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.address,
    required this.profileImage,
    required this.token,
    required this.isActive,
    required this.totalPoints,
    required this.phone,
    required this.attendanceRecords,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      profileImage: map['profileImage'] ?? '',
      token: map['token'] ?? '',
      isActive: map['isActive'] ?? true,
      totalPoints: map['totalPoints']?.toInt() ?? 0,
      phone: map['phone']?.toString() ?? '',
      attendanceRecords: (map['attendanceRecords'] as List<dynamic>?)
              ?.map((x) => AttendanceRecord.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'address': address,
      'profileImage': profileImage,
      'token': token,
      'isActive': isActive,
      'totalPoints': totalPoints,
      'phone': phone,
      'attendanceRecords': attendanceRecords.map((x) => x.toMap()).toList(),
    };
  }
}
