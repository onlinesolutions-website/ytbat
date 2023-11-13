// Firebase configuration
const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID",
    measurementId: "YOUR_MEASUREMENT_ID"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

// User Registration
document.getElementById('registrationForm').onsubmit = function(event) {
    event.preventDefault();
    // Extract user data from form
    var username = document.getElementById('username').value;
    var email = document.getElementById('email').value;
    // Add more fields as necessary

    // Add user to Firestore
    db.collection("users").add({
        username: username,
        email: email,
        tokens: 60, // Initial token count
        createdAt: firebase.firestore.FieldValue.serverTimestamp()
    }).then(() => {
        alert("User registered successfully!");
        // Redirect or update UI as needed
    }).catch((error) => {
        console.error("Error adding user: ", error);
        alert("Registration failed. Please try again.");
    });
};

// Video Submission
document.getElementById('videoSubmissionForm').addEventListener('submit', function(event) {
    event.preventDefault();

    var youtubeLink = document.getElementById('youtubeLink').value;
    var category = document.getElementById('category').value;
    var skillLevel = document.getElementById('skillLevel').value;
    var membershipType = document.querySelector('input[name="membershipType"]:checked').value;

    // Add video to Firestore
    db.collection("videos").add({
        youtubeLink: youtubeLink,
        category: category,
        skillLevel: skillLevel,
        membershipType: membershipType,
        createdAt: firebase.firestore.FieldValue.serverTimestamp()
    }).then(() => {
        alert("Video submitted successfully!");
        // Clear form or update UI as needed
    }).catch((error) => {
        console.error("Error submitting video: ", error);
        alert("Video submission failed. Please try again.");
    });
});

// Search Function (Placeholder - Implement as needed)
function performSearch() {
    var input = document.getElementById('searchInput').value;
    console.log("Searching for:", input);
    // Implement search logic here
}

// Admin Dashboard Update (Example - Modify as needed)
function updateAdminDashboard() {
    const dailyReport = {
        date: new Date().toISOString().split('T')[0], // Current date
        dailyUserSignUps: 10, // Example value
        totalVotes: 150, // Example value
        mostActiveUser: "user123", // Example value
        highestVotedVideo: "video456" // Example value
    };

    db.collection("adminDashboard").doc(dailyReport.date).set(dailyReport)
        .then(() => {
            console.log("Admin dashboard updated successfully!");
        })
        .catch((error) => {
            console.error("Error updating admin dashboard: ", error);
        });
}

// Call updateAdminDashboard as needed, e.g., at the end of the day or after an event
