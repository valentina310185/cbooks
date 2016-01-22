<?php
	foreach(glob(__DIR__ . "/lazy/*.php") as $php) 
	{
		require_once $php ;
	}
?>
