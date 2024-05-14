import 'package:flutter/material.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/uptodo_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injections
  initGetIt();

  runApp(const UptodoApp());
}
