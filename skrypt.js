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

function toConsole(imie,nazwisko){
  console.log('dziala funkcja toConsole');
  console.log('imie to: ',imie,'\n','nazwisko to: ',nazwisko);
}

function signIn(login,password) {
  firebase.auth().signInWithEmailAndPassword(login,password).catch(function(error) {
  // Handle Errors here.
  var errorCode = error.code;
  var errorMessage = error.message;
  console.log(errorCode,'\n',errorMessage);
  });
firebase.auth().onAuthStateChanged(function(user) {
  if (user) {
    // User is signed in.
    console.log(user);
    deleteData();
  }
});
}

function signOut(){
  firebase.auth().signOut().then(function() {
  console.log('wylogowano pomyslnie');
}).catch(function(error) {
  console.log(error.message);
});
}

function deleteOldReports(category,deleteDate){
    db.collection("Categories").doc(category).collection("Reports")
    .where("Date","<",deleteDate)
      .get().then(function(querySnapshote) {
      querySnapshote.forEach(element => {
        element.ref.delete();
      });
    })
}

function deleteData() {
  console.log("wykonujemy deleteData()");
  var localThreatenDate = firebase.firestore.Timestamp.now();
  localThreatenDate.seconds = localThreatenDate.seconds - (1 * 60 * 60);
  
  var roadAccidentDate = firebase.firestore.Timestamp.now();
  roadAccidentDate.seconds = roadAccidentDate.seconds - (6 * 60 * 60);

  var weatherDate = firebase.firestore.Timestamp.now();
  weatherDate.seconds = weatherDate.seconds - (12 * 60 * 60);

  deleteOldReports("LocalThreaten",localThreatenDate);
  deleteOldReports("RoadAccident",roadAccidentDate);
  deleteOldReports("Weather",weatherDate);
}
