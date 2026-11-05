import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/model/add_event_model.dart';
import 'package:evently/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunction {
  static CollectionReference<UserModel> createUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snap, options) {
            return UserModel.fromJson(snap.data()!);
          },
          toFirestore: (model, options) {
            return model.toJson();
          },
        );
  }

  static CollectionReference<AddEventModel> createEventsCollection() {
    return FirebaseFirestore.instance
        .collection("Events")
        .withConverter<AddEventModel>(
          fromFirestore: (snap, options) {
            return AddEventModel.fromJson(snap.data()!);
          },
          toFirestore: (model, options) {
            return model.toJson();
          },
        );
  }

  static Future<void> AddEvent(AddEventModel model) async {
    var collection = createEventsCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    await docRef.set(model);
  }

  static Stream<QuerySnapshot<AddEventModel>> getEvent(String id) {
    var collection = createEventsCollection();
    if (id == "all") {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    }
    return collection
        .where("category", isEqualTo: id)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Stream<DocumentSnapshot<AddEventModel>> getEventById(String eventId) {
    var collection = createEventsCollection();
    return collection.doc(eventId).snapshots();
  }

  static Future<void> updateEventFavorite(AddEventModel model) async {
    await createEventsCollection().doc(model.id).update({
      'isFavorite': model.isFavorite,
    });
  }

  static Future<void> updateEvent(AddEventModel model) async {
    var collection = createEventsCollection();
    await collection.doc(model.id).update(model.toJson());
  }

  static Future<void> deleteEvent(AddEventModel model) async {
    var collection = createEventsCollection();
    await collection.doc(model.id).delete();
  }

  static void addUser(UserModel user) {
    var collection = createUserCollection();
    var docRef = collection.doc(user.id);
    docRef.set(user);
  }

  static Future<UserModel?> readUser(String userId) async {
    var collection = createUserCollection();
    DocumentSnapshot<UserModel> model = await collection.doc(userId).get();
    if (!model.exists || model.data() == null) {
      return null;
    }

    return model.data()!;
  }

  static void registerUser(
    String name,
    String email,
    String password,
    Function onSusses,
    Function onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      credential.user!.sendEmailVerification();
      addUser(
        UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          CreatedAt: DateTime.now().toString(),
        ),
      );
      onSusses();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      onError(e.toString());
      print(e);
    }
  }

  static void logIn(
    String userName,
    String password,
    Function onSusses,
    Function onError,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );
      onSusses();
      if (credential.user!.emailVerified) {
        onSusses();
      } else {
        onError("Please verify your email, check mailBox");
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<UserCredential?> signInWithGoogle(
    Function onSusses,
    Function onError,
  ) async {
    try {
      {
        final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
            .authenticate();
        if (googleUser == null) {
          onError("You cancelled Google Sign In");
          return null;
        }

        final GoogleSignInAuthentication googleAuth =
            googleUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        onSusses();
        return userCredential;
      }
    } on GoogleSignInException catch (e) {
      onError(e.description);
      return null;
    } catch (e) {
      onError(e.toString());
      return null;
    }
  }
}
