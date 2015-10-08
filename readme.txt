# California Independent Expenditures

## System Overview:
The IE processing requires the CAPS ca_process database to update it's data. This system will use 3 MySQL databases, one being the CAPS ca_process database and the other two called ca_ie_process and ca_ie_search.  The ca_ie_process database is used to store all of the working date files and temporary processing files.  The ca_ie_search database will hold the final tables that the search program require.

### Installation:

#### Step 1:
You will need to create 2 databases on your master SQL server.  Call one ca_process and the other ca_search
DROP DATABASE IF EXISTS ca_ie_process;
CREATE DATABASE ca_process CHARACTER SET latin1 COLLATE latin1_swedish_ci;
DROP DATABASE IF EXISTS ca_ie_search;
CREATE DATABASE ca_search CHARACTER SET latin1 COLLATE latin1_swedish_ci;

#### Step 2: 
Create a MySQL user.
For the users in our demo system - this are strictly for the update script and it's recommened a different, select only user is created for the web search program.
GRANT ALL ON ca_process.* TO 'ca_ie'@'localhost' IDENTIFIED BY 'ca_ie_dev14';
GRANT ALL ON ca_ie_search.* TO 'ca_ie'@'localhost';
GRANT ALL ON ca_ie_process.* TO 'ca_ie'@'localhost';

#### Step 3: 
Once this is done copy all the files into the directory you wish to have them run from.
/ - root folder, holds the files needed for the web database

#### Step 4: 
Update the file /connect.php - You will need to put the login / password for the account you created.

#### Step 5:
Secure the file /connect.php - I suggest you make this file read-only to webserver user only.  Since this file holds password information it's important to secure it.

#### Step 6:
Run the install.php script: php install.php - this script should create all the necessary tables in each of the databases, then it will run the first update. It should take an hour or two to complete.

#### Step 7:
Set the update_data.php to run in a cron job. You should make sure it doesn't run until any CAPS processes have finished so as to use the most recent CAPS data.
