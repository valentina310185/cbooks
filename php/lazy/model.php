<?php
require_once "systemqueries.php";
require_once "dbmanager.php";
/**
 * Creates dinamic models of objects of properties based on arrays
 */
class Model
{	
	/**
	 * Loops to every object in array and converts it to an object
	 * @param array array of objects
	 * @param &obj a key of an object that is a nested array
	 */
	private static function array_to_obj($array, &$obj)
	{
		foreach ($array as $key => $value)
		{
			if (is_array($value))
			{
				$obj->$key = new stdClass();
				self::array_to_obj($value, $obj->$key);
			}
			else
			{
				$obj->$key = $value;
			}
		}
		return $obj;
	}
	
	/**
     * Converts an array into objects
	 * @param array array of objects
	 */
	public static function ArrayToObject($array)
	{
		$object = new stdClass();
		return self::array_to_obj($array,$object);
	}
	
	/**
	 * Get the data from query stored in the database and converts it to an object of properties
	 * @param query_name query to call from the database
	 */
	public static function GetFromQuery($query_name)
	{
		$query = SystemQueries::GetQuery($query_name);
		return self::ArrayToObject(DBManager::ExecuteQuery($query[0]["query_text"]));
	}
}
?>