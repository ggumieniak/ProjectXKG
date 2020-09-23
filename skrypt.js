  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  var firebaseConfig = {
    apiKey: "AIzaSyDGfFcoKhDAILb8ii9PhrJVbgrrwbD6tes",
    authDomain: "swiftuigumieniak.firebaseapp.com",
    databaseURL: "https://swiftuigumieniak.firebaseio.com",
    projectId: "swiftuigumieniak",
    storageBucket: "swiftuigumieniak.appspot.com",
    messagingSenderId: "507578485948",
    appId: "1:507578485948:web:42a195351da3a2b37654b9",
    measurementId: "G-33RGRJ9VB5"
  };

    // Initialize Firebase
firebase.initializeApp(firebaseConfig);

var db = firebase.firestore();

function usun(category,deleteDate){
    db.collection("Categories").doc(category).collection("Reports")
    .where("Date","<",deleteDate)
      .get().then(function(querySnapshote) {
      querySnapshote.forEach(element => {
        element.ref.delete();
      });
    })
}

function deleteService() {
  var localThreatenDate = firebase.firestore.Timestamp.now();
  localThreatenDate.seconds = localThreatenDate.seconds - (1 * 60 * 60);
  
  var roadAccidentDate = firebase.firestore.Timestamp.now();
  roadAccidentDate.seconds = roadAccidentDate.seconds - (6 * 60 * 60);

  var weatherDate = firebase.firestore.Timestamp.now();
  weatherDate.seconds = weatherDate.seconds - (12 * 60 * 60);

  usun("LocalThreaten",localThreatenDate);
  usun("RoadAccident",roadAccidentDate);
  usun("Weather",weatherDate);
}

function wypisz(category, deleteDate){
  db.collection("Categories").doc(category).collection("Reports")
    .where("Date",">",deleteDate)
      .get().then(function(querySnapshote) {
        querySnapshote.forEach(function(doc) {
          console.log(doc.id," => ",doc.data());
        });
      })
  .catch(function(error) {
        console.log("Error getting documents: ", error);
  });
}
