<?php
require_once "request.php";
require_once "systemqueries.php";
require_once "logger.php";
require_once "dialog.php";

class RequestManager
{	
	/**
     * Manages the request
     */
	public static function RequestHandler($Request)
	{
		if(isset($Request->Get->class_name) && !empty($Request->Get->class_name) && is_string($Request->Get->class_name) && isset($Request->Get->function_name) && !empty($Request->Get->function_name) && is_string($Request->Get->function_name))
		{
			self::InvokeMethod($Request);
		}
		else
		{
			Logger::Error("Request error: requested class_name:" . $Request->Get->class_name . " - function_name:" . $Request->Get->function_name);
			self::RequestClassOrMethodNotExist();
		}
	}
	
	/**
     * Invokes the class method stored on database
     */
	private static function InvokeMethod($Request)
	{
		$class = Model::ArrayToObject(SystemQueries::GetClass($Request->Get->class_name));
		if(count($class) === 0)
		{
			Logger::Error("Request error: The requested class_name doesn't exist. Requested class_name:" . $Request->Get->class_name . " - function_name:" . $Request->Get->function_name);
			self::RequestClassOrMethodNotExist();
		}
		else
		{
			if(is_callable(array($class->class_name, $Request->Get->function_name), true))
			{
				try
				{
					eval("?>" . $class->class_code);
					if(method_exists($class->class_name,$Request->Get->function_name))
					{
						call_user_func(array($class->class_name, $Request->Get->function_name));
					}
					else
					{
						Logger::Error("Request error: The requested function doesn't exist. Requested class_name:" . $Request->Get->class_name . " - function_name:" . $Request->Get->function_name);
						self::RequestClassOrMethodNotExist();
					}
				}
				catch (Exception $e) 
				{
					Logger::Error("Request error: The class code could not be interpreted at runtime. Please check that your code is free of errors. Requested class_name:" . $Request->Get->class_name . " - function_name:" . $Request->Get->function_name);
					self::RequestRuntimeErrorOnCompilingCode();
				}							
			}
			else
			{
				Logger::Error("Request error: The requested function name can't be used to call a method. Requested class_name:" . $Request->Get->class_name . " - function_name:" . $Request->Get->function_name);
				self::RequestClassOrMethodNotExist();
			}
		}
	}
	
    /**
     * Sets the application/javascript header for the response 
     */
    public static function ScriptResponseHeader()
    {
        header('Content-Type: application/javascript');
    }
    
    /**
     * Request database error message
     */
    public static function RequestDatabaseError($msg = null)
    {
        self::ScriptResponseHeader();
        Dialog::Danger("Error", (is_null($msg)) ? "There was an internal database error!" :  $msg, "Ok");
        die();
    }
    
	/**
     * Request error message
     */
	public static function RequestError($msg = null)
	{
	    self::ScriptResponseHeader();
        Dialog::Danger("Error", (is_null($msg)) ? "There was an internal server error processing the request!" :  $msg, "Ok");
        die();
    }
	
	/**
     * Request OK message 
     */
	public static function RequestOk($msg = null)
	{
		self::ScriptResponseHeader();
        Dialog::Success("Success", (is_null($msg)) ? "The record was saved successfully!" :  $msg, "Ok");
        die();
    }
    
    /**
     * Record not found message 
     */
    public static function RequestNoRecordFoundSearch($msg = null)
    {
        self::ScriptResponseHeader();
        Dialog::Success("Information", (is_null($msg)) ? "No record was found with your search criteria!" :  $msg, "Ok");
        die();
    }
    
    /**
     * Record not found message 
     */
    public static function RequestNoRecordFound($msg = null)
    {
        self::ScriptResponseHeader();
        Dialog::Success("Information", (is_null($msg)) ? "No record was found!" :  $msg, "Ok");
        die();
    }
    
    /**
     * Record saved message 
     */
    public static function RequestRecordSaved($msg = null)
    {
        self::ScriptResponseHeader();
        Dialog::Success("Success", (is_null($msg)) ? "The record was saved successfully!" :  $msg, "Ok");
        die();
    }
    
    /**
     * Record deledt message 
     */
    public static function RequestRecordDeleted($msg = null)
    {
        self::ScriptResponseHeader();
        Dialog::Success("Success", (is_null($msg)) ? "The record was deleted successfully!" :  $msg, "Ok");
        die();
    }
	
	/**
     * Request Unexpected Value Type Or Format message
     */
	public static function RequestUnexpectedValueTypeOrFormat($msg = null)
	{
		self::ScriptResponseHeader();
        Dialog::Danger("Error", (is_null($msg)) ? "There was an unexpected value/s types or format/s error/s processing the data posted to server!" :  $msg, "Ok");
        die();
	}
	
	/**
     * Request Method Not Exist message
     */
	public static function RequestClassOrMethodNotExist($msg = null)
	{
		self::ScriptResponseHeader();
        Dialog::Danger("Error", (is_null($msg)) ? "There was an error, the class or function handler called doesn't exist!" :  $msg, "Ok");
        die();
    }
	
	/**
     * Request Session Ended message
     */
	public static function RequestSessionEnded($msg = null)
	{
		self::ScriptResponseHeader();
        Dialog::Warning("Session Ended", (is_null($msg)) ? "It's have been some time you haven't made a request! For security reasons please log in back again!" :  $msg, "Ok", "function(){window.location = window.location}");
        die();
    }
	
	/**
     * Request Request Runtime Error On Compiling Code
     */
	public static function RequestRuntimeErrorOnCompilingCode($msg = null)
	{
		self::ScriptResponseHeader();
        Dialog::Danger("Error", (is_null($msg)) ? "There was an internal server error processing the request! The code couldn't be compiled in runtime! Please contact the server administrator to fix this issue!" :  $msg, "Ok");
        die();
    }
}
?>