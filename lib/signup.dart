// ignore_for_file: unnecessary_string_escapes

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/connexion.dart';
import 'package:todo_list/todo.dart';

class Enregistrer extends StatefulWidget {
  const Enregistrer({super.key});

  @override
  State<Enregistrer> createState() => EnregistrerState();
}

class EnregistrerState extends State<Enregistrer> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomUtilisateur = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> saveUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('nom', nomUtilisateur.text);
    await preferences.setString('email', email.text);
    await preferences.setString('password', password.text);
    await preferences.setBool('isLogged', true);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Todo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Center(
              child: Text('TodoList',
                  style: GoogleFonts.philosopher(
                      color: const Color(0xff0E4F57),
                      fontSize: 50,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 150),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nomUtilisateur, // Ajout du contrôleur
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Nom d\'utilisateur'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nom d\'utilisateur';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: email, // Ajout du contrôleur
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('Email')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: password, // Ajout du contrôleur
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Mot de passe'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un mot de passe';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Bouton de soumission
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Vérifie si le formulaire est valide
                          if (_formKey.currentState?.validate() ?? false) {
                            saveUserData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: const Color(0xff0E4F57),
                        ),
                        child: const Text(
                          'Enregistrer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Connexion(),
                  ),
                ),
              },
              child: const Center(
                child: Text("Vous avez déjà un compte? Cliquez ici!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
