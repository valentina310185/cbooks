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

// No direct access
defined('_JEXEC') or die();

/**
 * T3Path class
 */
class T3Path extends JObject
{

	/**
	 * Store current source value for updateUrl function
	 */
	protected static $srcurl = '';

	/**
	 * Get path in tpls folder. If found in template, use the path, else try in plugin t3
	 */
	public static function getPath($file, $default = '', $relative = false, $include_local = true)
	{
		if (!defined('T3_LOCAL_DISABLED') && $include_local && file_exists (T3_LOCAL_PATH . '/' . $file)) return ($relative ? T3_LOCAL_REL : T3_LOCAL_PATH) . '/' . $file;
		if (file_exists (T3_TEMPLATE_PATH . '/' . $file)) return ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_PATH) . '/' . $file;
		if (file_exists (T3_PATH . '/' . $file)) return ($relative ? T3_REL : T3_PATH) . '/' . $file;
		if ($default) return self::getPath($default);
		return '';
	}

	/**
	 * Get path in tpls folder. If found in template, use the path, else try in plugin t3
	 */
	public static function getUrl($file, $default = '', $relative = false, $include_local = true)
	{
		if (!defined('T3_LOCAL_DISABLED') && $include_local && file_exists (T3_LOCAL_PATH . '/' . $file)) return ($relative ? T3_LOCAL_REL : T3_LOCAL_URL) . '/' . $file;
		if (file_exists (T3_TEMPLATE_PATH . '/' . $file)) return ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_URL) . '/' . $file;
		if (file_exists (T3_PATH . '/' . $file)) return ($relative ? T3_REL : T3_URL) . '/' . $file;
		if ($default) return self::getUrl($default);
		return '';
	}

	/**
	 * Get path in tpls folder. If found in template, use the path, else try in plugin t3
	 */
	public static function getAllPath($file, $relative = false, $include_local = true)
	{
		$return = array();
		if (file_exists (T3_PATH . '/' . $file)) $return[] = ($relative ? T3_REL : T3_PATH) . '/' . $file;
		if (file_exists (T3_TEMPLATE_PATH . '/' . $file)) $return[] = ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_PATH) . '/' . $file;
		if (!defined('T3_LOCAL_DISABLED') && $include_local && file_exists (T3_LOCAL_PATH . '/' . $file)) $return[] = ($relative ? T3_LOCAL_REL : T3_LOCAL_PATH) . '/' . $file;
		return $return;
	}

	/**
	 * Get path in tpls folder. If found in template, use the path, else try in plugin t3
	 */
	public static function getAllUrl($file, $relative = false, $include_local = true)
	{
		$return = array();
		if (file_exists (T3_PATH . '/' . $file)) $return[] = ($relative ? T3_REL : T3_URL) . '/' . $file;
		if (file_exists (T3_TEMPLATE_PATH . '/' . $file)) $return[] = ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_URL) . '/' . $file;
		if (!defined('T3_LOCAL_DISABLED') && $include_local && file_exists (T3_LOCAL_PATH . '/' . $file)) $return[] = ($relative ? T3_LOCAL_REL : T3_LOCAL_URL) . '/' . $file;
		return $return;
	}

	/**
	 * Get local path. If const T3_LOCAL_DISABLED defined, use template path; other use local path
	 */
	public static function getLocalPath($file, $relative = false)
	{
		if (!defined('T3_LOCAL_DISABLED')) return ($relative ? T3_LOCAL_REL : T3_LOCAL_PATH) . '/' . $file;
		return ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_PATH) . '/' . $file;
	}

	/**
	 * Get local path. If const T3_LOCAL_DISABLED defined, use template path; other use local path
	 */
	public static function getLocalUrl($file, $relative = false)
	{
		if (!defined('T3_LOCAL_DISABLED')) return ($relative ? T3_LOCAL_REL : T3_LOCAL_URL) . '/' . $file;
		return ($relative ? T3_TEMPLATE_REL : T3_TEMPLATE_URL) . '/' . $file;
	}

	/**
	 * Asbjorn Grandt
	 * Clean file name paths removing redundant elements
	 */
	public static function cleanPath($path)
	{

		$dirs = explode('/', rtrim(preg_replace('#^(\./)+#', '', $path), '/'));

		$offset = 0;
		$sub = 0;
		$subOffset = 0;
		$root = '';

		if (empty($dirs[0])) {
			$root = '/';
			$dirs = array_splice($dirs, 1);
		}

		$newDirs = array();
		foreach ($dirs as $dir) {
			if ($dir !== '..') {
				$subOffset--;
				$newDirs[++$offset] = $dir;
			} else {
				$subOffset++;
				if (--$offset < 0) {
					$offset = 0;
					if ($subOffset > $sub) {
						$sub++;
					}
				}
			}
		}

		if (empty($root)) {
			$root = str_repeat('../', $sub);
		}

		return $root . implode('/', array_slice($newDirs, 0, $offset));
	}

	public static function relativePath($path1, $path2 = '')
	{
		// config params
		if ($path2 == '') {
			$path2 = $path1;
			$path1 = getcwd();
		}

		// absolute path 		//has protocol						//data protocol
		if ($path2[0] === '/' || strpos($path2, '://') !== false || strpos($path2, 'data:') === 0) {
			return $path2;
		}

		//Remove starting, ending, and double / in paths
		$path1 = trim($path1, '/');
		$path2 = trim($path2, '/');
		while (substr_count($path1, '//')) $path1 = str_replace('//', '/', $path1);
		while (substr_count($path2, '//')) $path2 = str_replace('//', '/', $path2);

		//create arrays
		$arr1 = explode('/', $path1);
		if ($arr1 == array('')) $arr1 = array();
		$arr2 = explode('/', $path2);
		if ($arr2 == array('')) $arr2 = array();
		$size1 = count($arr1);
		$size2 = count($arr2);

		//now the hard part :-p
		$path = '';
		for ($i = 0; $i < min($size1, $size2); $i++) {
			if ($arr1[$i] == $arr2[$i]) continue;
			else break;
		}
		for ($j=$i; $j<min($size1, $size2); $j++) {
			$path = '../' . $path . $arr2[$j] . '/';
		}
		if ($size1 > $size2)
			for ($i = $size2; $i < $size1; $i++)
				$path = '../' . $path;
		else if ($size2 > $size1)
			for ($i = $size1; $i < $size2; $i++)
				$path .= $arr2[$i] . '/';

		return rtrim($path, '/');
	}

	public static function updateUrl($css, $src)
	{
		self::$srcurl = rtrim($src, '/');

		$css = preg_replace_callback('/@import\\s+([\'"])(.*?)[\'"]/', array('T3Path', 'replaceurl'), $css);
		$css = preg_replace_callback('/url\\(\\s*([^\\)\\s]+)\\s*\\)/', array('T3Path', 'replaceurl'), $css);

		return $css;
	}

	public static function replaceurl($matches)
	{
		$isImport = ($matches[0][0] === '@');
		// determine URI and the quote character (if any)
		if ($isImport) {
			$quoteChar = $matches[1];
			$uri = $matches[2];
		} else {
			// $matches[1] is either quoted or not
			$quoteChar = ($matches[1][0] === "'" || $matches[1][0] === '"')
				? $matches[1][0]
				: '';
			$uri = ($quoteChar === '')
				? $matches[1]
				: substr($matches[1], 1, strlen($matches[1]) - 2);
		}

		// root-relative       protocol (non-data)             data protocol
		if ($uri[0] !== '/' && strpos($uri, '://') === false && strpos($uri, 'data:') !== 0) {
			$uri = self::cleanPath(self::$srcurl . '/' . $uri);
		}

		return $isImport
			? "@import {$quoteChar}{$uri}{$quoteChar}"
			: "url({$quoteChar}{$uri}{$quoteChar})";
	}
}