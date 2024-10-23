import 'package:flutter/material.dart';
import 'package:frontend/Screens/delayedAnimation.dart';



class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const DelayedAnimation(
                        delay: 5000,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DelayedAnimation(
                        delay: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.mail, color: Colors.redAccent),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un texte';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      DelayedAnimation(
                        delay: 3000,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un texte';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      DelayedAnimation(
                        delay: 2000,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            minimumSize: const Size(300, 50),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Traitement des données')),
                              );
                             
                            }
                          },
                          child: const Text(
                            'Soumettre',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Person {
  String email;
  String password;
  Person(this.email, this.password);
}

List<Person> people = [
  Person('baba@gmail.com', "1234"),
  Person('arnaud', 'sonkpian@gmail.com'),
];
