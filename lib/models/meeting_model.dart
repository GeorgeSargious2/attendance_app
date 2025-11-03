import 'package:equatable/equatable.dart';

class Meeting extends Equatable {
  final String id;
  final String name;
  final int points;
  final DateTime createdAt;
  final String qrCodeData;

  const Meeting({
    required this.id,
    required this.name,
    required this.points,
    required this.createdAt,
    required this.qrCodeData,
  });

  // Add this copyWith method
  Meeting copyWith({
    String? id,
    String? name,
    int? points,
    DateTime? createdAt,
    String? qrCodeData,
  }) {
    return Meeting(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      createdAt: createdAt ?? this.createdAt,
      qrCodeData: qrCodeData ?? this.qrCodeData,
    );
  }

  @override
  List<Object> get props => [id, name, points, createdAt, qrCodeData];

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      points: map['points']?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      qrCodeData: map['qrCodeData'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'points': points,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'qrCodeData': qrCodeData,
    };
  }
}
