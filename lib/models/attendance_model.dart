class AttendanceRecord {
  final String meetingId;
  final String meetingName;
  final DateTime scannedAt;
  final int pointsEarned;

  AttendanceRecord({
    required this.meetingId,
    required this.meetingName,
    required this.scannedAt,
    required this.pointsEarned,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      meetingId: map['meetingId'] ?? '',
      meetingName: map['meetingName'] ?? '',
      scannedAt: DateTime.fromMillisecondsSinceEpoch(map['scannedAt']),
      pointsEarned: map['pointsEarned']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meetingId': meetingId,
      'meetingName': meetingName,
      'scannedAt': scannedAt.millisecondsSinceEpoch,
      'pointsEarned': pointsEarned,
    };
  }
}
