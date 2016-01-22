<?php
/**
 *------------------------------------------------------------------------------
 * @package       T3 Framework for Joomla!
 *------------------------------------------------------------------------------
 * @copyright     Copyright (C) 2004-2013 JoomlArt.com. All Rights Reserved.
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 * @authors       JoomlArt, JoomlaBamboo, (contribute to this project at github
 *                & Google group to become co-author)
 * @Google group: https://groups.google.com/forum/#!forum/t3fw
 * @Link:         http://t3-framework.org
 *------------------------------------------------------------------------------
 */

jimport('joomla.filesystem.file');
jimport('joomla.filesystem.folder');
// add new Less format class to work with joomla 3.3
if (version_compare(JVERSION, '3.3.0') >= 0) {
	T3::import('format/less3.3');
}

/**
 *
 * Admin helper module class
 * @author JoomlArt
 *
 */
class T3AdminTheme
{
	/**
	 *
	 * save Profile
	 */

	public static function response($data){
		die(json_encode($data));
	}

	public static function error($msg){
		return self::response(array('error' => $msg));
	}

	public static function save($path)
	{
		$result = array();

		if(empty($path)){
			return self::error(JText::_('T3_TM_UNKNOWN_THEME'));
		}

		$theme = JFactory::getApplication()->input->getCmd('theme');
		$from = JFactory::getApplication()->input->getCmd('from');
		if (!$theme) {
			return self::error(JText::_('T3_TM_INVALID_DATA_TO_SAVE'));
		}

		//incase empty from
		if(!$from){
			$from = 'base';
		}

		// $file = $path . '/less/themes/' . $theme . '/variables-custom.less';
		$file =T3Path::getLocalPath('less/themes/' . $theme . '/variables-custom.less');

		if(!class_exists('JRegistryFormatLESS')){
			T3::import('format/less');
		}
		$variables = new JRegistry();
		$variables->loadObject($_POST);

		$data = $variables->toString('LESS');
		$type = 'new';
		if (JFile::exists($file)) {
			$type = 'overwrite';
		} else {
			if($theme != $from && JFolder::exists($path . '/less/themes/' . $from)){
				$source = $path . '/less/themes/' . $from;
				if (!JFolder::exists($source)) {
					// try to find the source in local
					$source = T3Path::getPath('less/themes/' . $from);
					if (!$source) {
						return self::error(JText::sprintf('T3_TM_NOT_FOUND', $from));
					}
				}
				$desc = T3Path::getLocalPath('less/themes/' . $theme);
				if(@JFolder::copy($source, $desc) != true){
					return self::error(JText::_('T3_TM_NOT_FOUND'));
				}
				
				// detect & copy rtl
				$rtlsource = $path . '/less/rtl/' . $from;
				if (!JFolder::exists($rtlsource)) {
					// try to find the source in local
					$rtlsource = T3Path::getPath('less/rtl/' . $from);
				}
				
				if ($rtlsource) {
					$rtldest = T3Path::getLocalPath('less/rtl/' . $theme);
					// copy $from to $theme
					@JFolder::copy($rtlsource, $rtldest);
				}
			}
		}

		$return = @JFile::write($file, $data);

		if (!$return) {
			return self::error(JText::_('T3_TM_OPERATION_FAILED'));
		} else {
			$result['success'] = JText::sprintf('T3_TM_SAVE_SUCCESSFULLY', $theme);
			$result['theme'] = $theme;
			$result['type'] = $type;
		}

		//LessHelper::compileForTemplate(T3_TEMPLATE_PATH, $theme);
		T3::import ('core/less');
		T3Less::compileAll($theme);
		return self::response($result);
	}

	/**
	 *
	 * Clone Profile
	 */
	public static function duplicate($path)
	{
		$theme = JFactory::getApplication()->input->getCmd('theme');
		$from = JFactory::getApplication()->input->getCmd('from');
		$result = array();

		if (empty($theme) || empty($from)) {
			return self::error(JText::_('T3_TM_INVALID_DATA_TO_SAVE'));
		}

		$source = $path . '/less/themes/' . $from;
		if (!JFolder::exists($source)) {
			// try to find the source in local
			$source = T3Path::getPath('less/themes/' . $from);
			if (!$source) {
				return self::error(JText::sprintf('T3_TM_NOT_FOUND', $from));
			}
		}

		// $dest = $path . '/less/themes/' . $theme;
		// clone to local
		$dest = T3Path::getLocalPath('less/themes/' . $theme);
		if (JFolder::exists($dest)) {
			return self::error(JText::sprintf('T3_TM_EXISTED', $theme));
		}
		
		// copy $from to $theme
		$status = @JFolder::copy($source, $dest);
		
		$rtlsource = $path . '/less/rtl/' . $from;
		if (!JFolder::exists($rtlsource)) {
			// try to find the source in local
			$rtlsource = T3Path::getPath('less/rtl/' . $from);
		}
		
		if ($rtlsource) {
			$rtldest = T3Path::getLocalPath('less/rtl/' . $theme);
			// copy $from to $theme
			@JFolder::copy($rtlsource, $rtldest);
		}
		
		$result = array();
		if ($status) {
			$result['success'] = JText::_('T3_TM_CLONE_SUCCESSFULLY');
			$result['theme'] = $theme;
			$result['reset'] = true;
			$result['type'] = 'duplicate';
		} else {
			return self::error(JText::_('T3_TM_OPERATION_FAILED'));
		}

		//LessHelper::compileForTemplate(T3_TEMPLATE_PATH , $theme);
		T3::import ('core/less');
		T3Less::compileAll($theme);
		return self::response($result);
	}

	/**
	 *
	 * Delete a profile
	 */
	public static function delete($path)
	{
		// Initialize some variables
		$theme = JFactory::getApplication()->input->getCmd('theme');
		$result = array();

		if (!$theme) {
			return self::error(JText::_('T3_TM_UNKNOWN_THEME'));
		}

		// delete custom theme
		$paths = array();
		$paths = array_merge($paths, T3Path::getAllPath('less/themes/' . $theme));
		$paths = array_merge($paths, T3Path::getAllPath('css/themes/' . $theme));
		$paths = array_merge($paths, T3Path::getAllPath('less/rtl/' . $theme));
		$paths = array_merge($paths, T3Path::getAllPath('css/rtl/' . $theme));

		$errors = array();
		foreach ($paths as $path) {
			if (is_dir ($path) && !@JFolder::delete($path)) {
				$errors[] = $path;
			}
		}

		if (count($errors)) {
			return self::error(JText::sprintf('T3_TM_DELETE_FAIL', implode(' - ', $errors)));
		} else {
			$result['template'] = '0';
			$result['success'] = JText::sprintf('T3_TM_DELETE_SUCCESSFULLY', $theme);
			$result['theme'] = $theme;
			$result['type'] = 'delete';
		}

		return self::response($result);
	}

	/**
	 *
	 * Show thememagic form
	 */
	public static function thememagic($path)
	{
		$app       = JFactory::getApplication();
		$input     = $app->input;
		$isadmin   = $app->isAdmin();

		if($isadmin){
			$tplparams = T3::getTplParams();
		} else {
			$tplparams = $app->getTemplate(true)->params;
		}

		$url = $isadmin ? JUri::root(true).'/index.php' : JUri::current();
		$url .= (preg_match('/\?/', $url) ? '&' : '?') . 'themer=1';
		$url .= ($tplparams->get('theme', -1) != -1 ? ('&t3style=' . $tplparams->get('theme')) : '');
		if($isadmin){
			$url .= '&t3tmid=' . $input->getCmd('id');
		}

		$assetspath = T3_TEMPLATE_PATH;
		$themepath = $assetspath . '/less/themes';
		if(!class_exists('JRegistryFormatLESS')){
			include_once T3_ADMIN_PATH . '/includes/format/less.php';
		}

		$themes   = array();
		$jsondata = array();

		//push a default theme
		$tobj = new stdClass();
		$tobj->id    = 'base';
		$tobj->title = JText::_('JDEFAULT');

		$themes['base'] = $tobj;

		$varfile = $assetspath . '/less/variables.less';
		if(file_exists($varfile)){
			$params = new JRegistry;
			$params->loadString(JFile::read($varfile), 'LESS');
			$jsondata['base'] = $params->toArray();
		}

		// if (JFolder::exists($themepath)) {
		foreach (T3Path::getAllPath('/less/themes') as $themepath) {
			$listthemes = JFolder::folders($themepath);
			if (count($listthemes)) {
				foreach ($listthemes as $theme) {
					//$varsfile = $themepath . '/' . $theme . '/variables-custom.less';
					//if(file_exists($varsfile)){

						$tobj = new stdClass();
						$tobj->id    = $theme;
						$tobj->title = $theme;

						//check for all less file in theme folder
						$params = false;
						$others = JFolder::files($themepath . '/' . $theme, '.less', false, true);
						foreach($others as $other){
							$otherrel = T3Path::relativePath('less/', str_replace (T3_TEMPLATE_PATH . '/', '', $other));

							//get those developer custom values
							if($other == 'variables.less'){
								$params = new JRegistry;
								$params->loadString(JFile::read($themepath . '/' . $theme . '/variables.less'), 'LESS');
							}

							if($other != 'variables-custom.less'){
								$tobj->$other = $otherrel;
							}
						}

						$cparams = new JRegistry;
						$varsfile = $themepath . '/' . $theme . '/variables.less';
						if(file_exists($varsfile)) $cparams->loadString(JFile::read($varsfile), 'LESS');
						$varsfile = $themepath . '/' . $theme . '/variables-custom.less';
						if(file_exists($varsfile)) $cparams->loadString(JFile::read($varsfile), 'LESS');
						if($params){
							foreach ($cparams->toArray() as $key => $value) {
								$params->set($key, $value);
							}
						} else {
							$params = $cparams;
						}

						$themes[$theme] = $tobj;
						$jsondata[$theme] = $params->toArray();
					//}
				}
			}
		}

		// get active theme
		$active_theme = $tplparams->get('theme', 'base');
		if (!isset($themes[$active_theme])) $active_theme = 'base';

		$langs = array (
			'addTheme'       => JText::_('T3_TM_ASK_ADD_THEME'),
			'delTheme'       => JText::_('T3_TM_ASK_DEL_THEME'),
			'overwriteTheme' => JText::_('T3_TM_ASK_OVERWRITE_THEME'),
			'correctName'    => JText::_('T3_TM_ASK_CORRECT_NAME'),
			'themeExist'     => JText::_('T3_TM_EXISTED'),
			'saveChange'     => JText::_('T3_TM_ASK_SAVE_CHANGED'),
			'previewError'   => JText::_('T3_TM_PREVIEW_ERROR'),
			'unknownError'   => JText::_('T3_MSG_UNKNOWN_ERROR'),
			'lblCancel'      => JText::_('JCANCEL'),
			'lblOk'          => JText::_('T3_TM_LABEL_OK'),
			'lblNo'          => JText::_('JNO'),
			'lblYes'         => JText::_('JYES'),
			'lblDefault'     => JText::_('JDEFAULT')
		);

		//Keepalive
		$config      = JFactory::getConfig();
		$lifetime    = ($config->get('lifetime') * 60000);
		$refreshTime = ($lifetime <= 60000) ? 30000 : $lifetime - 60000;

		// Refresh time is 1 minute less than the liftime assined in the configuration.php file.
		// The longest refresh period is one hour to prevent integer overflow.
		if ($refreshTime > 3600000 || $refreshTime <= 0){
			$refreshTime = 3600000;
		}

		$backurl = JFactory::getURI();
		$backurl->delVar('t3action');
		$backurl->delVar('t3task');

		if(!$isadmin){
			$backurl->delVar('tm');
			$backurl->delVar('themer');
		}

		T3::import('depend/t3form');

		$form = new T3Form('thememagic.themer', array('control' => 't3form'));
		$form->load(JFile::read(JFile::exists(T3_TEMPLATE_PATH . '/thememagic.xml') ? T3_TEMPLATE_PATH . '/thememagic.xml' : T3_PATH . '/params/thememagic.xml'));
		$form->loadFile(T3_TEMPLATE_PATH . '/templateDetails.xml', true, '//config');

		$tplform = new T3Form('thememagic.overwrite', array('control' => 't3form'));
		$tplform->loadFile(T3_TEMPLATE_PATH . '/templateDetails.xml', true, '//config');

		$fieldSets = $form->getFieldsets('thememagic');
		$tplFieldSets = $tplform->getFieldsets('thememagic');

		$disabledFieldSets = array();
		foreach ($tplFieldSets as $name => $fieldSet){
			if(isset($fieldSet->disabled)){
				$disabledFieldSets[] = $name;
			}
		}

		include T3_ADMIN_PATH.'/admin/thememagic/thememagic.tpl.php';

		exit();
	}

	public static function addAssets(){
		$japp = JFactory::getApplication();
		$user = JFactory::getUser();

		//do nothing when site is offline and user has not login (the offline page is only show login form)
		if ($japp->getCfg('offline') && !$user->authorise('core.login.offline')) {
			return;
		}

		$jdoc = JFactory::getDocument();
		$params = $japp->getTemplate(true)->params;
		$devmode = $params->get('devmode', 0);

		if(defined('T3_THEMER') && $params->get('themermode', 1)){

			$jdoc->addStyleSheet(T3_URL.'/css/thememagic.css');
			$jdoc->addScript(T3_URL.'/js/thememagic.js');

			$theme     = $params->get('theme');
			$params    = new JRegistry;
			$themeinfo = new stdClass;

			if($theme){
				foreach (T3Path::getAllPath('less/themes/' . $theme) as $themepath) {
					//$themepath = T3_TEMPLATE_PATH . '/less/themes/' . $theme;

					if(file_exists($themepath . '/variables-custom.less')){
						if(!class_exists('JRegistryFormatLESS')){
							include_once T3_ADMIN_PATH . '/includes/format/less.php';
						}

						//default variables
						$varfile = T3_TEMPLATE_PATH . '/less/variables.less';
						if(file_exists($varfile)){
							$params->loadString(JFile::read($varfile), 'LESS');

							//get all less files in "theme" folder
							$others = JFolder::files($themepath, '.less');
							foreach($others as $other){
								//get those developer custom values
								if($other == 'variables.less'){
									$devparams = new JRegistry;
									$devparams->loadString(JFile::read($themepath . '/variables.less'), 'LESS');

									//overwrite the default variables
									foreach ($devparams->toArray() as $key => $value) {
										$params->set($key, $value);
									}
								}

								//ok, we will import it later
								if($other != 'variables-custom.less' && $other != 'variables.less'){
									$themeinfo->$other = true;
								}
							}

							//load custom variables
							if (file_exists($themepath . '/variables-custom.less')) {
								$cparams = new JRegistry;
								$cparams->loadString(JFile::read($themepath . '/variables-custom.less'), 'LESS');

								//and overwrite those defaults variables
								foreach ($cparams->toArray() as $key => $value) {
									$params->set($key, $value);
								}
							}
						}
					}
				}
			}

			$cache = array();

			// a little security
			if($user->authorise('core.manage', 'com_templates') || (isset($_SERVER['HTTP_REFERER']) && strpos($_SERVER['HTTP_REFERER'], JUri::base() . 'administrator') !== false)){
				T3::import('core/path');
				$baseurl = JUri::base();

				//should we provide a list of less path
				foreach (array(T3_TEMPLATE_PATH . '/less', T3_PATH . '/bootstrap/less', T3_PATH . '/less') as $lesspath) {
					if(is_dir($lesspath)){
						$lessfiles = JFolder::files($lesspath, '.less', true, true);
						if(is_array($lessfiles)){
							foreach ($lessfiles as $less) {
								$path            = ltrim(str_replace(array(JPATH_ROOT, '\\'), array('', '/'), $less), '/');
								$path            = T3Path::cleanPath($path);
								$fullurl         = $baseurl . preg_replace('@(\\+)|(/+)@', '/', $path);
								$cache[$fullurl] = JFile::read($less);
							}
						}
					}
				}
			}

			//workaround for bootstrap icon path
			$sparams = new JRegistry;
			if(defined('T3_BASE_RSP_IN_CLASS') && T3_BASE_RSP_IN_CLASS){
				$sparams->set('icon-font-path', '"' . JUri::base() . 'plugins/system/t3/base-bs3/bootstrap/fonts/"');
			}

			// enable development mode for less.js
			if ($devmode) {
				$jdoc->addScriptDeclaration('
					var less = window.less || {};
					less.env = \'development\';
				');
			}

			$jdoc->addScriptDeclaration('
				var T3Theme = window.T3Theme || {};
				T3Theme.vars = ' . json_encode($params->toArray()) . ';
				T3Theme.svars = ' . json_encode($sparams->toArray()) . ';
				T3Theme.others = ' . json_encode($themeinfo) . ';
				T3Theme.theme = \'' . $theme . '\';
				T3Theme.template = \'' . T3_TEMPLATE . '\';
				T3Theme.base = \'' . JURI::base() . '\';
				T3Theme.cache = ' . json_encode($cache) . ';
				if(typeof less != \'undefined\'){
					
					//we need to build one - cause the js will have unexpected behavior
					try{
						if(window.parent != window && 
							window.parent.T3Theme && 
							window.parent.T3Theme.applyLess){
							
							window.parent.T3Theme.applyLess(true);
						} else {
							less.refresh();
						}
					} catch(e){

					}
				}'
			);
		}
	}
}