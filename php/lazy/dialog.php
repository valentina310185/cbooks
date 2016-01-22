<?php

require_once "requestmanager.php";
/**
 * This class is a php wrapper to pop up bootstrap dialogs from server side code 
 */
class Dialog
{
	public static function _Default($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Default("<?=$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Info($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Info("<?=$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Primary($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Primary("<?=$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Success($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Success("<?=$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Warning($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Warning("<?$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Danger($title, $msg, $buttonText, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Danger("<?=$title?>", "<?=$msg?>", "<?=$buttonText?>", <?=$callback?>)
		<?php
	}
	
	public static function Confirm($title, $msg, $buttonTextPrimary, $buttonTextSecondary, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Confirm("<?=$title?>", "<?=$msg?>", "<?=$buttonTextPrimary?>", "<?=$buttonTextSecondary?>", <?=$callback?>)
		<?php
	}
	
	public static function Decision($title, $msg, $buttonTextPrimary, $buttonTextSecondary, $buttonTextTertiary, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Decision("<?=$title?>", "<?=$msg?>", "<?=$buttonTextPrimary?>", "<?=$buttonTextSecondary?>", "<?=$buttonTextTertiary?>", <?=$callback?>)
		<?php
	}
	
	public static function Prompt($input_msg, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.Prompt("<?=$input_msg?>", <?=$callback?>)
		<?php
	}
	
	public static function PromptDouble($input_msg1, $input_msg2, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.PromptDouble("<?=$input_msg1?>", "<?=$input_msg2?>", <?=$callback?>)
		<?php
	}
	
	public static function PromptTriple($input_msg1, $input_msg2, $input_msg3, $callback = "function(){}")
	{
	    RequestManager::ScriptResponseHeader();
		?>
		Dialog.PromptTriple("<?=$input_msg1?>", "<?=$input_msg2?>", "<?=$input_msg3?>", <?=$callback?>)
		<?php
	}
    
    public static function NotifyInfo($msg)
    {
        RequestManager::ScriptResponseHeader();
        ?>
        jQuery.Notify("<?=$msg?>", "info")
        <?php
    }
    
    public static function NotifySuccess($msg)
    {
        RequestManager::ScriptResponseHeader();
        ?>
        jQuery.Notify("<?=$msg?>", "success")
        <?php
    }
    
    public static function NotifyWarning($msg)
    {
        RequestManager::ScriptResponseHeader();
        ?>
        jQuery.Notify("<?=$msg?>", "warn")
        <?php
    }
    
    public static function NotifyDanger($msg)
    {
        RequestManager::ScriptResponseHeader();
        ?>
        jQuery.Notify("<?=$msg?>", "error")
        <?php
    }
}
?>