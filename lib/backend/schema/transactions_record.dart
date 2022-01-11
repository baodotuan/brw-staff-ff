import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'transactions_record.g.dart';

abstract class TransactionsRecord
    implements Built<TransactionsRecord, TransactionsRecordBuilder> {
  static Serializer<TransactionsRecord> get serializer =>
      _$transactionsRecordSerializer;

  @nullable
  int get amount;

  @nullable
  @BuiltValueField(wireName: 'customer_id')
  DocumentReference get customerId;

  @nullable
  bool get credit;

  @nullable
  DateTime get time;

  @nullable
  @BuiltValueField(wireName: 'receipt_url')
  String get receiptUrl;

  @nullable
  int get quantity;

  @nullable
  @BuiltValueField(wireName: 'initial_point')
  int get initialPoint;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TransactionsRecordBuilder builder) => builder
    ..amount = 0
    ..credit = false
    ..receiptUrl = ''
    ..quantity = 0
    ..initialPoint = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  static TransactionsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      TransactionsRecord(
        (c) => c
          ..amount = snapshot.data['amount']
          ..customerId = safeGet(() => toRef(snapshot.data['customer_id']))
          ..credit = snapshot.data['credit']
          ..time = safeGet(
              () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['time']))
          ..receiptUrl = snapshot.data['receipt_url']
          ..quantity = snapshot.data['quantity']
          ..initialPoint = snapshot.data['initial_point']
          ..reference = TransactionsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<TransactionsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'transactions',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  TransactionsRecord._();
  factory TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =
      _$TransactionsRecord;

  static TransactionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTransactionsRecordData({
  int amount,
  DocumentReference customerId,
  bool credit,
  DateTime time,
  String receiptUrl,
  int quantity,
  int initialPoint,
}) =>
    serializers.toFirestore(
        TransactionsRecord.serializer,
        TransactionsRecord((t) => t
          ..amount = amount
          ..customerId = customerId
          ..credit = credit
          ..time = time
          ..receiptUrl = receiptUrl
          ..quantity = quantity
          ..initialPoint = initialPoint));
