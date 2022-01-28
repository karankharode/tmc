importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

/*Update with yours config*/
const firebaseConfig = {
    apiKey: "AIzaSyD5pvov9erS5PSJrnM1OQq_lnoKi0EUAUQ",
    authDomain: "doodledesk-184de.firebaseapp.com",
    projectId: "doodledesk-184de",
    storageBucket: "doodledesk-184de.appspot.com",
    messagingSenderId: "368195722051",
    appId: "1:368195722051:web:4fd80d1b6d70e8827b2df6",
    measurementId: "G-31ZYFG3CHJ"
}
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});