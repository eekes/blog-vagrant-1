<?php
$conn = mysqli_connect("localhost", "myuser", "password", "mydb");

if (!$conn) {
    die("Error: " . mysqli_connect_error());
}

echo "Connected!";