<?php
// Check if the required query parameters are present
if (isset($_GET['_truthcolor']) && isset($_GET['dramafrine'])) {

// Extract the query parameters
$truthcolor = htmlspecialchars($_GET['_truthcolor']);
$dramafrine = htmlspecialchars($_GET['dramafrine']);

// Log the query parameters (optional, for debugging)
error_log("Received _truthcolor: $truthcolor and dramafrine: $dramafrine");

// Respond with a simple message
echo "Parameters received: _truthcolor=$truthcolor, dramafrine=$dramafrine";
} else {
// Respond with an error if parameters are missing
echo "Error: Missing required parameters.";
}
?>
