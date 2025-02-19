import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';

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
    final action = content.action;
    final hasAction = action != null;
    return ListTile(
      onTap: hasAction ? () => action.execute(context) : null,
      title: Text(content.title),
      subtitle: content.subtitle != null ? Text(content.subtitle!) : null,
    );
  }
}
