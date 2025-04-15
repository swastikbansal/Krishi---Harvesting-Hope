import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "edited_time" field.
  DateTime? _editedTime;
  DateTime? get editedTime => _editedTime;
  bool hasEditedTime() => _editedTime != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "user_state" field.
  String? _userState;
  String get userState => _userState ?? '';
  bool hasUserState() => _userState != null;

  // "user_city" field.
  String? _userCity;
  String get userCity => _userCity ?? '';
  bool hasUserCity() => _userCity != null;

  // "loggedin_time" field.
  DateTime? _loggedinTime;
  DateTime? get loggedinTime => _loggedinTime;
  bool hasLoggedinTime() => _loggedinTime != null;

  // "user_location" field.
  String? _userLocation;
  String get userLocation => _userLocation ?? '';
  bool hasUserLocation() => _userLocation != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _editedTime = snapshotData['edited_time'] as DateTime?;
    _bio = snapshotData['bio'] as String?;
    _userName = snapshotData['user_name'] as String?;
    _userState = snapshotData['user_state'] as String?;
    _userCity = snapshotData['user_city'] as String?;
    _loggedinTime = snapshotData['loggedin_time'] as DateTime?;
    _userLocation = snapshotData['user_location'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
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
        'email': debugSerializeParam(
          email,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'display_name': debugSerializeParam(
          displayName,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'photo_url': debugSerializeParam(
          photoUrl,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'uid': debugSerializeParam(
          uid,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'created_time': debugSerializeParam(
          createdTime,
          ParamType.DateTime,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'DateTime',
          nullable: true,
        ),
        'phone_number': debugSerializeParam(
          phoneNumber,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'edited_time': debugSerializeParam(
          editedTime,
          ParamType.DateTime,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'DateTime',
          nullable: true,
        ),
        'bio': debugSerializeParam(
          bio,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'user_name': debugSerializeParam(
          userName,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'user_state': debugSerializeParam(
          userState,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'user_city': debugSerializeParam(
          userCity,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        ),
        'loggedin_time': debugSerializeParam(
          loggedinTime,
          ParamType.DateTime,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'DateTime',
          nullable: true,
        ),
        'user_location': debugSerializeParam(
          userLocation,
          ParamType.String,
          link: 'https://app.flutterflow.io/project/krishi-b5r9t8?tab=database',
          name: 'String',
          nullable: false,
        )
      };
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  DateTime? editedTime,
  String? bio,
  String? userName,
  String? userState,
  String? userCity,
  DateTime? loggedinTime,
  String? userLocation,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'edited_time': editedTime,
      'bio': bio,
      'user_name': userName,
      'user_state': userState,
      'user_city': userCity,
      'loggedin_time': loggedinTime,
      'user_location': userLocation,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.editedTime == e2?.editedTime &&
        e1?.bio == e2?.bio &&
        e1?.userName == e2?.userName &&
        e1?.userState == e2?.userState &&
        e1?.userCity == e2?.userCity &&
        e1?.loggedinTime == e2?.loggedinTime &&
        e1?.userLocation == e2?.userLocation;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.editedTime,
        e?.bio,
        e?.userName,
        e?.userState,
        e?.userCity,
        e?.loggedinTime,
        e?.userLocation
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
