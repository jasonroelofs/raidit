<?php
error_reporting(E_ALL);

define("RAIDIT_URL", "http://raidit.heroku.com");
define("RAIDIT_KEY", "[YOUR API KEY HERE]");

// Fetch the user email through whatever user signin system you
// are integrating with raid.it

$email = "";
$createIfMissing = "true"; // Set to false or "" to not create members if they don't exist

$query = "create" . $createIfMissing . "email" . $email . RAIDIT_KEY;

$hash = md5($query);

// Do request to raid.it with hash and data
$curl = curl_init();
$timeout = 30;
$useragent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/3.0.0.1"; 
$url = RAIDIT_URL . "/api/token?email=$email&create=". $createIfMissing . "&signature=$hash";

curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, $timeout);
curl_setopt($curl, CURLOPT_USERAGENT, $useragent);

$json = curl_exec($curl);
curl_close($curl);

$response = json_decode($json);

// Parse out response to get the token
$token = "";

if($response->status == "success") {
  $token = $response->token;
} else {
  $token = $response->reason;
}

header("Location: http://raidit.heroku.com?token=". $token);
?>
?>
