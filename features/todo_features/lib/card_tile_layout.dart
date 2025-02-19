import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';
import 'package:vyuh_feature_system/vyuh_feature_system.dart';

import 'card_tile.dart';

part 'card_tile_layout.g.dart';

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
    final theme = Theme.of(context);
    return ListTile(
      leading: content.hasIcon
          ? ContentImage(
              height: 24.0,
              width: 24.0,
              url: content.iconUrl?.toString(),
              ref: content.icon,
              fit: BoxFit.cover,
              color: theme.colorScheme.secondary,
            )
          : null,
      onTap: content.hasAction ? () => content.action!.execute(context) : null,
      title: Text(content.title),
      subtitle: content.subtitle != null ? Text(content.subtitle!) : null,
    );
  }
}
