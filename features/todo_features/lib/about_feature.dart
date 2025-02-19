import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_features/card_tile.dart';
import 'package:todo_features/group_card.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_extension_content/content_extension_descriptor.dart';

final aboutFeature = FeatureDescriptor(
  name: 'about',
  title: 'About Feature',
  description: 'Show details about the author',
  icon: Icons.info,
  routes: () async {
    return [
      GoRoute(
        path: '/about',
        pageBuilder: defaultRoutePageBuilder,
      ),
    ];
  },
  extensions: [
    ContentExtensionDescriptor(
      contentBuilders: [
        GroupCard.contentBuilder,
        CardTileItem.contentBuilder,
      ],
    )
  ],
);
