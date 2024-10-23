import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boomplay Home'),
        backgroundColor: const Color(0xffff735c),
      ),
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay sombre
          Container(
            color: Colors.black.withOpacity(0.7), // Overlay sombre
          ),
          // Contenu centré
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Texte de bienvenue en deux lignes
                const Text(
                  'Bienvenue sur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Boomplay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Ajouter votre fonctionnalité de lecture de musique ici
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffff735c),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Augmenter le padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:const  Row(
                    mainAxisSize: MainAxisSize.min, // Pour que le bouton s'adapte au contenu
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.play_arrow, color: Colors.white), // Icône de lecture
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text(
                        'Play Music',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Ajouter votre fonctionnalité de lecture de vidéo ici
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Augmenter le padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Pour que le bouton s'adapte au contenu
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white), // Icône de lecture
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text(
                        'Play Video',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
