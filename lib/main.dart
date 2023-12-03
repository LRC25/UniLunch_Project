import 'package:flutter/material.dart';
import 'package:unilunch/persistence/SupabaseConnection.dart';
import 'package:unilunch/presentation/common/widgets/login_page_widget.dart';

void main() async {
  await SupabaseService().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPageWidget(),

    );
  }

}
