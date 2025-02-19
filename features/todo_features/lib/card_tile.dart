import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/serialization.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';
import 'package:vyuh_extension_content/content/content_builder.dart';
import 'package:vyuh_extension_content/content/content_descriptor.dart';

part 'card_tile.g.dart';

@JsonSerializable()
class CardTile extends ContentItem {
  static const schemaName = 'todo.card.tile';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: CardTile.fromJson,
    title: 'CardTile',
  );

  static final contentBuilder = ContentBuilder(
    content: typeDescriptor,
    defaultLayout: CardTileLayout(),
    defaultLayoutDescriptor: CardTileLayout.typeDescriptor,
  );

  static final descriptor = ContentDescriptor.createDefault(
    schemaType: schemaName,
    title: 'CardTile',
  );

  final String title;
  final String? subtitle;

  CardTile({
    required this.title,
    this.subtitle,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory CardTile.fromJson(Map<String, dynamic> json) =>
      _$CardTileFromJson(json);
}

@JsonSerializable()
final class CardTileLayout extends LayoutConfiguration<CardTile> {
  static const schemaName = '${CardTile.schemaName}.layout.default';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: CardTileLayout.fromJson,
    title: 'Card Tile Item Layout',
  );

  CardTileLayout() : super(schemaType: schemaName);

  factory CardTileLayout.fromJson(Map<String, dynamic> json) =>
      _$CardTileLayoutFromJson(json);

  @override
  Widget build(BuildContext context, CardTile content) {
    return ListTile(
      title: Text(content.title),
      subtitle: content.subtitle != null ? Text(content.subtitle!) : null,
    );
  }
}
