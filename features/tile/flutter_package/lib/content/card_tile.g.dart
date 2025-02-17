// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardTiles _$CardTilesFromJson(Map<String, dynamic> json) => CardTiles(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      onTap: json['onTap'] == null
          ? null
          : Action.fromJson(json['onTap'] as Map<String, dynamic>),
      layout: typeFromFirstOfListJson(json['layout']),
      modifiers: ContentItem.modifierList(json['modifiers']),
    );

CardTileItem _$CardTileItemFromJson(Map<String, dynamic> json) => CardTileItem(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      action: json['action'] == null
          ? null
          : Action.fromJson(json['action'] as Map<String, dynamic>),
    );
