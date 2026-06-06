# 📚 Multiplication App

Une application Flutter permettant aux enfants de réviser et d'apprendre les tables de multiplication de manière ludique.

## ✨ Fonctionnalités

### 📖 Mode Révision

* Consultation des tables de multiplication de 1 à 10.
* Sélection de la table à réviser.
* Affichage clair des résultats.

### 🎯 Mode Quiz

* Sélection d'une ou plusieurs tables.
* Génération aléatoire de questions.
* Sessions de 10 questions.
* Validation des réponses.
* Affichage du score final.
* Liste des erreurs pour cibler les révisions.

### 📱 Compatible Mobile

* Développée avec Flutter.
* Accessible depuis navigateur web.
* Installable sur iPhone et Android via l'ajout à l'écran d'accueil.

---

## 🚀 Démonstration

Application disponible à l'adresse :

https://zeirr.github.io/multiplication_app/

---

## 🛠️ Technologies utilisées

* Flutter
* Dart
* Git
* GitHub
* GitHub Actions
* GitHub Pages

---

## 📂 Structure du projet

```text
lib/
├── main.dart
├── models/
│   ├── multiplication_question.dart
│   └── quiz_answer.dart
├── screens/
│   ├── home_screen.dart
│   ├── revision_screen.dart
│   ├── quiz_setup_screen.dart
│   ├── quiz_screen.dart
│   └── result_screen.dart
├── services/
│   └── quiz_service.dart
└── widgets/
    └── app_menu_button.dart
```

---

## ⚙️ Installation

### Prérequis

* Flutter 3.x
* Git

Vérifier l'installation :

```bash
flutter doctor
```

### Cloner le projet

```bash
git clone https://github.com/Zeirr/multiplication_app.git
cd multiplication_app
```

### Installer les dépendances

```bash
flutter pub get
```

### Lancer l'application

Dans Chrome :

```bash
flutter run -d chrome
```

---

## 🔄 Déploiement

Le déploiement est entièrement automatisé grâce à GitHub Actions.

Chaque push sur la branche `main` déclenche automatiquement :

1. Installation des dépendances.
2. Compilation Flutter Web.
3. Publication sur GitHub Pages.

Déploiement manuel :

```bash
git add .
git commit -m "Description des modifications"
git push
```

---

## 📱 Installation sur iPhone

1. Ouvrir l'application dans Safari.
2. Cliquer sur **Partager**.
3. Sélectionner **Ajouter à l'écran d'accueil**.

L'application pourra ensuite être lancée comme une application native.

---

## 🎯 Roadmap

### Version 2

* Sauvegarde des meilleurs scores.
* Révision ciblée des erreurs.
* Mode chronométré.
* Choix du nombre de questions.

### Version 3

* Profils utilisateurs.
* Statistiques détaillées.
* Récompenses et badges.
* Synthèse vocale des questions.

---

## 👨‍💻 Auteur

Projet réalisé par Antoine Dequatremare dans le cadre d'un apprentissage Flutter et du développement mobile multiplateforme.

---

## 📄 Licence

Projet personnel à but pédagogique.
