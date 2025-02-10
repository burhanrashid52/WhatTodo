import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/about/about_us.dart' as about;
import 'package:flutter_app/pages/home/adpative_home.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:go_router/go_router.dart';
import 'package:sanity_client/sanity_client.dart';
import 'package:vyuh_core/vyuh_core.dart' as vc;
import 'package:vyuh_extension_content/vyuh_extension_content.dart';
import 'package:vyuh_feature_developer/vyuh_feature_developer.dart'
    as developer;
import 'package:vyuh_feature_system/vyuh_feature_system.dart' as system;
import 'package:vyuh_plugin_content_provider_sanity/vyuh_plugin_content_provider_sanity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  vc.runApp(
    initialLocation: '/home',
    features: () => [
      mainFeature,
      about.feature,
      developer.feature,
      system.feature,
    ],
    plugins: vc.PluginDescriptor(
      content: DefaultContentPlugin(
        provider: SanityContentProvider(
          SanityClient(
            SanityConfig(
              projectId: '1bnautyt',
              dataset: 'production',
              token: 'skDFNiIjQtd9XVdmEwEa9nyGcEJbA29Uq9ur1UHfJDTI4u0M2HrsgHTii5anp3burFY7m6wDhrENx18jwpDPZfmej6p78SUxCC7LhbNqY8OpUaA5uN6yzWvtk8aYHLl2Ljg5Ncnwqabnc4inJhEckWBOcemTltkmwBTsaKdblFeFKnYnBIBK',
            ),
          ),
        ),
      ),
    ),
  );
}

final mainFeature = vc.FeatureDescriptor(
  name: 'home',
  title: 'Today Task List',
  description: 'A Task list to be shown due today',
  icon: Icons.task,
  init: () async {
    final db = await AppDatabase.init();
    vc.vyuh.di.register(TaskDB(db));
    vc.vyuh.di.register(LabelDB(db));
    vc.vyuh.di.register(ProjectDB(db));
  },
  routes: () async {
    return [
      GoRoute(
        path: '/home',
        builder: (context, state) => BlocProvider(
          bloc: HomeBloc(),
          child: AdaptiveHome(),
        ),
      ),
    ];
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFDE4435);
    final theme = ThemeData(
      primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.orange,
          primary: primaryColor,
        ),
      ),
      home: BlocProvider(
        bloc: HomeBloc(),
        child: AdaptiveHome(),
      ),
    );
  }
}
