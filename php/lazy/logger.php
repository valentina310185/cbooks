<?php
/**
 * This class is used for logs and debugging.
 * It's logs the data into files in json format
 */
class Logger
{
    /**
     * Debugs any info you want to store and view
     * @param data stores the data
     */
	public static function Debug($data)
	{
		file_put_contents('debug.txt', json_encode($data, JSON_PRETTY_PRINT), FILE_APPEND);
	}
	
    /**
     * Logs an entire request
     */
	public static function Request()
	{
		file_put_contents('requesterror.txt', json_encode($_REQUEST, JSON_PRETTY_PRINT), FILE_APPEND);
	}
	
    /**
     * Logs database exception
     * @param exception stores the database exception
     */
	public static function Database($exception)
	{
		file_put_contents('dberror.txt', json_encode($exception, JSON_PRETTY_PRINT), FILE_APPEND);
	}
	
    /**
     * Logs the uploaded files
     */
	public static function File()
	{
		file_put_contents('fileuploaderror.txt', json_encode($_FILES, JSON_PRETTY_PRINT), FILE_APPEND);
	}
	
    /**
     * Logs any kind of exception or error
     */
	public static function Error($message)
	{
		file_put_contents('error.txt', json_encode($message, JSON_PRETTY_PRINT), FILE_APPEND);
	}
}
?>