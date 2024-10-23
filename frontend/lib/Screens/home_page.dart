import 'package:flutter/material.dart';
import 'package:frontend/Screens/delayedAnimation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/casque.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyForm(),
          ],
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void Verif(BuildContext context) {
    final recupEmail = emailController.text;
    final recupPassword = passwordController.text;

    for (var person in people) {
      if (recupEmail == person.email && recupPassword == person.password) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Les informations sont incorrectes.')),
    );
  }

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
                child: SizedBox(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const DelayedAnimation(
                          delay:10000,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
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
                              
                                prefixIcon: const Icon(Icons.mail),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
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
                          delay: 5000,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                             
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                 prefixIcon:Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
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
                        const SizedBox(height: 20),
                        DelayedAnimation(
                          delay: 8000,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(2, 168, 14, 245),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Traitement des données')),
                                );
                                Verif(context);
                              }
                            },
                            child: const Text('Soumettre'),
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
