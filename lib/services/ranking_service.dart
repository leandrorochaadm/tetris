import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';

class RankingEntry {
  final String? id;
  final String playerName;
  final int score;
  final double playTimeSeconds;
  final DateTime createdAt;

  RankingEntry({
    this.id,
    required this.playerName,
    required this.score,
    required this.playTimeSeconds,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'playerName': playerName,
        'score': score,
        'playTimeSeconds': playTimeSeconds,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  factory RankingEntry.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RankingEntry(
      id: doc.id,
      playerName: data['playerName'] ?? 'Unknown',
      score: data['score'] ?? 0,
      playTimeSeconds: (data['playTimeSeconds'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

class RankingService {
  final FirestoreService _firestoreService;
  static const String _collection = 'rankings';

  RankingService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  Future<void> submitScore(RankingEntry entry) async {
    await _firestoreService.addDocument(_collection, entry.toMap());
  }

  Future<List<RankingEntry>> getTopRankings({int limit = 10}) async {
    final snapshot = await _firestoreService.getDocuments(
      _collection,
      orderBy: 'score',
      descending: true,
      limit: limit,
    );

    return snapshot.docs.map((doc) => RankingEntry.fromDocument(doc)).toList();
  }

  Stream<List<RankingEntry>> watchTopRankings({int limit = 10}) {
    return _firestoreService.firestore
        .collection(_collection)
        .orderBy('score', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => RankingEntry.fromDocument(doc)).toList());
  }
}
