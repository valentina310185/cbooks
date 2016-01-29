<?php
require_once "requestmanager.php";
require_once "systemqueries.php";
require_once "logger.php";

/**
 * This class is used for file management. Uploads and Downloads.
 */
class FileManager
{
	public static function UploadFormFiles($form_name_id, $input_name)
	{
		//Get the inputs of type=file
		$inputs = SystemQueries::GetFormInputsFileType($form_name_id, $input_name);
		//Set file info for return
		$files;// = array();
		//Loop through input type=file
		foreach($inputs as $input)
		{
			// No file has been selected for upload
			if ($_FILES[$input["input_name"]]['error'] == UPLOAD_ERR_NO_FILE || 
			$_FILES[$input["input_name"]]['size'] == 0)
			{
				$files = array(
				"original_filename" => null,
				"extension" => null,
				"fullpath" => null
				); //No file selected
				//Set the file link to the post object
				$_POST[$input["input_name"]] = null;
			}
			// Checks for file error on upload
			else if ($_FILES[$input["input_name"]]['error'] != UPLOAD_ERR_OK || 
			$_FILES[$input["input_name"]]["error"] > 0 || 
			empty($_FILES[$input["input_name"]]["name"]) || 
			empty($_FILES[$input["input_name"]]["tmp_name"]))
			{
				Logger::File();
				RequestManager::RequestError(); //Error on upload
			}
			// Check if the file is uploaded succesfully
			else if (is_uploaded_file($_FILES[$input["input_name"]]["tmp_name"]) && 
					$_FILES[$input["input_name"]]['error'] == UPLOAD_ERR_OK)
			{
				if(trim($input["input_attributes"]) != "" || self::IsFileWithExpectedExtension($input) || self::IsFileWithExpectedMimeType($input))
				{			
					// Default web root directory definition with the new folder defined in the argument
					$web_server_directory = $_SERVER['DOCUMENT_ROOT'] . "/uploads";
					if (!self::CreatePath($web_server_directory)) 
					{
						Logger::File();
						RequestManager::RequestError(); //Error creating the file directory;
					}
					$full_path = self::file_directory($web_server_directory, $input["input_name"]);
					// Saves the uploaded file
					if (move_uploaded_file($_FILES[$input["input_name"]]["tmp_name"], $full_path))
					{
						//Renames the current uploaded file for uniqueness
						$fullpath = self::file_name_generator($web_server_directory, $input);
						if (rename($full_path, $fullpath)) 
						{	
							$files = array(
							"original_filename" => $_FILES[$input["input_name"]]["name"],
							"extension" => self::GetUploadedFileExtension($input),
							"fullpath" => $fullpath
							);	
							//Set the file link to the post object
							$_POST[$input["input_name"]] = $fullpath;							
						}
						else 
						{
							Logger::File();
							RequestManager::RequestError(); //Error on file directory or directory doesn't exist, upload failed
						}
					}
					else 
					{
						Logger::File();
						RequestManager::RequestError(); //Error moving file to the specified directory or directory doesn't exist
					}
				}
				else 
				{
					Logger::File();
					RequestManager::RequestError(); //File type not allowed upload failed
				}
			}
		}
		return $files;
	}
	
    /**
     * Checks if the file have the expected extension
     * @return boolean
     */
    public static function IsFileWithExpectedExtension($input)
    {
        return strpos(strtolower(self::GetUploadedFileExtension($input)), $input["input_files_extensions"]) !== false;
    }
    
    /**
     * Gets the uploaded file extension
     * @return file_extension
     */
    public static function GetUploadedFileExtension($input)
    {
        return self::GetUploadedFilePathInfo($input)["extension"];
    }
    
    /**
     * Gets the uploaded file path info
     * @return file_path_info
     */
    public static function GetUploadedFilePathInfo($input)
    {
        return pathinfo($_FILES[$input["input_name"]]["name"]);
    }
    
    /**
     * Checks if the file have the expected mime type
     * @return boolean
     */
    public static function IsFileWithExpectedMimeType($input)
    {
        return strpos(strtolower(self::GetUploadedFileMimeType($input)), $input["input_files_mime_types"]) !== false;
    }
    
    /**
     * Gets the uploaded file mime type
     * @param input the file input
     * @return $mime_type
     */
    public static function GetUploadedFileMimeType($input)
    {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime_type = finfo_file($finfo, $_FILES[$input["input_name"]]['tmp_name']);
        finfo_close($finfo);
        return $mime_type;
    }	
    
	/**
     * Generates and returns unique file name
     * @return fullpath
     */
	public static function file_name_generator($directory, $input) 
	{
		$file_name = round(microtime(true) * 1000) . date("_u_H_i_s__Y_m_d_") . "." . self::GetUploadedFileExtension($input);
		return $directory . "/" . $file_name;
	}
	
	/**
     * Gets the file directory
     * @return file_directory
     */
	public static function file_directory($directory, $file_name) 
	{
		return $directory . "/" . basename($_FILES[$file_name]["name"]);
	}
	
	/**
     * Check is directory exist and is writable if not it check if parent folder exist and the creates the directory
     */
	public static function CreatePath($path) 
	{
		if (is_dir($path)) return true;
		$prev_path = substr($path, 0, strrpos($path, '/', -2) + 1 );
		$return = self::CreatePath($prev_path);
		return ($return && is_writable($prev_path)) ? mkdir($path, 0755, true) : false;
	}
	
    /**
     * Checks if a file exist and its type is a file and deletes it from web server directory
     */
	public static function DeleteFile($file)
	{
		if(file_exists($file) && is_file($file))
		{
			unlink($file);
		}
	}
	
	/*
     * Removes a Directory
     */
	public static function DeleteDirectory($dir) 
	{
		if (is_dir($dir)) 
		{
			$objects = scandir($dir);
			foreach ($objects as $object) 
			{
				if ($object != "." && $object != "..") 
				{
					if (is_dir($dir."/".$object))
					{
						rmdir($dir."/".$object);
					}						 
					else
					{
						unlink($dir."/".$object);
					}						
				}
			}
			rmdir($dir);
		}
	 }
    
    public static function CopyFilesAndDirectoriesRecursively($src, $dst) 
    {
        $dir = opendir($src);
        @mkdir($dst);
        while(false !== ($file = readdir($dir))) 
        {
            if (( $file != '.' ) && ( $file != '..' )) 
            {
                if ( is_dir($src . '/' . $file) ) 
                {
                    self::CopyFilesAndDirectoriesRecursively($src . '/' . $file,$dst . '/' . $file);
                }
                else 
                {
                    @copy($src . '/' . $file,$dst . '/' . $file);
                }
            }
        }
        closedir($dir);
    }
    
    public static function Unzip($src, $dst)
    {
        $zip = new ZipArchive;
        $resource = $zip->open($src);
        if ($resource === true) 
        {           
          if($zip->extractTo($dst))
          {
              $zip->close();
              return true;
              
          }
          else
          {
              $zip->close();
              return false;
          }
        } 
        else 
        {
          return false;
        }
    }
    
	 
	 /**
      * Remove a Directory Recursively
      */
	public static function DeleteDirectoryRecursively($dir) 
	{ 
		if (is_dir($dir)) 
		{ 
			$objects = scandir($dir); 
			foreach ($objects as $object) 
			{ 
				if ($object != "." && $object != "..") 
				{ 
					if (is_dir($dir."/".$object))
					{
						self::DeleteDirectoryRecursively($dir."/".$object);
					}
					else
					{
						unlink($dir."/".$object); 
					}			   
				} 
			}
			rmdir($dir); 
	   } 
	}
	
    /**
     * Downloads a file from the folder uploads
     */
    public static function DownloadFileToWebServer($filename, $file_url) 
    {
        return @file_put_contents($filename, fopen($file_url, 'r'));
    }
    
    /**
     * Downloads a file from the folder uploads
     */
	public static function DownloadFile($file) 
	{
		//This condition restricts downloads only for the uploads folder
		if(strpos($file, "/uploads/") !== false)
		{
			$finfo = finfo_open(FILEINFO_MIME_TYPE);
			$mime = finfo_file($finfo, $file);
			finfo_close($finfo);
			header("Content-Type: " . $mime);
			header('Content-Disposition: attachment; filename="'.basename($file).'"');
			header('Content-Transfer-Encoding: binary');
			header('Expires: 0');
			header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
			header('Pragma: no-cache');
			header('Content-Length: ' . filesize($file));
			ob_clean();
			flush();
			readfile($file);
		}
		else
		{
			Logger::Error("Error downloading a file. The file url is " . $file);
			RequestManager::RequestError(); //Error on download, posible hacker attack...
		}
	}
}

?>