import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/signup.dart';
import 'package:todo_list/todo.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Fonction pour vérifier les informations de connexion
  Future<void> loginUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedEmail = preferences.getString('email');
    String? storedPassword = preferences.getString('password');

    // Vérifie si l'email et le mot de passe correspondent
    if (emailController.text == storedEmail &&
        passwordController.text == storedPassword) {
      // Connexion réussie
      preferences.setBool('isLogged', true);
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const Todo()));
    } else {
      // Affiche un message d'erreur
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Identifiants invalides. Veuillez essayer à nouveau.'),
        ),
      );
    }
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
                      controller: emailController,
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
                      controller: passwordController,
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
                            loginUser(); // Appelle la fonction de connexion
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: const Color(0xff0E4F57),
                        ),
                        child: const Text(
                          'connexion',
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
                    builder: (context) =>
                        const Enregistrer(), // Page d'inscription
                  ),
                ),
              },
              child: const Center(
                child: Text("Vous n'avez pas encore de compte? Cliquez ici!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
