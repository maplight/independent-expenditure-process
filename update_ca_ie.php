<?php
# prepare a system lock file to determine if the script is running or not, exit if it is
$lockFile = fopen("update_ca_ie.pid", "c");
$gotLock = flock($lockFile, LOCK_EX | LOCK_NB, $wouldblock);  
if (!$gotLock && $wouldblock) {
  exit("Another instance is already running; terminating.\n");
}

# put the pid id in the file 
ftruncate($lockFile, 0);
fwrite($lockFile, getmypid() . "\n");

# link in the needed libraries for scraping and connecting to the database
require ("connect.php");
require ("parse_name.php");

echo "Starting update... \n";

echo "Process stage 1 \n";
process_sql_file("ie_process_stage_1.sql");

echo "Clean and parse names \n";
parse_ie_names();

echo "Process stage 2 \n";
process_sql_file("ie_process_stage_2.sql");

echo "Update done... \n";

# release the lock file 
ftruncate($lockFile, 0);
flock($lockFile, LOCK_UN);


#===============================================================================================
# load an sql file
function process_sql_file($filename)
{
    global $ie_db;

    $sql_str = "";
    $sql_file = fopen($filename, "r");

    if ($sql_file) {
        while (($line = fgets($sql_file)) !== false) {
            if (trim($line) == "") {
                if (trim($sql_str) != "") {
                    $result = $ie_db->prepare($sql_str);
                    $result->execute();
                    if (!$result) {
                        echo "Error on import of " . $sql_str . "\n";
                    }
                }
                $sql_str = "";
            } else {
                $sql_str .= $line;
            }
        }
    }
    if (trim($sql_str) != "") {
        $result = $ie_db->prepare($sql_str);
        $result->execute();
        if (!$result) {
            echo "Error on import of " . $sql_str . "\n";
        }
    }
}