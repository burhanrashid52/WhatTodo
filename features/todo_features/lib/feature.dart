import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vyuh_core/vyuh_core.dart';

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
);
