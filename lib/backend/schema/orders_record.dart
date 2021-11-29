import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  BuiltList<DocumentReference> get items;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'in_cart')
  bool get inCart;

  @nullable
  int get total;

  @nullable
  bool get transacted;

  @nullable
  @BuiltValueField(wireName: 'total_quantity')
  int get totalQuantity;

  @nullable
  @BuiltValueField(wireName: 'point_payment')
  bool get pointPayment;

  @nullable
  @BuiltValueField(wireName: 'cash_payment')
  bool get cashPayment;

  @nullable
  bool get pickup;

  @nullable
  bool get delivery;

  @nullable
  @BuiltValueField(wireName: 'pickup_address')
  String get pickupAddress;

  @nullable
  @BuiltValueField(wireName: 'delivery_address')
  String get deliveryAddress;

  @nullable
  @BuiltValueField(wireName: 'status_processing')
  bool get statusProcessing;

  @nullable
  @BuiltValueField(wireName: 'status_ready')
  bool get statusReady;

  @nullable
  @BuiltValueField(wireName: 'status_done')
  bool get statusDone;

  @nullable
  @BuiltValueField(wireName: 'transaction_id')
  DocumentReference get transactionId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..items = ListBuilder()
    ..inCart = false
    ..total = 0
    ..transacted = false
    ..totalQuantity = 0
    ..pointPayment = false
    ..cashPayment = false
    ..pickup = false
    ..delivery = false
    ..pickupAddress = ''
    ..deliveryAddress = ''
    ..statusProcessing = false
    ..statusReady = false
    ..statusDone = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;

  static OrdersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference userId,
  DateTime createdTime,
  bool inCart,
  int total,
  bool transacted,
  int totalQuantity,
  bool pointPayment,
  bool cashPayment,
  bool pickup,
  bool delivery,
  String pickupAddress,
  String deliveryAddress,
  bool statusProcessing,
  bool statusReady,
  bool statusDone,
  DocumentReference transactionId,
}) =>
    serializers.toFirestore(
        OrdersRecord.serializer,
        OrdersRecord((o) => o
          ..userId = userId
          ..items = null
          ..createdTime = createdTime
          ..inCart = inCart
          ..total = total
          ..transacted = transacted
          ..totalQuantity = totalQuantity
          ..pointPayment = pointPayment
          ..cashPayment = cashPayment
          ..pickup = pickup
          ..delivery = delivery
          ..pickupAddress = pickupAddress
          ..deliveryAddress = deliveryAddress
          ..statusProcessing = statusProcessing
          ..statusReady = statusReady
          ..statusDone = statusDone
          ..transactionId = transactionId));
