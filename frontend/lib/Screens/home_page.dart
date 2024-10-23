import 'package:flutter/material.dart';
import 'package:frontend/Screens/my_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(5),
            ),
          ),
          child: AppBar(
            title: const Center(
              child: Text(
                'BOOM PLAY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            toolbarHeight: 190,
            backgroundColor: Colors.transparent,
            flexibleSpace: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    'Votre plateforme de musique préférée, connectez-vous et amusez-vous!',
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyForm(),
        ],
      ),
    );
  }
}

