import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeatureRequestRecord extends FirestoreRecord {
  FeatureRequestRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "additional_information" field.
  String? _additionalInformation;
  String get additionalInformation => _additionalInformation ?? '';
  bool hasAdditionalInformation() => _additionalInformation != null;

  // "priority_level" field.
  String? _priorityLevel;
  String get priorityLevel => _priorityLevel ?? '';
  bool hasPriorityLevel() => _priorityLevel != null;

  // "beta_tester" field.
  bool? _betaTester;
  bool get betaTester => _betaTester ?? false;
  bool hasBetaTester() => _betaTester != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _title = snapshotData['title'] as String?;
    _category = snapshotData['category'] as String?;
    _additionalInformation = snapshotData['additional_information'] as String?;
    _priorityLevel = snapshotData['priority_level'] as String?;
    _betaTester = snapshotData['beta_tester'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('featureRequest')
          : FirebaseFirestore.instance.collectionGroup('featureRequest');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('featureRequest').doc(id);

  static Stream<FeatureRequestRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FeatureRequestRecord.fromSnapshot(s));

  static Future<FeatureRequestRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FeatureRequestRecord.fromSnapshot(s));

  static FeatureRequestRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FeatureRequestRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FeatureRequestRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FeatureRequestRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FeatureRequestRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FeatureRequestRecord &&
      reference.path.hashCode == other.reference.path.hashCode;

  @override
  Map<String, DebugDataField> toDebugSerializableMap() => {
        'reference': debugSerializeParam(
          reference,
          ParamType.DocumentReference,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: '',
          nullable: false,
        ),
        'description': debugSerializeParam(
          description,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'title': debugSerializeParam(
          title,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'category': debugSerializeParam(
          category,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'additional_information': debugSerializeParam(
          additionalInformation,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'priority_level': debugSerializeParam(
          priorityLevel,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'beta_tester': debugSerializeParam(
          betaTester,
          ParamType.bool,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'bool',
          nullable: false,
        )
      };
}

Map<String, dynamic> createFeatureRequestRecordData({
  String? description,
  String? title,
  String? category,
  String? additionalInformation,
  String? priorityLevel,
  bool? betaTester,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'title': title,
      'category': category,
      'additional_information': additionalInformation,
      'priority_level': priorityLevel,
      'beta_tester': betaTester,
    }.withoutNulls,
  );

  return firestoreData;
}

class FeatureRequestRecordDocumentEquality
    implements Equality<FeatureRequestRecord> {
  const FeatureRequestRecordDocumentEquality();

  @override
  bool equals(FeatureRequestRecord? e1, FeatureRequestRecord? e2) {
    return e1?.description == e2?.description &&
        e1?.title == e2?.title &&
        e1?.category == e2?.category &&
        e1?.additionalInformation == e2?.additionalInformation &&
        e1?.priorityLevel == e2?.priorityLevel &&
        e1?.betaTester == e2?.betaTester;
  }

  @override
  int hash(FeatureRequestRecord? e) => const ListEquality().hash([
        e?.description,
        e?.title,
        e?.category,
        e?.additionalInformation,
        e?.priorityLevel,
        e?.betaTester
      ]);

  @override
  bool isValidKey(Object? o) => o is FeatureRequestRecord;
}
