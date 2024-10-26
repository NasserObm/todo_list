import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/welcome.dart'; // Import de la page Welcome
// ignore: unused_import
import 'package:todo_list/connexion.dart'; // Import de la page Connexion
import 'package:todo_list/todo.dart'; // Import de la page Todo

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogged') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo-list',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Indicateur de chargement
          } else if (snapshot.hasData && snapshot.data == true) {
            return const Todo(); // Redirige vers la page Todo si connecté
          } else {
            return const Welcome(); // Redirige vers la page de bienvenue si déconnecté
          }
        },
      ),
    );
  }
}
