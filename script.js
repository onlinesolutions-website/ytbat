document.getElementById('registrationForm').onsubmit = function() {
    alert('Registration submitted!');
    return true; // This will submit the form
};
document.getElementById('videoSubmissionForm').addEventListener('submit', function(event) {
    event.preventDefault();

    var youtubeLink = document.getElementById('youtubeLink').value;
    var category = document.getElementById('category').value;
    var skillLevel = document.getElementById('skillLevel').value;
    var membershipType = document.querySelector('input[name="membershipType"]:checked').value;

    // Here you would typically send this data to your server
    console.log(youtubeLink, category, skillLevel, membershipType);

    // Add logic to handle the submission, like clearing the form, showing a message, etc.
});
function performSearch() {
    var input = document.getElementById('searchInput').value;
    // Implement search logic here
    // This could involve fetching data from the server based on the input
    console.log("Searching for:", input);
}