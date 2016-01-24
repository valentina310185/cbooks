<?php
require_once "config.php";
require_once "model.php";
require_once "logger.php";
/**
 * This class manage the database connections
 */
class PDODB extends PDODBConfig
{
    /**
     * PDO object instance
     */
    private $PDO;
    /**
     * PDO statement string
     */
    private $Statement;
    /**
     * Database success or fail result on executing query
     */
    private $DBResult = false;
    /**
     * Database result set collection array
     */
    private $DataCollection;
    /**
     * Executes a query and returns the result
     */
    public function __construct($query = null, $array = null)
    {
        if(is_string($query) && !is_null($query))
        {
            $this->Connect();
            $this->PrepareStatement($query);
            $this->AddParametersCollection($query,$array);                 
            $this->Execute();
        } 
    }
    /** 
     * Opens a database connection
     * @return Boolean
     */
    public function Connect()
    {
        try 
        {
            $DBconfig = Model::ArrayToObject(PDODBConfig::Config());
            $this->PDO = new PDO($DBconfig->driver . $DBconfig->host . $DBconfig->database_name, $DBconfig->user, $DBconfig->password, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8")) or die("ConnectionString error. Please check your database config.");
            $this->PDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, true);
            $this->PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->PDO->setAttribute(PDO::MYSQL_ATTR_FOUND_ROWS, true);
            $this->PDO->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true);
            return true;
        }
        catch (PDOException $e) 
        {
            Logger::Database($e);
            return false;
        }
        catch (Exception $e) 
        {
            Logger::Database($e);
            return false;
        }
    }
    
    /**
     * Closes database connection
     * Free some resources
     */
    public function Disconnect()
    {
        $this->PDO = null;
        $this->Statement = null;
    }
    
    /**
     * Sets the form POST values params into values
     * @param query the query string
     */
    public function AddParametersCollection($query, $array = null)
    {
        if(is_null($array))
        {
            $array = $_POST;
        }
        foreach ($array as $name => $value) 
        {
			if (strpos($query, ':' . $name) !== false)
			{
				$ocurrences = substr_count($query, ':' . $name);
				for ($i = 0; $i < $ocurrences; $i++) 
				{
					if(is_array($array[$name]))
						$this->Statement->bindValue(':' . $name, implode(', ', $array[$name]));
					else if (!is_string($value) || !is_numeric($value))
						$this->Statement->bindValue(':' . $name, $value);
					else
						$this->Statement->bindValue(':' . $name, $this->FilterText($value));
				}				 
            }        
        }
    }
	
    /**
     * Sets a query param into a value
     * @param param the parameter name
     * @param value the parameter value
     */
    public function AddParam($param, $value)
    {
        if (strpos($query, $param) !== false)
		{
			$ocurrences = substr_count($query, $param);
			for ($i = 0; $i < $ocurrences; $i++) 
			{
				if(is_array($value))
					$this->Statement->bindValue($param, implode(', ', $value));
				else if (!is_string($value) || !is_numeric($value))
					$this->Statement->bindValue($param, $value);
				else
					$this->Statement->bindValue($param, $this->FilterText($value));
			}			 
		} 
    }
    
    /**
     * Filters the values entered by the user to prevent and remove malicious scripts
     * @param value the value to filter
     */
    public function FilterText($value)
    {
    	$value = strip_tags($value);
        $value = htmlentities($value);
        $value = trim($value);
        return $value;
    }
    
    /**
     * Prepares the statement to be executed
     * @param query the query string
     */
    public function PrepareStatement($query)
    {
        if ($this->PDO) 
        {
            $this->Statement = $this->PDO->prepare($query);
            return true;
        } 
        else if ($this->Connect()) 
        {
            $this->PrepareStatement($query);
            return true;
        } 
        else
        {
            return false;     
        }            
    }
    
    /**
     * Execute
     * Executes the query statement
     */
    public function Execute()
    {
        try 
        {
            if ($this->PDO) 
            {
                $this->Statement->execute();
                $this->DataCollection = $this->Statement->fetchAll();
                $this->DBResult = true;
            } 
            else if ($this->Connect()) 
            {
                $this->Execute();
                $this->DataCollection = $this->Statement->fetchAll();
                $this->DBResult = true;    
            } 
            else
            {
                $this->DBResult = false;    
            }                
        }
        catch (PDOException $e) 
        {
            Logger::Database($e);
            $this->DBResult = false;
        }
        catch (Exception $e) 
        {
            Logger::Database($e);
            $this->DBResult = false;
        }
    }
    
    /**
     * Opens Connection
     * Prepares the statment
     * Binds ParameterCollection on Post
     * Executes a Query
     * Closes Connection
     * Returns true if query is executed correctly otherwise false
     * @param query the query string
     */
    public function ExecuteQuery($query, $array = null)
    {
        try 
        {
            if ($this->Connect()) 
            {
                $this->Statement = $this->PDO->prepare($query);
                $this->AddParametersCollection($query, $array);
                $this->Statement->execute();
                $this->DataCollection = $this->Statement->fetchAll();
                $this->Statement->closeCursor();
                $this->Disconnect();
                return true;
            }
            else 
            {
                $this->DBResult = false;
            }            
        }
        catch (PDOException $e) 
        {
            Logger::Database($e);
            Logger::Debug($query);
            Logger::Request();
            $this->DBResult = false;
        }
        catch (Exception $e) 
        {
            Logger::Database($e);
            Logger::Debug($query);
            Logger::Request();
            $this->DBResult = false;
        }
    }
    
    /**
     * Opens Connection
     * Prepares the statment
     * Binds ParameterCollection on Post
     * Executes a Query
     * Closes Connection
     * Returns true if query is executed correctly otherwise false
     * @return Boolean
     */
    public function ExecuteNonQuery($query, $array = null)
    {
        try 
        {
            if ($this->Connect()) 
            {
                $this->Statement = $this->PDO->prepare($query);
                $this->AddParametersCollection($query, $array);
                $this->Statement->execute();
                $this->Disconnect();
                $this->DBResult = true;
            }
            else 
            {
                $this->DBResult = false;
            }            
        }
        catch (PDOException $e) 
        {
            Logger::Database($e);
            Logger::Debug($query);
            Logger::Request();
            $this->DBResult = false;
        }
        catch (Exception $e) 
        {
            Logger::Database($e);
            Logger::Debug($query);
            Logger::Request();
            $this->DBResult = false;
        }
    }
    
    /**
     * Return the database result set
     * @return String
     */
    public function GetData()
    {
        return $this->DataCollection;
    }
    
    /**
     * Gets the database result of the query
     * @return boolean
     */
    public function GetDatabaseResult()
    {
        return $this->DBResult;
    }
    
    /**
     * Free result set array
     */
    public function UnsetData()
    {
        $this->DataCollection = array();
    }
}
?>