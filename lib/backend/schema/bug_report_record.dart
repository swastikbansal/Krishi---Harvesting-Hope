import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BugReportRecord extends FirestoreRecord {
  BugReportRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "bugtitle" field.
  String? _bugtitle;
  String get bugtitle => _bugtitle ?? '';
  bool hasBugtitle() => _bugtitle != null;

  // "bugdescription" field.
  String? _bugdescription;
  String get bugdescription => _bugdescription ?? '';
  bool hasBugdescription() => _bugdescription != null;

  // "bugtype" field.
  String? _bugtype;
  String get bugtype => _bugtype ?? '';
  bool hasBugtype() => _bugtype != null;

  // "bugimage" field.
  String? _bugimage;
  String get bugimage => _bugimage ?? '';
  bool hasBugimage() => _bugimage != null;

  // "recreationsteps" field.
  String? _recreationsteps;
  String get recreationsteps => _recreationsteps ?? '';
  bool hasRecreationsteps() => _recreationsteps != null;

  // "deviceinfo" field.
  String? _deviceinfo;
  String get deviceinfo => _deviceinfo ?? '';
  bool hasDeviceinfo() => _deviceinfo != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _bugtitle = snapshotData['bugtitle'] as String?;
    _bugdescription = snapshotData['bugdescription'] as String?;
    _bugtype = snapshotData['bugtype'] as String?;
    _bugimage = snapshotData['bugimage'] as String?;
    _recreationsteps = snapshotData['recreationsteps'] as String?;
    _deviceinfo = snapshotData['deviceinfo'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('bugReport')
          : FirebaseFirestore.instance.collectionGroup('bugReport');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('bugReport').doc(id);

  static Stream<BugReportRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BugReportRecord.fromSnapshot(s));

  static Future<BugReportRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BugReportRecord.fromSnapshot(s));

  static BugReportRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BugReportRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BugReportRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BugReportRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BugReportRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BugReportRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBugReportRecordData({
  String? bugtitle,
  String? bugdescription,
  String? bugtype,
  String? bugimage,
  String? recreationsteps,
  String? deviceinfo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bugtitle': bugtitle,
      'bugdescription': bugdescription,
      'bugtype': bugtype,
      'bugimage': bugimage,
      'recreationsteps': recreationsteps,
      'deviceinfo': deviceinfo,
    }.withoutNulls,
  );

  return firestoreData;
}

class BugReportRecordDocumentEquality implements Equality<BugReportRecord> {
  const BugReportRecordDocumentEquality();

  @override
  bool equals(BugReportRecord? e1, BugReportRecord? e2) {
    return e1?.bugtitle == e2?.bugtitle &&
        e1?.bugdescription == e2?.bugdescription &&
        e1?.bugtype == e2?.bugtype &&
        e1?.bugimage == e2?.bugimage &&
        e1?.recreationsteps == e2?.recreationsteps &&
        e1?.deviceinfo == e2?.deviceinfo;
  }

  @override
  int hash(BugReportRecord? e) => const ListEquality().hash([
        e?.bugtitle,
        e?.bugdescription,
        e?.bugtype,
        e?.bugimage,
        e?.recreationsteps,
        e?.deviceinfo
      ]);

  @override
  bool isValidKey(Object? o) => o is BugReportRecord;
}
