import 'package:json_annotation/json_annotation.dart';
import 'package:todo_features/card_tile_layout.dart';
import 'package:vyuh_core/vyuh_core.dart';
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

  final String? title;
  final String? subtitle;
  final Action? action;
  final ImageReference? icon;
  final Uri? iconUrl;

  CardTile({
    this.title,
    this.subtitle,
    this.action,
    this.icon,
    this.iconUrl,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  bool get hasIcon => icon != null || iconUrl != null;

  bool get hasTitle => title != null;

  bool get hasSubtitle => subtitle != null;

  bool get hasAction => action != null;

  factory CardTile.fromJson(Map<String, dynamic> json) =>
      _$CardTileFromJson(json);
}
