import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user profile
  Future<void> saveUserProfile(
      String userId, Map<String, dynamic> userData) async {
    await _db.collection('users').doc(userId).set(userData);
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
    return doc.data() as Map<String, dynamic>?;
  }

  // Save location
  Future<void> saveLocation(
      String userId, Map<String, dynamic> locationData) async {
    await _db.collection('locations').add({
      'userId': userId,
      ...locationData,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get user's saved locations
  Stream<QuerySnapshot> getUserLocations(String userId) {
    return _db
        .collection('locations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
