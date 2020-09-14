// Adapt to project
// Your web app's Firebase configuration
var firebaseConfig = {
      apiKey: "AIzaSyAwg1WkyyTjrAuSm6-oTFEi38hygAVt38I",
      authDomain: "flash-chat-ios13-f54d0.firebaseapp.com",
      databaseURL: "https://flash-chat-ios13-f54d0.firebaseio.com",
      projectId: "flash-chat-ios13-f54d0",
      storageBucket: "flash-chat-ios13-f54d0.appspot.com",
      messagingSenderId: "796065256137",
      appId: "1:796065256137:web:2cfd38a02fceaf2a6bb318"
};
    // Initialize Firebase
firebase.initializeApp(firebaseConfig);

var db = firebase.firestore();

function usun(){
  var yesterday = firebase.firestore.Timestamp.now();
  yesterday.seconds = yesterday.seconds - (24 * 60 * 60);
  console.log("Test");
  db.collection("messages").where("date",">",yesterday)
      .get().then(function(querySnapshote) {
        querySnapshote.forEach(function(doc) {
          console.log(doc.id," => ",doc.data());
        });
      })
  .catch(function(error) {
        console.log("Error getting documents: ", error);
  });

  db.collection("messages").where("date","<",yesterday)
    .get().then(function(querySnapshote) {
      querySnapshote.forEach(element => {
        element.ref.delete();
      });
    })
}
