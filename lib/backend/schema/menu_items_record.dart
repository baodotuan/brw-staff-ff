import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'menu_items_record.g.dart';

abstract class MenuItemsRecord
    implements Built<MenuItemsRecord, MenuItemsRecordBuilder> {
  static Serializer<MenuItemsRecord> get serializer =>
      _$menuItemsRecordSerializer;

  @nullable
  DocumentReference get category;

  @nullable
  String get name;

  @nullable
  String get description;

  @nullable
  int get price;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MenuItemsRecordBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..price = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('menuItems');

  static Stream<MenuItemsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  MenuItemsRecord._();
  factory MenuItemsRecord([void Function(MenuItemsRecordBuilder) updates]) =
      _$MenuItemsRecord;

  static MenuItemsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createMenuItemsRecordData({
  DocumentReference category,
  String name,
  String description,
  int price,
}) =>
    serializers.toFirestore(
        MenuItemsRecord.serializer,
        MenuItemsRecord((m) => m
          ..category = category
          ..name = name
          ..description = description
          ..price = price));
