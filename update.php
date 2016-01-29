<?php
require_once "php/lazy/requestmanager.php";
require_once "php/lazy/joomla.php";
$user = JFactory::getUser();
if($user->guest)
   RequestManager::RequestSessionEnded();

set_time_limit(0);
//Downloads the cbooks zip folder
if($_GET["action"] == "download_zip")
{
    require_once "php/lazy/filemanager.php";
    if(!FileManager::DownloadFileToWebServer("update.zip", "https://github.com/arivera12/cbooks/archive/master.zip"))
    {
        header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
    }
}
//Decompress the cbooks zip folder
else if($_GET["action"] == "uncompress_zip")
{
    require_once "php/lazy/filemanager.php";
    if(FileManager::Unzip("update.zip", $_SERVER['DOCUMENT_ROOT'] . "/"))
    {
        FileManager::CopyFilesAndDirectoriesRecursively($_SERVER['DOCUMENT_ROOT'] . "/cbooks-master", $_SERVER['DOCUMENT_ROOT'] . "/");        
    }
    else 
    {
        header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error', true, 500);
    }    
}
//Executes all the new database scripts
else if($_GET["action"] == "database_scripts")
{
    $scripts = json_decode(@file_get_contents("https://raw.githubusercontent.com/arivera12/cbooks/master/package.json"), true);
    if(is_array($scripts) && is_array($scripts["database_scripts"]))
    {
        require_once "php/lazy/pdodb.php";
        $pdodb = new PDODB();
        $pdodb->Connect();
        foreach ($scripts["database_scripts"] as $script) 
        {
            $pdodb->PrepareStatement($script["script"]);
            $pdodb->Execute(false);
        }
        $pdodb->Disconnect();
    }    
}

//Deletes the installation folder
else if($_GET["action"] == "update_clean_up")
{
    require_once "php/lazy/filemanager.php";
    FileManager::DeleteFile("update.zip");
    FileManager::DeleteDirectoryRecursively("cbooks-master");
}

?>