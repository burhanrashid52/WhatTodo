import 'package:flutter/material.dart';
import 'package:flutter_package/content/card_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:vyuh_core/vyuh_core.dart';
import 'package:vyuh_extension_content/vyuh_extension_content.dart';

final aboutFeature = FeatureDescriptor(
  name: 'about',
  title: 'about',
  description: 'show about me details with social media links',
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
        CardTilesContentBuilder(),
      ],
    )
  ],
);
