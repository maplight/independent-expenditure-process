<?php
$hostname = "localhost";
$login = "xxx";
$pwd = "xxx";

$script_db = new PDO("mysql:host={$hostname};dbname=ca_process;charset=latin1", $login, $pwd);
$script_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$script_db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

$ie_db = new PDO("mysql:host={$hostname};dbname=ca_ie_process;charset=latin1", $login, $pwd);
$ie_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$ie_db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);