<?php
require_once "pdodb.php";
/**
 * Manage Database connections and queries in a simplified wrapper
 */
class DBManager
{
    /**
     * Executes query and returns status of the db result
     * @param query The query string to execute
     */
    public static function ExecuteNonQuery($query)
    {
        $PDODB = new PDODB();
        $PDODB->ExecuteNonQuery($query);
        return $PDODB->GetDatabaseResult();
    }
	
    /**
     * Executes query returns the db resultset rows
     * @param query The query string to execute
     */
    public static function ExecuteQuery($query)
    {
        $PDODB = new PDODB();
        $PDODB->ExecuteQuery($query);
        return $PDODB->GetData();
    }
}