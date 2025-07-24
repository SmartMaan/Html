# 🏔️ TrekWanders Firebase Setup Guide

## Your Firebase Project Configuration

**Project ID:** `aviator-pr01`  
**Project URL:** https://console.firebase.google.com/project/aviator-pr01

---

## 🔧 Required Firebase Services Setup

### 1. Authentication Setup

1. **Go to Firebase Console:** https://console.firebase.google.com/project/aviator-pr01
2. **Navigate to:** Authentication → Sign-in method
3. **Enable Email/Password:**
   - Click on "Email/Password"
   - Toggle "Enable" to ON
   - Click "Save"

### 2. Firestore Database Setup

1. **Navigate to:** Firestore Database
2. **Create Database:**
   - Click "Create database"
   - Choose "Start in test mode" (for development)
   - Select your preferred location
3. **Create Collections:**
   The website will automatically create these collections when used:
   - `users` - User accounts and roles
   - `destinations` - Travel destinations
   - `testimonials` - Customer reviews
   - `settings` - Website statistics and footer info

### 3. Security Rules (Important!)

**For Firestore Database, update your rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      allow read: if request.auth != null && 
                     get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    // Destinations - readable by all, writable by admin only
    match /destinations/{destinationId} {
      allow read: if true;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    // Testimonials - readable by all, writable by admin only
    match /testimonials/{testimonialId} {
      allow read: if true;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    // Settings - readable by all, writable by admin only
    match /settings/{settingId} {
      allow read: if true;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

---

## 👑 Creating Your First Admin User

Since the website automatically assigns "user" role to new registrations, you'll need to manually create the first admin:

### Method 1: Through Firebase Console
1. Register a user normally on your website
2. Go to Firebase Console → Firestore Database
3. Find the `users` collection
4. Locate your user document
5. Edit the document and change `role: "user"` to `role: "admin"`

### Method 2: Direct Database Creation
1. Go to Firestore Database in Firebase Console
2. Create a new document in the `users` collection
3. Set the document ID to your Firebase Auth UID
4. Add these fields:
   ```
   name: "Your Name"
   email: "your@email.com"
   role: "admin"
   createdAt: (current timestamp)
   lastLogin: (current timestamp)
   ```

---

## 🌐 Website Features That Use Firebase

### **Authentication System:**
- User registration with email/password
- User login/logout
- Role-based access (user/admin)
- Profile management

### **Admin Panel Features:**
- **Destinations:** Add/Edit/Delete travel destinations
- **Statistics:** Update website stats (happy users, destinations, trips, satisfaction)
- **Testimonials:** Manage customer reviews
- **Footer Settings:** Update contact information
- **User Management:** Promote users to admin

### **Data Collections:**

#### `users` Collection:
```javascript
{
  name: "John Doe",
  email: "john@example.com",
  role: "user", // or "admin"
  createdAt: timestamp,
  lastLogin: timestamp
}
```

#### `destinations` Collection:
```javascript
{
  name: "Swiss Alps Adventure",
  location: "Switzerland",
  image: "https://...",
  price: "$2,499",
  rating: 4.9,
  description: "Experience the breathtaking...",
  category: "mountain",
  createdAt: timestamp,
  updatedAt: timestamp
}
```

#### `testimonials` Collection:
```javascript
{
  name: "Sarah Johnson",
  image: "https://...",
  rating: 5,
  review: "Amazing experience...",
  location: "Swiss Alps",
  createdAt: timestamp
}
```

#### `settings` Collection:
- Document ID: `stats`
```javascript
{
  happyUsers: 25000,
  totalDestinations: 150,
  totalTrips: 5000,
  customerSatisfaction: 98,
  updatedAt: timestamp
}
```

- Document ID: `footer`
```javascript
{
  description: "Your trusted partner...",
  email: "info@trekwanders.com",
  phone: "+1 (555) 123-4567",
  address: "123 Adventure Street...",
  updatedAt: timestamp
}
```

---

## 🚀 Deployment Steps

1. **Update Firebase Config:** ✅ Already done in `trekwanders.html`
2. **Setup Firebase Services:** Follow steps above
3. **Create Admin User:** Use one of the methods above
4. **Test the Website:** 
   - Register a new user
   - Login with admin account
   - Test admin panel features

---

## 🔍 Testing Your Setup

### Test Authentication:
1. Visit your website: https://smartmaan.github.io/Html/
2. Click "Register" and create a test account
3. Check Firebase Console → Authentication to see the new user
4. Check Firestore → users collection for the user document

### Test Admin Features:
1. Make your account admin (follow steps above)
2. Login to your website
3. You should see the "Admin Dashboard" appear
4. Test adding a destination, testimonial, or updating stats

---

## 🛠️ Troubleshooting

### Common Issues:

**1. "Permission denied" errors:**
- Check your Firestore security rules
- Ensure the user has the correct role
- Verify authentication is working

**2. Admin panel not showing:**
- Check if user role is set to "admin" in Firestore
- Clear browser cache and reload
- Check browser console for errors

**3. Data not saving:**
- Verify Firestore rules allow write access
- Check network connectivity
- Look for JavaScript errors in browser console

---

## 📱 Your Website is Ready!

**Live URL:** https://smartmaan.github.io/Html/

Once you complete the Firebase setup above, your TrekWanders website will be fully functional with:
- ✅ User registration/login
- ✅ Admin panel for content management
- ✅ Real-time data updates
- ✅ Secure role-based access
- ✅ Mobile-responsive design

**Next Steps:**
1. Complete the Firebase setup above
2. Create your first admin user
3. Start adding your travel destinations!

---

## 🆘 Need Help?

If you encounter any issues:
1. Check the browser console for error messages
2. Verify all Firebase services are enabled
3. Double-check the security rules
4. Ensure your Firebase project is active and not suspended

Your Firebase project `aviator-pr01` is now integrated with TrekWanders! 🎉