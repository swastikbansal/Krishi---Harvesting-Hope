import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppRatingRecord extends FirestoreRecord {
  AppRatingRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  bool hasRating() => _rating != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _rating = castToType<int>(snapshotData['rating']);
    _comment = snapshotData['comment'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('appRating')
          : FirebaseFirestore.instance.collectionGroup('appRating');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('appRating').doc(id);

  static Stream<AppRatingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppRatingRecord.fromSnapshot(s));

  static Future<AppRatingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppRatingRecord.fromSnapshot(s));

  static AppRatingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppRatingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppRatingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppRatingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppRatingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppRatingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppRatingRecordData({
  String? email,
  int? rating,
  String? comment,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'rating': rating,
      'comment': comment,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppRatingRecordDocumentEquality implements Equality<AppRatingRecord> {
  const AppRatingRecordDocumentEquality();

  @override
  bool equals(AppRatingRecord? e1, AppRatingRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.rating == e2?.rating &&
        e1?.comment == e2?.comment;
  }

  @override
  int hash(AppRatingRecord? e) =>
      const ListEquality().hash([e?.email, e?.rating, e?.comment]);

  @override
  bool isValidKey(Object? o) => o is AppRatingRecord;
}
