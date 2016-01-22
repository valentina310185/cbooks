<?php 
require_once "php/lazy/request.php";
$Request = new Request();
if(isset($Request->Get->file_download_url) && !empty($Request->Get->file_download_url))
{
	require_once "php/lazy/filemanager.php";
	FileManager::DownloadFile($Request->Get->file_download_url);
}
else
{
	require_once "php/lazy/requestmanager.php";
	RequestManager::RequestHandler($Request);
}
?>