<?php
require("connect.php");

Echo "Install started ...\n";

echo "Creating File Folder... \n";

echo "Installing ie processing tables... \n";
process_sql_file("ie_install_processing_tables.sql");

# Process the first update
system("php update_ca_ie.php");

echo "Install complete.... \n";


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