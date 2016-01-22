<?php
require_once "requestmanager.php";
require_once "filemanager.php";
require_once "systemqueries.php";
require_once "model.php";
require_once "logger.php";

class Is
{
	/**
     * Gets the form inputs and validates it's format and dataype and if it's required or not
     * @param form_name The name of the form
     * @param exclude_columns array of columns names that you dont want to validate
     */
	public static function ValidRequest($form_name, $exclude_columns = null)
	{
		$inputs = Model::ArrayToObject(SystemQueries::form_input_structure($form_name));
		foreach($inputs as $input) 
		{
			if($exclude_columns == null || !in_array($input->input_name, $exclude_columns))
			{			
				self::Set($input);
				self::Nullable($input);
                if($input->input_type != "file")
                {
                    if(self:: VarcharBlobText($input))
                    {
                        continue;
                    }
                    else if(self::Integer($input))
                    {
                        continue;
                    }
                    else if(self::DoubleFloat($input))
                    {
                        continue;
                    }
                    else 
                    { 
                        return false;   
                    }  
                }							
			}
		}
		return true;
	}
	
    /**
     * Checks if the input is set on post
     * @param input The input object
     */
	public static function Set($input)
	{
		if($input->input_type != "file" && !isset($_POST[$input->input_name])) 
		{
			Logger::Request();
			Logger::Error($input->input_name . " is not set on POST.");
			RequestManager::RequestUnexpectedValueTypeOrFormat();
		}
	}
	
    /**
     * Check is the input can be null or empty string
     * @param input The input object
     */
	public static function Nullable($input)
	{
		//Check if input cant be null or empty.
		if($input->input_is_nullable === "YES")
		{
			//Files doesn't come on $_POST so skip validation
			if($input->input_type == "file")
			{
				//If file is set and exist the another file exist delete the old file and upload the new file - Update Operation
				if(isset($_POST[$input->input_name]) && !empty($_POST[$input->input_name]) && !empty($_FILES[$input->input_name]["name"]))
				{
					FileManager::DeleteFile(Security::DecrypText($_POST[$input->input_name]));
					FileManager::UploadFormFiles($input->form_name_id, $input->input_name);
				}
				//If file is set and post is empty and upload the file - Insert Operation
				else if(!isset($_POST[$input->input_name]) && empty($_POST[$input->input_name]) && !empty($_FILES[$input->input_name]["name"]))
				{
					FileManager::UploadFormFiles($input->form_name_id, $input->input_name);
				}
				//Set back the file url
				else if(isset($_POST[$input->input_name]) && !empty($_POST[$input->input_name]))
				{
					$_POST[$input->input_name] = Security::DecrypText($_POST[$input->input_name]);
				}
			}
			else
			{
				$value = trim($_POST[$input->input_name]);
				if($value != "") 
				{
					if(!preg_match("~" . $input->input_regex . "~", $value))
					{
						Logger::Request();
						Logger::Error($input->input_name . " failed evaluating the regex " . $input->input_regex);
						RequestManager::RequestUnexpectedValueTypeOrFormat();
					}
				}
			}
		}
		//Checks is input can't be null
		else if($input->input_is_nullable === "NO")
		{
			//Upload the file and check is url is set
			if($input->input_type == "file")
			{
				//If file is set and exist the another file exist delete the old file and upload the new file - Update Operation
				if(isset($_POST[$input->input_name]) && !empty($_POST[$input->input_name]) && is_uploaded_file($_FILES[$input->input_name]["tmp_name"]) && $_FILES[$input->input_name]['error'] == UPLOAD_ERR_OK)
				{
					FileManager::DeleteFile(Security::DecrypText($_POST[$input->input_name]));
					FileManager::UploadFormFiles($input->form_name, $input->input_name);
				}
				//If file is set and post is empty and upload the file - Insert Operation
				else if(!isset($_POST[$input->input_name]) && empty($_POST[$input->input_name]) && is_uploaded_file($_FILES[$input->input_name]["tmp_name"]) && $_FILES[$input->input_name]['error'] == UPLOAD_ERR_OK)
				{
					FileManager::UploadFormFiles($input->form_name, $input->input_name);
				}
				//Set back the file url
				else if(isset($_POST[$input->input_name]) && !empty($_POST[$input->input_name]))
				{
					$_POST[$input->input_name] = Security::DecrypText($_POST[$input->input_name]);
				}
				$value = trim($_POST[$input->input_name]);
				if($value == "")
				{
					Logger::Request();
					Logger::Error($input->input_name . " is a file required and the value is empty.");
					RequestManager::RequestUnexpectedValueTypeOrFormat();
				}				
			}
			else
			{
				$value = trim($_POST[$input->input_name]);
				if($value == "" || !preg_match("~" . $input->input_regex . "~", $value))
				{
					Logger::Request();
					Logger::Error($input->input_name . " is empty or failed evaluating the regex " . $input->input_regex);
					RequestManager::RequestUnexpectedValueTypeOrFormat();
				}
			}					
		}
	}
	
	/**
     * Checks if the datatype is varchar, text, enum, set or blob
     * @param input The input object
     */
	public static function VarcharBlobText($input)
	{
		if( $input->input_data_type == "CHAR" || 
			$input->input_data_type == "VARCHAR" || 
			$input->input_data_type == "TINYTEXT" || 
			$input->input_data_type == "TEXT" || 
			$input->input_data_type == "MEDIUMTEXT" || 
			$input->input_data_type == "LONGTEXT" ||
			$input->input_data_type == "BINARY" || 
			$input->input_data_type == "VARBINARY" ||
			$input->input_data_type == "TINYBLOB" ||
			$input->input_data_type == "MEDIUMBLOB" ||
			$input->input_data_type == "BLOB" ||
			$input->input_data_type == "LONGBLOB" || 
			$input->input_data_type == "ENUM" ||
			$input->input_data_type == "SET")
		{
			$value = trim($_POST[$input->input_name]);
			if(!is_string($value) || strlen($value) > $input->input_maxlength)
			{
				Logger::Request();
				Logger::Error($input->input_name . " is not a string or exceded the maximun character. " . $input->input_name . " length = " . strlen($value) . ". Character maximum length = " . $input->input_maxlength . ".");
				RequestManager::RequestUnexpectedValueTypeOrFormat();
			}
			return true;
		}
		return false;
	}
	
    /**
     * Checks if the datatype is an integer
     * @param input The input object
     */
	public static function Integer($input)
	{
		if( $input->input_data_type == "TINYINT" || 
			$input->input_data_type == "SMALLINT" || 
			$input->input_data_type == "MEDIUMINT" || 
			$input->input_data_type == "INT" || 
			$input->input_data_type == "INTERGER" || 
			$input->input_data_type == "BIGINT" ||
			$input->input_data_type == "BIT" || 
			$input->input_data_type == "BOOL" ||
			$input->input_data_type == "BOOLEAN" ||
			$input->input_data_type == "SERIAL")
		{
			if(!is_int((int)$_POST[$input->input_name]))
			{
				Logger::Request();
				Logger::Error($input->input_name . " is not an interger. " . $input->input_name . " = " . $_POST[$input->input_name]);
				RequestManager::RequestUnexpectedValueTypeOrFormat();
			}
			return true;
		}
		return false;
	}
	
    /**
     * Checks if the datatype is a double, float, decimal
     * @param input The input object
     */
	public static function DoubleFloat($input)
	{
		if( $input->input_data_type == "DECIMAL" || 
			$input->input_data_type == "DEC" || 
			$input->input_data_type == "FLOAT" || 
			$input->input_data_type == "DOUBLE" ||
			$input->input_data_type == "NUMERIC" ||
			$input->input_data_type == "DOUBLE PRECISION" ||
			$input->input_data_type == "REAL")
		{
			if(!is_float((float)$_POST[$input->input_name]))
			{
				Logger::Request();
				Logger::Error($input->input_name . " is not a float or double. " . $input->input_name . " = " . $_POST[$input->input_name]);
				RequestManager::RequestUnexpectedValueTypeOrFormat();
			}
			return true;
		}
		return false;
	}
}