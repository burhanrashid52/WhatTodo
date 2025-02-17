import 'package:flutter/material.dart' hide Action;
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_extension_content/vyuh_extension_content.dart';

part 'card_tile.g.dart';

@JsonSerializable()
class CardTiles extends ContentItem {
  static const schemaName = 'schema.tile.content';

  final String? title;

  final Action? onTap;

  final List<CardTileItem>? items;

  CardTiles({
    this.title,
    this.items,
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

  final Action? onTap;

  CardTileItem({
    required this.title,
    this.subtitle,
    this.onTap,
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
    //final onTap = content.onTap;
    final theme = Theme.of(context);
    final items = content.items ?? [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (content.title != null)
              Text(
                content.title!,
                style: theme.textTheme.titleMedium,
              ),
            for (final e in items)
              ListTile(
                title: Text(e.title),
                onTap: e.onTap != null ? () => e.onTap!.execute(context) : null,
                subtitle: e.subtitle != null ? Text(e.subtitle!) : null,
              )
          ],
        ),
      ),
    );
  }
}
