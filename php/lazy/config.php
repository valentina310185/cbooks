<?php
/**
 * Database connection string
 */
abstract class PDODBConfig 
{
    /**
     * Gets the database connection string 
     */
	static protected function Config() 
    {
	   //Database Config
	   $config = array();
	   // Database driver:
	   $config["driver"] = "mysql:";
	   // Database hostname:
	   $config["host"] = "host=localhost;";
	   // Database name:
	   $config["database_name"] = "dbname=cbooks;";
	   // Database charset:
	   $config["charset"] = "charset=utf8;";
	   // Database username:
	   $config["user"] = "root";
	   // Database password:
	   $config["password"] = "elgueta#12";
	   // Return Connection Config
	   return $config;
	}
}