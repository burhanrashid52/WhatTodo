import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_features/card_tile.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_extension_content/content/content_builder.dart';
import 'package:vyuh_extension_content/content/content_descriptor.dart';
import 'package:vyuh_feature_system/ui/content_image.dart';

part 'group_card.g.dart';

@JsonSerializable()
class GroupCard extends ContentItem {
  static const schemaName = 'todo.group.card';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: GroupCard.fromJson,
    title: 'GroupCard',
  );

  static final contentBuilder = ContentBuilder(
    content: typeDescriptor,
    defaultLayout: GroupCardLayout(),
    defaultLayoutDescriptor: GroupCardLayout.typeDescriptor,
  );

  final String? title;
  final List<CardTile>? items;

  GroupCard({
    this.title,
    this.items,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory GroupCard.fromJson(Map<String, dynamic> json) =>
      _$GroupCardFromJson(json);
}

class GroupCardDescriptor extends ContentDescriptor {
  GroupCardDescriptor({super.layouts})
      : super(schemaType: GroupCard.schemaName, title: 'GroupCard');
}

@JsonSerializable()
final class GroupCardLayout extends LayoutConfiguration<GroupCard> {
  static const schemaName = '${GroupCard.schemaName}.layout.default';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: GroupCardLayout.fromJson,
    title: 'GroupCard Layout',
  );

  GroupCardLayout() : super(schemaType: schemaName);

  factory GroupCardLayout.fromJson(Map<String, dynamic> json) =>
      _$GroupCardLayoutFromJson(json);

  @override
  Widget build(BuildContext context, GroupCard content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (content.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text(
                  content.title!,
                  style: theme.textTheme.labelLarge!.copyWith(
                    fontSize: 16.0,
                  ),
                ),
              ),
            for (final item in content.items ?? <CardTile>[])
              VyuhBinding.instance.content.buildContent(context, item),
          ],
        ),
      ),
    );
  }
}

@JsonSerializable()
final class GroupIconLayout extends LayoutConfiguration<GroupCard> {
  static const schemaName = 'todo.group.icon.horizontal';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: GroupIconLayout.fromJson,
    title: 'GroupIcon Layout',
  );

  GroupIconLayout() : super(schemaType: schemaName);

  factory GroupIconLayout.fromJson(Map<String, dynamic> json) =>
      _$GroupIconLayoutFromJson(json);

  @override
  Widget build(BuildContext context, GroupCard content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (content.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Text(
                  content.title!,
                  style: theme.textTheme.labelLarge!.copyWith(
                    fontSize: 16.0,
                  ),
                ),
              ),
            SizedBox(
              height: 50.0,
              child: Row(
                spacing: 16.0,
                children: [
                  const SizedBox(width: 4.0),
                  for (final item in content.items ?? <CardTile>[])
                    ClipOval(
                      child: ContentImage(
                        height: 24.0,
                        width: 24.0,
                        url: item.iconUrl?.toString(),
                        ref: item.icon,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
