import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_features/group_card_info.dart';
import 'package:vyuh_core/vyuh_core.dart';

part 'group_card_layout.g.dart';

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

    return Card(
      child: ListView(
        shrinkWrap: true,
        children: [
          if (content.title != null)
            Text(
              content.title!,
              style: theme.textTheme.headlineMedium,
            ),
          for (final item in content.items ?? <GroupCardItem>[])
            VyuhBinding.instance.content.buildContent(context, item),
        ],
      ),
    );
  }
}

@JsonSerializable()
final class GroupCardItemLayout extends LayoutConfiguration<GroupCardItem> {
  static const schemaName = '${GroupCardItem.schemaName}.layout.default';

  static final typeDescriptor = TypeDescriptor(
    schemaType: schemaName,
    fromJson: GroupCardItemLayout.fromJson,
    title: 'Group Card Item Layout',
  );

  GroupCardItemLayout() : super(schemaType: schemaName);

  factory GroupCardItemLayout.fromJson(Map<String, dynamic> json) =>
      _$GroupCardItemLayoutFromJson(json);

  @override
  Widget build(BuildContext context, GroupCardItem content) {
    return ListTile(
      title: Text(content.title),
      subtitle: content.subtitle != null ? Text(content.subtitle!) : null,
    );
  }
}
