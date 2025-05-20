const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNewImageNotification = functions.firestore
  .document('images/{docId}')
  .onCreate(async (snap, context) => {
    const imageUrl = snap.data().url;

    const message = {
      topic: 'allUsers',
      data: {
        imageUrl: imageUrl,
      },
      notification: {
        title: 'New Image!',
        body: 'A new image was uploaded!',
      }
    };

    await admin.messaging().send(message);
  });
