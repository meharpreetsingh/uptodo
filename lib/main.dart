import 'package:flutter/material.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/uptodo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injections
  await initGetIt();

  runApp(const UptodoApp());
}
