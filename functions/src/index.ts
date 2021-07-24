import functions = require("firebase-functions");
import admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();

exports.onUserStatusChange = functions.database
  .ref("/{uid}/presence")
  .onUpdate(async (change: any, context: any) => {
    // Realtime Databaseに書き込まれたデータを取得
    const isOnline = change.after.val();

    // DocumentReference
    const ref = firestore.doc(`users/${context.params.uid}`);
    console.log(`status: ${isOnline}`);

    // Firestoreの値を更新
    return ref.update({
      isOnline: isOnline,
      lastSeen: Date.now(),
    });
  });
