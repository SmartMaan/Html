# Firebase User Data Structure - QuickCash Application

## Overview
Your QuickCash application now saves comprehensive user data to Firebase Realtime Database under the structure:
```
loanusers → {userUID} → {all user details}
```

## Complete User Data Structure

### 🔗 Firebase Path: `loanusers/{userUID}/`

```json
{
  "uid": "user_unique_id",
  "name": "John Doe",
  "username": "john_doe_1234",
  "email": "john@example.com",
  "password": "user_password",
  "phone": "9876543210",
  "phoneNumber": "9876543210",
  
  "status": "active",
  "role": "user",
  "isActive": true,
  "isVerified": false,
  "phoneVerified": true,
  "emailVerified": false,
  "online": true,
  
  "verification": {
    "phone": true,
    "email": false,
    "identity": false,
    "income": false,
    "address": false
  },
  
  "kyc": {
    "status": "pending",
    "verified": false,
    "level": 0,
    "submittedAt": null,
    "verifiedAt": null,
    "documents": {
      "pan": null,
      "aadhar": null,
      "income": null
    }
  },
  
  "loans": {
    "numberOfLoans": 0,
    "totalLoans": 0,
    "pendingLoans": 0,
    "ongoingLoans": 0,
    "activeLoans": 0,
    "completedLoans": 0,
    "paidLoans": 0,
    "rejectedLoans": 0,
    "defaultedLoans": 0,
    "totalBorrowed": 0,
    "totalRepaid": 0,
    "outstandingAmount": 0,
    "maxLoanEligible": 50000,
    "currentLoanLimit": 50000,
    "lastLoanDate": null,
    "nextEligibleDate": null
  },
  
  "financial": {
    "creditScore": 750,
    "monthlyIncome": 0,
    "employmentType": null,
    "bankAccount": null,
    "riskProfile": "medium",
    "eligibilityScore": 50,
    "repaymentHistory": "good"
  },
  
  "timestamps": {
    "createdAt": 1642678800000,
    "registeredAt": 1642678800000,
    "lastLogin": 1642678800000,
    "lastActivity": 1642678800000,
    "updatedAt": 1642678800000,
    "lastKycUpdate": null,
    "lastLoanApplication": null,
    "lastPayment": null
  },
  
  "session": {
    "loginCount": 1,
    "totalSessions": 1,
    "lastLoginIP": null,
    "deviceInfo": {
      "userAgent": "browser_details",
      "platform": "platform_info",
      "browser": "browser_name",
      "language": "en-US",
      "timezone": "Asia/Kolkata"
    }
  },
  
  "profile": {
    "completionPercentage": 25,
    "steps": {
      "basicInfo": true,
      "contactInfo": true,
      "kycInfo": false,
      "employmentInfo": false,
      "bankDetails": false
    }
  },
  
  "referral": {
    "code": "QC123456",
    "referredBy": null,
    "referralCount": 0,
    "referralEarnings": 0
  },
  
  "settings": {
    "notifications": {
      "email": true,
      "sms": true,
      "push": true,
      "marketing": false
    },
    "privacy": {
      "profileVisibility": "private",
      "dataSharing": false
    },
    "language": "en",
    "currency": "INR",
    "theme": "light"
  },
  
  "activity": {
    "lastFeatureUsed": "registration",
    "featuresUsed": ["registration"],
    "totalTimeSpent": 0,
    "pageViews": 1,
    "actions": []
  },
  
  "admin": {
    "notes": "",
    "flags": [],
    "riskFlags": [],
    "supportTickets": 0,
    "lastContactDate": null
  },
  
  "demographics": {
    "age": null,
    "gender": null,
    "city": null,
    "state": null,
    "pincode": null,
    "address": null
  }
}
```

## Key Features Implemented

### ✅ **Basic User Information**
- **Username**: Auto-generated from name + phone
- **Email**: User provided or auto-generated
- **Password**: Stored for admin access
- **Phone Number**: Primary identifier
- **User ID (UID)**: Firebase Auth UID

### ✅ **Account Status & Role Management**
- **Status**: active, suspended, banned, pending
- **Role**: user, admin, moderator
- **Online Status**: Real-time tracking
- **Verification Levels**: Multiple verification stages

### ✅ **Complete Loan Tracking**
- **Number of Loans**: Total loan count
- **Pending Loans**: Awaiting approval
- **Ongoing Loans**: Currently active
- **Paid Loans**: Successfully completed
- **Rejected Loans**: Declined applications
- **Defaulted Loans**: Failed payments
- **Financial Amounts**: Borrowed, repaid, outstanding

### ✅ **KYC & Verification**
- **KYC Status**: pending, verified, rejected
- **Document Storage**: PAN, Aadhar, Income proof
- **Verification Levels**: 0=None, 1=Basic, 2=Complete
- **Identity Verification**: Multiple verification types

### ✅ **Financial Profile**
- **Credit Score**: Dynamic scoring system
- **Risk Assessment**: Low, medium, high
- **Income Tracking**: Monthly income updates
- **Loan Eligibility**: Calculated limits

### ✅ **Session & Activity Tracking**
- **Login History**: Count and timestamps
- **Device Information**: Browser, platform details
- **Feature Usage**: Track app feature utilization
- **Online Status**: Real-time presence

### ✅ **Admin Management**
- **Admin Notes**: Internal comments
- **Risk Flags**: Security markers
- **Support Tickets**: Help desk integration
- **User Management**: Status changes

## Database Operations

### 🔄 **User Registration**
```javascript
// Saves complete user profile to: loanusers/{userUID}
await rtdb.ref('loanusers/' + user.uid).set(completeUserData);
```

### 🔄 **User Login**
```javascript
// Updates login info and online status
await rtdb.ref('loanusers/' + user.uid).update({
  'timestamps/lastLogin': firebase.database.ServerValue.TIMESTAMP,
  'session/loginCount': firebase.database.ServerValue.increment(1),
  online: true
});
```

### 🔄 **KYC Verification**
```javascript
// Updates KYC and verification status
await rtdb.ref('loanusers/' + user.uid).update({
  'kyc/status': 'verified',
  'kyc/verified': true,
  'verification/identity': true
});
```

### 🔄 **Loan Application**
```javascript
// Updates loan statistics
await rtdb.ref('loanusers/' + user.uid).update({
  'loans/pendingLoans': firebase.database.ServerValue.increment(1),
  'loans/totalBorrowed': firebase.database.ServerValue.increment(amount)
});
```

## Backward Compatibility

The new structure maintains backward compatibility by keeping both:
- **New Structure**: `kyc/status`, `loans/pendingLoans`, etc.
- **Old Structure**: `kycStatus`, `pendingLoans`, etc.

## Data Access Examples

### 📱 **Admin Panel Access**
```javascript
// Get all users
const usersSnapshot = await rtdb.ref('loanusers').once('value');
const users = usersSnapshot.val();

// Access specific user loan info
const userLoans = users[userId].loans;
console.log('Pending Loans:', userLoans.pendingLoans);
console.log('Paid Loans:', userLoans.paidLoans);
```

### 📊 **User Statistics**
```javascript
// Real-time user stats
const userRef = rtdb.ref('loanusers/' + userId);
userRef.on('value', (snapshot) => {
  const userData = snapshot.val();
  console.log('Online:', userData.online);
  console.log('Credit Score:', userData.financial.creditScore);
  console.log('Total Loans:', userData.loans.totalLoans);
});
```

## Security & Privacy

- **Password Storage**: Consider encryption for production
- **Data Access**: Role-based permissions
- **Privacy Settings**: User-controlled data sharing
- **Admin Access**: Audit trails for data changes

## GitHub Integration

✅ **Code Pushed to GitHub**
- Repository: SmartMaan/Html
- Branch: cursor/save-user-data-to-firebase-and-push-to-github-f8d7
- Commit: Enhanced Firebase user data storage structure

## Next Steps

1. **Test Registration**: Create new users and verify data structure
2. **Admin Panel**: Use admin role to view user data
3. **KYC Process**: Test verification workflow
4. **Loan Applications**: Test loan tracking features
5. **Data Export**: Extract user data for analysis

## Support & Debugging

Use the built-in Firebase utilities:
```javascript
// Check all users
firebaseUtils.getAllUsers();

// Check specific user
firebaseUtils.getUser(userId);

// Test Firebase connection
firebaseUtils.checkConnection();
```

---

**🎯 Your QuickCash application now has a comprehensive user data structure that tracks everything from basic information to complete loan lifecycle management!**