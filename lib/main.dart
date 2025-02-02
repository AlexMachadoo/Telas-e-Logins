import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_login_screen/firebase_options.dart';
import 'package:new_login_screen/views/home_page.dart';
import 'package:new_login_screen/views/login_page.dart';
import 'package:new_login_screen/views/login_register.dart';
import 'package:new_login_screen/views/theme.dart'; // Importando o tema

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme, // Aplicando o tema claro
      darkTheme: CustomTheme.darkTheme, // Aplicando o tema escuro (se necessário)
      themeMode: ThemeMode.light, // Pode alternar para ThemeMode.dark conforme preferir
      home: const MainPage(),
      routes: {"/loginRegister": (context) => LoginRegister()},
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(user: snapshot.data!);
        } else {
          return LoginPage();
        }
      },
    );
  }
}
