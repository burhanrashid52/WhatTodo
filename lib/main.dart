import 'package:flutter/material.dart';
import 'package:flutter_app/db/AppDatabase.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final appDatabaseProvider = Provider<AppDatabase>(
  (_) => AppDatabase.get(),
);

final taskDatabaseProvider = Provider<TaskDatabase>(
  (ref) {
    final appDatabase = ref.watch(appDatabaseProvider);
    return TaskDatabase(appDatabase);
  },
);

final labelDatabaseProvider = Provider<LabelDatabase>(
  (ref) {
    final appDatabase = ref.watch(appDatabaseProvider);
    return LabelDatabase(appDatabase);
  },
);

final projectDatabaseProvider = Provider<ProjectDatabase>(
      (ref) {
    final appDatabase = ref.watch(appDatabaseProvider);
    return ProjectDatabase(appDatabase);
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
      home: const HomeScreen(),
    );
  }
}
