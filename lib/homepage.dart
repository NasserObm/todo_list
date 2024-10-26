import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:todo_list/signup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 200,
        ),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Mot de passe'),
                      ),
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
                            // Affiche un message si l'email est valide
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email valide!'),
                              ),
                            );
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
                    builder: (context) => const Enregistrer(),
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
