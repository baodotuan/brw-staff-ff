import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  int get point;

  @nullable
  DateTime get birth;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: 'processing_order')
  BuiltList<DocumentReference> get processingOrder;

  @nullable
  @BuiltValueField(wireName: 'in_cart_order')
  DocumentReference get inCartOrder;

  @nullable
  @BuiltValueField(wireName: 'loyalty_card_point')
  int get loyaltyCardPoint;

  @nullable
  @BuiltValueField(wireName: 'total_topup')
  int get totalTopup;

  @nullable
  @BuiltValueField(wireName: 'total_spent')
  int get totalSpent;

  @nullable
  @BuiltValueField(wireName: 'total_app_order')
  int get totalAppOrder;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..phoneNumber = ''
    ..uid = ''
    ..firstName = ''
    ..lastName = ''
    ..point = 0
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..processingOrder = ListBuilder()
    ..loyaltyCardPoint = 0
    ..totalTopup = 0
    ..totalSpent = 0
    ..totalAppOrder = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..phoneNumber = snapshot.data['phone_number']
          ..uid = snapshot.data['uid']
          ..firstName = snapshot.data['first_name']
          ..lastName = snapshot.data['last_name']
          ..point = snapshot.data['point']
          ..birth = safeGet(
              () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['birth']))
          ..email = snapshot.data['email']
          ..displayName = snapshot.data['display_name']
          ..photoUrl = snapshot.data['photo_url']
          ..processingOrder = safeGet(() => ListBuilder(
              snapshot.data['processing_order'].map((s) => toRef(s))))
          ..inCartOrder = safeGet(() => toRef(snapshot.data['in_cart_order']))
          ..loyaltyCardPoint = snapshot.data['loyalty_card_point']
          ..totalTopup = snapshot.data['total_topup']
          ..totalSpent = snapshot.data['total_spent']
          ..totalAppOrder = snapshot.data['total_app_order']
          ..reference = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  DateTime createdTime,
  String phoneNumber,
  String uid,
  String firstName,
  String lastName,
  int point,
  DateTime birth,
  String email,
  String displayName,
  String photoUrl,
  DocumentReference inCartOrder,
  int loyaltyCardPoint,
  int totalTopup,
  int totalSpent,
  int totalAppOrder,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..uid = uid
          ..firstName = firstName
          ..lastName = lastName
          ..point = point
          ..birth = birth
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..processingOrder = null
          ..inCartOrder = inCartOrder
          ..loyaltyCardPoint = loyaltyCardPoint
          ..totalTopup = totalTopup
          ..totalSpent = totalSpent
          ..totalAppOrder = totalAppOrder));
