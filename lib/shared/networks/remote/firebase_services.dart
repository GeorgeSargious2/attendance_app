import 'dart:typed_data';
import 'package:attendance_app/models/announcement%20_model.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/models/meeting_model.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User related operations
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('Members').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> updateUserPoints(String userId, int points) async {
    await _firestore.collection('users').doc(userId).update({
      'totalPoints': FieldValue.increment(points),
      'attendanceRecords':
          FieldValue.arrayUnion([]), // This ensures the array exists
    });
  }

  Future<void> addAttendanceRecord(
      String userId, AttendanceRecord record) async {
    await _firestore.collection('users').doc(userId).update({
      'attendanceRecords': FieldValue.arrayUnion([record.toMap()]),
    });
  }

  Future<void> resetAllPoints() async {
    final users = await _firestore.collection('users').get();
    final batch = _firestore.batch();

    for (final doc in users.docs) {
      batch.update(doc.reference, {
        'totalPoints': 0,
        'attendanceRecords': FieldValue.delete(),
      });
    }

    await batch.commit();
  }

  // Meeting related operations
  Future<String> createMeeting(Meeting meeting) async {
    final docRef = await _firestore.collection('meetings').add(meeting.toMap());
    return docRef.id;
  }

  Future<Meeting?> getMeeting(String meetingId) async {
    final doc = await _firestore.collection('meetings').doc(meetingId).get();
    if (!doc.exists) return null;
    return Meeting.fromMap(doc.data()!..['id'] = doc.id);
  }

  Future<List<Meeting>> getAllMeetings() async {
    final snapshot = await _firestore.collection('meetings').get();
    return snapshot.docs.map((doc) => Meeting.fromMap(doc.data())).toList();
  }

  // Announcement related operations
  Future<String> createAnnouncement(Announcement announcement) async {
    final docRef =
        await _firestore.collection('announcements').add(announcement.toMap());
    return docRef.id;
  }

  Future<List<Announcement>> getAnnouncements() async {
    final snapshot = await _firestore
        .collection('announcements')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Announcement.fromMap(doc.data()..['id'] = doc.id))
        .toList();
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    await _firestore.collection('announcements').doc(announcementId).delete();
  }

  // Users list
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _firestore.collection('Members').get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  // Upload image to storage
  Future<String> uploadImage(String path, Uint8List file) async {
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putData(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
