var admin = require("firebase-admin");

var serviceAccount = require("../../firebase-key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://visionhplus.firebaseio.com"
});


const database = admin.firestore()
module.exports = {admin,database}