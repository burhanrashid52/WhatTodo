import 'package:json_annotation/json_annotation.dart';
import 'package:todo_features/group_card_layout.dart';
import 'package:vyuh_core/plugin/content/content_item.dart';
import 'package:vyuh_core/plugin/content/serialization.dart';
import 'package:vyuh_core/plugin/content/type_descriptor.dart';
import 'package:vyuh_extension_content/content/content_builder.dart';
import 'package:vyuh_extension_content/content/content_descriptor.dart';

part 'group_card_info.g.dart';

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

  static final descriptor = ContentDescriptor.createDefault(
    schemaType: schemaName,
    title: 'GroupCard',
  );

  final String? title;
  final List<GroupCardItem>? items;

  GroupCard({
    this.title,
    this.items,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory GroupCard.fromJson(Map<String, dynamic> json) =>
      _$GroupCardFromJson(json);
}

@JsonSerializable()
class GroupCardItem extends ContentItem {
  static const schemaName = 'todo.group.card.item';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: GroupCardItem.fromJson,
    title: 'GroupCardItem',
  );

  static final contentBuilder = ContentBuilder(
    content: typeDescriptor,
    defaultLayout: GroupCardItemLayout(),
    defaultLayoutDescriptor: GroupCardItemLayout.typeDescriptor,
  );

  static final descriptor = ContentDescriptor.createDefault(
    schemaType: schemaName,
    title: 'GroupCardItem',
  );

  final String title;
  final String? subtitle;

  //final ImageReference? icon;

  GroupCardItem({
    required this.title,
    this.subtitle,
    //this.icon,
    super.layout,
    super.modifiers,
  }) : super(schemaType: schemaName);

  factory GroupCardItem.fromJson(Map<String, dynamic> json) =>
      _$GroupCardItemFromJson(json);
}
