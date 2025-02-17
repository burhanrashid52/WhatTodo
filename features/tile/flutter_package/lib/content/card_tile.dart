import 'package:flutter/material.dart' hide Action;
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_extension_content/vyuh_extension_content.dart';

part 'card_tile.g.dart';

@JsonSerializable()
class CardTiles extends ContentItem {
  static const schemaName = 'schema.tile.content';

  final String title;

  final Action? onTap;

  final String? subtitle;

  CardTiles({
    required this.title,
    this.subtitle,
    this.onTap,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory CardTiles.fromJson(Map<String, dynamic> json) =>
      _$CardTilesFromJson(json);
}

class CardTilesContentBuilder extends ContentBuilder<CardTiles> {
  CardTilesContentBuilder()
      : super(
          content: TypeDescriptor(
            schemaType: CardTiles.schemaName,
            title: 'CardTiles',
            fromJson: CardTiles.fromJson,
          ),
          defaultLayout: DefaultCardTilesLayout(),
          defaultLayoutDescriptor: DefaultCardTilesLayout.typeDescriptor,
        );
}

class DefaultCardTilesLayout extends LayoutConfiguration<CardTiles> {
  static const schemaName = '${CardTiles.schemaName}.layout.default';
  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    title: 'Default Card Tile Layout',
    fromJson: DefaultCardTilesLayout.fromJson,
  );

  DefaultCardTilesLayout() : super(schemaType: schemaName);

  factory DefaultCardTilesLayout.fromJson(Map<String, dynamic> json) =>
      DefaultCardTilesLayout();

  @override
  Widget build(BuildContext context, CardTiles content) {
    return CardTilesWidget(content: content);
  }
}

@JsonSerializable()
class CardTileItem {
  @JsonKey(defaultValue: '')
  final String title;

  final String? subtitle;

  final Action? action;

  CardTileItem({
    required this.title,
    this.subtitle,
    this.action,
  });

  factory CardTileItem.fromJson(Map<String, dynamic> json) =>
      _$CardTileItemFromJson(json);
}

class CardTilesWidget extends StatelessWidget {
  final CardTiles content;

  const CardTilesWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final onTap = content.onTap;
    final subtitle = content.subtitle;
    return Card(
      child: ListTile(
        title: Text(content.title),
        onTap: onTap != null ? () => onTap.execute(context) : null,
        subtitle: subtitle != null ? Text(subtitle) : null,
      ),
    );
  }
}
