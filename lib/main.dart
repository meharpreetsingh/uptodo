import 'package:flutter/material.dart';
import 'package:uptodo/uptodo_app.dart';
import 'package:uptodo/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injections
  initGetIt();

  runApp(const UptodoApp());
}
