import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'order_items_record.g.dart';

abstract class OrderItemsRecord
    implements Built<OrderItemsRecord, OrderItemsRecordBuilder> {
  static Serializer<OrderItemsRecord> get serializer =>
      _$orderItemsRecordSerializer;

  @nullable
  DocumentReference get item;

  @nullable
  int get quantity;

  @nullable
  String get note;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrderItemsRecordBuilder builder) => builder
    ..quantity = 0
    ..note = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orderItems');

  static Stream<OrderItemsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  OrderItemsRecord._();
  factory OrderItemsRecord([void Function(OrderItemsRecordBuilder) updates]) =
      _$OrderItemsRecord;

  static OrderItemsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createOrderItemsRecordData({
  DocumentReference item,
  int quantity,
  String note,
}) =>
    serializers.toFirestore(
        OrderItemsRecord.serializer,
        OrderItemsRecord((o) => o
          ..item = item
          ..quantity = quantity
          ..note = note));
