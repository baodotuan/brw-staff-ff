import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'staff_acounts_record.g.dart';

abstract class StaffAcountsRecord
    implements Built<StaffAcountsRecord, StaffAcountsRecordBuilder> {
  static Serializer<StaffAcountsRecord> get serializer =>
      _$staffAcountsRecordSerializer;

  @nullable
  String get username;

  @nullable
  String get password;

  @nullable
  String get role;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StaffAcountsRecordBuilder builder) => builder
    ..username = ''
    ..password = ''
    ..role = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('staffAcounts');

  static Stream<StaffAcountsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StaffAcountsRecord._();
  factory StaffAcountsRecord(
          [void Function(StaffAcountsRecordBuilder) updates]) =
      _$StaffAcountsRecord;

  static StaffAcountsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStaffAcountsRecordData({
  String username,
  String password,
  String role,
}) =>
    serializers.toFirestore(
        StaffAcountsRecord.serializer,
        StaffAcountsRecord((s) => s
          ..username = username
          ..password = password
          ..role = role));
