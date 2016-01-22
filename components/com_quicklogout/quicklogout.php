<?php
/**
 * @version     1.9.3
 * @package     com_quicklogout
 * @copyright   Copyright (C) 2011. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 * @author      Created by com_combuilder - http://www.notwebdesign.com
 * Version 1.8 includes an addition by Chad Myers to allow the user to specify the logout redirect
 */

defined('_JEXEC') or die;

// Include dependancies
jimport('joomla.application.component.controller');

// get param and menu URL
$params = JFactory::getApplication('site')->getParams();
$item = JFactory::getApplication()->getMenu()->getItem($params->get("quick_logout_redirect"));
$url = JRoute::_($item->link . '&Itemid=' . $item->id,false);

// lets try to make this simple
// $loloc = "Location: index.php?option=com_users&task=user.logout&";

$loloc = "Location: " . JURI::root(true) . "/index.php?option=com_users&task=user.logout&";
$loloc .=  JSession::getFormToken();
$loloc .= "=1&return=";

// original code here
//$loloc .= base64_encode($url ."\n");

// modification contributed by Shawn Sparks
$loloc .= base64_encode( htmlspecialchars_decode( $url )."\n" );
header( $loloc );


// Execute the task.
//$controller	= JController::getInstance('Quicklogout');
//$controller->execute(JRequest::getVar('task',''));
//$controller->redirect();
