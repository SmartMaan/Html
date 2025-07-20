// Firebase Configuration Template
// Replace these values with your actual Firebase project configuration

const firebaseConfig = {
    apiKey: "your-api-key-here",
    authDomain: "your-project-id.firebaseapp.com",
    projectId: "your-project-id",
    storageBucket: "your-project-id.appspot.com",
    messagingSenderId: "your-messaging-sender-id",
    appId: "your-app-id"
};

/*
HOW TO SET UP FIREBASE FOR YOUR MINES GAME:

1. Go to Firebase Console: https://console.firebase.google.com/
2. Create a new project or select an existing one
3. Add a web app to your project
4. Copy the configuration object and replace the values above
5. Enable Authentication:
   - Go to Authentication > Sign-in method
   - Enable Email/Password authentication
6. Set up Firestore Database:
   - Go to Firestore Database
   - Create database in test mode (or production mode with proper rules)
   - Set up the following security rules:

FIRESTORE SECURITY RULES:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Users can only read/write their own games
    match /games/{gameId} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

7. Replace the firebaseConfig object in the HTML file with your actual configuration
8. Deploy your HTML file to a web server (you can use Firebase Hosting)

FIREBASE HOSTING (OPTIONAL):
1. Install Firebase CLI: npm install -g firebase-tools
2. Login: firebase login
3. Initialize hosting: firebase init hosting
4. Deploy: firebase deploy

DATABASE STRUCTURE:
The game will create the following collections:

/users/{userId}
- email: string
- balance: number
- createdAt: timestamp

/games/{gameId}
- userId: string
- betAmount: number
- mineCount: number
- minePositions: array
- startTime: timestamp
- endTime: timestamp
- result: string ("win" or "loss")
- winnings: number
- gemsFound: number
- finalMultiplier: number
- status: string ("active" or "completed")
*/