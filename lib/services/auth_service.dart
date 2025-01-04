import 'package:chaperone/services/database_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "996712058212-p9347k0u5mipoqc6176uc8k0f21d05eq.apps.googleusercontent.com");

  Future<void> _createUsersStoryDocumentIfNeeded(User? user) async {
    if (user != null) {
      final databaseService = DatabaseService(uid: user.uid);
      final docSnapshot =
          await databaseService.storiesCollection.doc(user.uid).get();

      if (!docSnapshot.exists) {
        await databaseService.createStoryDocument();
        // await databaseService.updateAnyStoriesData(
        //     fieldName: userEmail,
        //     newValue: _firebaseAuth.currentUser?.email ?? '',
        //     docId: "${user.uid}game1");
        // await databaseService.fetchUserCountryAndSaveToFirebase(
        //     docId: "${user.uid}game1");
      }
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    // MyReusableFunctions.showProcessingToast();
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document if it doesn't exist
      await _createUsersStoryDocumentIfNeeded(userCredential.user);

      // Save email to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error: $e", type: ToastificationType.error);
      return null;
    }
  }

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    MyReusableFunctions.showProcessingToast();
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document
      await _createUsersStoryDocumentIfNeeded(userCredential.user);

      // Save email to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);

      MyReusableFunctions.showCustomToast(
        description: "Sign-up successful",
        type: ToastificationType.success,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error: $e", type: ToastificationType.error);
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    MyReusableFunctions.showProcessingToast();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Create user document
      await _createUsersStoryDocumentIfNeeded(userCredential.user);

      // MyReusableFunctions.showCustomToast(
      //   description: "Sign-in successful",
      //   type: ToastificationType.success,
      // );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error: $e", type: ToastificationType.error);
      return null;
    }
  }

  // Sign in anonymously
  Future<UserCredential?> signInAnonymously() async {
    // MyReusableFunctions.showProcessingToast();
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();

      // Create user document
      await _createUsersStoryDocumentIfNeeded(userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
        description: "Error: $e",
        type: ToastificationType.error,
      );
      return null;
    }
  }

  // Method to link anonymous account with email and password
  Future<UserCredential?> linkAnonymousAccountWithEmailAndPassword(
      String email, String password) async {
    MyReusableFunctions.showProcessingToast();
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null && user.isAnonymous) {
        final databaseService = DatabaseService(uid: user.uid);
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        // Link anonymous account with email/password credential
        UserCredential userCredential =
            await user.linkWithCredential(credential);

        // Update Firestore document if necessary (it should already exist)
        await _createUsersStoryDocumentIfNeeded(userCredential.user);

        await databaseService.updateAnyStoriesData(
          fieldName: userEmail,
          newValue: _firebaseAuth.currentUser?.email ?? '',
        );
        await databaseService.fetchUserCountryAndSaveToFirebase();

        // Save email to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);

        MyReusableFunctions.showCustomToast(
          description:
              "Your account was successfully linked with an email and password 🥰",
          type: ToastificationType.success,
        );

        return userCredential;
      } else {
        MyReusableFunctions.showCustomToast(
          description: "User is not anonymous",
          type: ToastificationType.warning,
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error: $e", type: ToastificationType.error);
      return null;
    }
  }

  // Password reset
  Future<void> resetPassword(String email) async {
    MyReusableFunctions.showProcessingToast();
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  // Delete user and their corresponding document
  Future<void> deleteUser() async {
    // MyReusableFunctions.showProcessingToast();
    try {
      // Get the currently signed-in user
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Delete the user's document in Firestore
        final databaseService = DatabaseService(uid: user.uid);
        await databaseService.storiesCollection
            .doc("${user.uid}game1")
            .delete();

        // Delete the user from Firebase Authentication
        await user.delete();

        MyReusableFunctions.showCustomToast(
          description: "Your account and data was deleted successfully",
          type: ToastificationType.success,
        );
      } else {
        MyReusableFunctions.showCustomToast(
          description: "No user is currently signed in",
          type: ToastificationType.warning,
        );
      }
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error deleting user: $e",
          type: ToastificationType.error);
    }
  }

  // Method to check if the user signed in anonymously
  bool isUserAnonymous() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.isAnonymous;
    }
    return false;
  }

  bool isUserLoggedIn() {
    User? user = _firebaseAuth.currentUser;
    return user !=
        null; // Returns true if the user is logged in, false otherwise
  }

// Method to link anonymous account with Google
  Future<UserCredential?> linkAnonymousAccountWithGoogle() async {
    MyReusableFunctions.showProcessingToast();
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null && user.isAnonymous) {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Link anonymous account with Google credential
        UserCredential userCredential =
            await user.linkWithCredential(credential);

        // Update Firestore document
        final databaseService = DatabaseService(uid: user.uid);
        await databaseService.updateAnyStoriesData(
          fieldName: userEmail,
          newValue: userCredential.user?.email ?? '',
        );
        await databaseService.fetchUserCountryAndSaveToFirebase();

        MyReusableFunctions.showCustomToast(
          description:
              "Your account was successfully linked with Google Login 🥰",
          type: ToastificationType.success,
        );

        return userCredential;
      } else {
        MyReusableFunctions.showCustomToast(
          description: "User is not anonymous",
          type: ToastificationType.warning,
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      MyReusableFunctions.showCustomToast(
          description: "Error: $e", type: ToastificationType.error);
      return null;
    }
  }
}
