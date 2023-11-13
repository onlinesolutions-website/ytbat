// User Registration
document.getElementById('registrationForm').onsubmit = function(event) {
    event.preventDefault();
    // Extract user data from form
    var username = document.getElementById('username').value;
    var email = document.getElementById('email').value;
    // Add more fields as necessary

    // Add user to Firestore with initial token count
    db.collection("users").add({
        username: username,
        email: email,
        tokens: 30, // Initial token count
        tokensSpent: 0, // Initial tokens spent
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
};

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

// Deduct a token when a user votes
function deductToken(userId) {
    db.collection("users").doc(userId).get().then((doc) => {
        if (doc.exists) {
            let userData = doc.data();
            if (userData.tokens > 0) {
                db.collection("users").doc(userId).update({
                    tokens: firebase.firestore.FieldValue.increment(-1),
                    tokensSpent: firebase.firestore.FieldValue.increment(1)
                }).then(() => {
                    alert("Vote cast successfully!");
                    updateProfileUI(userId);
                });
            } else {
                alert("You do not have enough tokens to vote.");
            }
        } else {
            console.error("User not found");
        }
    }).catch((error) => {
        console.error("Error: ", error);
    });
}

// Update the profile UI with token information
function updateProfileUI(userId) {
    db.collection("users").doc(userId).get().then((doc) => {
        if (doc.exists) {
            let userData = doc.data();
            document.getElementById('tokensAvailable').textContent = userData.tokens;
            document.getElementById('tokensSpent').textContent = userData.tokensSpent;
        } else {
            console.error("User not found");
        }
    }).catch((error) => {
        console.error("Error: ", error);
    });
}

// Initialize event listeners for vote buttons
document.addEventListener('DOMContentLoaded', (event) => {
    document.querySelectorAll('.vote-button').forEach(button => {
        button.addEventListener('click', function() {
            let userId = "user_id_here"; // Replace with actual user ID
            deductToken(userId);
        });
    });
});
