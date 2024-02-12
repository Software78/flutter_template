import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'providers/auth.dart';
import 'package:fluttersanctum/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanctum Authentication',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sanctum Authentication'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = const FlutterSecureStorage();

  void _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');

    if (key != null) {
      if (context.mounted) {
        Provider.of<Auth>(context, listen: false).attempt(key);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const NavDrawer(),
      body: Center(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.isAuthenticated) {
              return const Text('You are logged in');
            } else {
              return const Text('You are not logged in');
            }
          },
        ),
      ),
    );
  }
}
