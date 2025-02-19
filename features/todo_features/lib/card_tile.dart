import 'package:json_annotation/json_annotation.dart';
import 'package:todo_features/card_tile_layout.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/serialization.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';
import 'package:vyuh_extension_content/vyuh_extension_content.dart';

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
  final Action? action;

  CardTile({
    required this.title,
    this.subtitle,
    this.action,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory CardTile.fromJson(Map<String, dynamic> json) =>
      _$CardTileFromJson(json);
}
