import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'app_theme.dart';
import 'features/dashboard/screens/dashboard_screen.dart';

void main() {
  runApp(const OrbitTerminalApp());

  // specialized windows setup
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = const Size(800, 600);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "The Orbit Terminal";
    appWindow.show();
  });
}

class OrbitTerminalApp extends StatelessWidget {
  const OrbitTerminalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orbit Terminal',
      theme: AppTheme.darkTheme,
      home: Scaffold( // Added Scaffold for better structure with bitsdojo if needed, or directly WindowBorder
        body: WindowBorder(
          color: const Color(0xFF222222),
          width: 1,
          child: Column(
            children: [
               WindowTitleBarBox(
                 child: Row(
                   children: [Expanded(child: MoveWindow())],
                 ),
               ),
               Expanded(child: DashboardScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
