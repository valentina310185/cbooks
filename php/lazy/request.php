<?php
require_once "model.php";
/**
 * Converts the following request array values container into objects
 * $_COOKIE
 * $_ENV
 * $_FILES
 * $_GET
 * $_POST
 * $_REQUEST
 * $_SERVER
 */
class Request
{
	public $Cookie,$Enviroment,$Files,$Get,$Post,$Request,$Server;
	public function __construct () 
	{
		$this->Cookie = Model::ArrayToObject($_COOKIE);
		$this->Enviroment =	Model::ArrayToObject($_ENV);
		$this->Files = Model::ArrayToObject($_FILES);
		$this->Get = Model::ArrayToObject($_GET);
		$this->Post = Model::ArrayToObject($_POST);
        $this->Request = Model::ArrayToObject($_REQUEST);
		$this->Server = Model::ArrayToObject($_SERVER);
	}
}