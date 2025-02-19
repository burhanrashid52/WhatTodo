import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/serialization.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';
import 'package:vyuh_extension_content/content/content_builder.dart';
import 'package:vyuh_extension_content/content/content_descriptor.dart';

part 'card_tile.g.dart';

@JsonSerializable()
class CardTileItem extends ContentItem {
  static const schemaName = 'todo.card.tile.item';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: CardTileItem.fromJson,
    title: 'CardTileItem',
  );

  static final contentBuilder = ContentBuilder(
    content: typeDescriptor,
    defaultLayout: CardITileLayout(),
    defaultLayoutDescriptor: CardITileLayout.typeDescriptor,
  );

  static final descriptor = ContentDescriptor.createDefault(
    schemaType: schemaName,
    title: 'CardTileItem',
  );

  final String title;
  final String? subtitle;

  CardTileItem({
    required this.title,
    this.subtitle,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory CardTileItem.fromJson(Map<String, dynamic> json) =>
      _$CardTileItemFromJson(json);
}

@JsonSerializable()
final class CardITileLayout extends LayoutConfiguration<CardTileItem> {
  static const schemaName = '${CardTileItem.schemaName}.layout.default';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: CardITileLayout.fromJson,
    title: 'Card Tile Item Layout',
  );

  CardITileLayout() : super(schemaType: schemaName);

  factory CardITileLayout.fromJson(Map<String, dynamic> json) =>
      _$CardITileLayoutFromJson(json);

  @override
  Widget build(BuildContext context, CardTileItem content) {
    return ListTile(
      title: Text(content.title),
      subtitle: content.subtitle != null ? Text(content.subtitle!) : null,
    );
  }
}
