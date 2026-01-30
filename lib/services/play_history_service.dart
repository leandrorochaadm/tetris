import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';

class PlayHistoryEntry {
  final String? id;
  final DateTime date;
  final int playTimeSeconds;
  final int gamesPlayed;

  PlayHistoryEntry({
    this.id,
    required this.date,
    required this.playTimeSeconds,
    this.gamesPlayed = 1,
  });

  Map<String, dynamic> toMap() => {
        'date': Timestamp.fromDate(date),
        'playTimeSeconds': playTimeSeconds,
        'gamesPlayed': gamesPlayed,
      };

  factory PlayHistoryEntry.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlayHistoryEntry(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      playTimeSeconds: data['playTimeSeconds'] ?? 0,
      gamesPlayed: data['gamesPlayed'] ?? 1,
    );
  }
}

class PlayHistoryService {
  final FirestoreService _firestoreService;
  static const String _collection = 'playHistory';

  PlayHistoryService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  Future<void> recordSession(int playTimeSeconds) async {
    final today = DateTime.now();
    final dateKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final docRef =
        _firestoreService.firestore.collection(_collection).doc(dateKey);

    await _firestoreService.firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (snapshot.exists) {
        final current = PlayHistoryEntry.fromDocument(snapshot);
        transaction.update(docRef, {
          'playTimeSeconds': current.playTimeSeconds + playTimeSeconds,
          'gamesPlayed': current.gamesPlayed + 1,
        });
      } else {
        transaction.set(docRef, {
          'date':
              Timestamp.fromDate(DateTime(today.year, today.month, today.day)),
          'playTimeSeconds': playTimeSeconds,
          'gamesPlayed': 1,
        });
      }
    });
  }

  Future<List<PlayHistoryEntry>> getHistory({
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    Query query = _firestoreService.firestore.collection(_collection);

    if (startDate != null) {
      query = query.where('date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
    }

    if (endDate != null) {
      query =
          query.where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate));
    }

    query = query.orderBy('date', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => PlayHistoryEntry.fromDocument(doc))
        .toList();
  }

  Future<Map<String, dynamic>> getTotalStats() async {
    final history = await getHistory();

    int totalPlayTime = 0;
    int totalGames = 0;

    for (final entry in history) {
      totalPlayTime += entry.playTimeSeconds;
      totalGames += entry.gamesPlayed;
    }

    return {
      'totalPlayTimeSeconds': totalPlayTime,
      'totalGamesPlayed': totalGames,
      'daysPlayed': history.length,
    };
  }
}
