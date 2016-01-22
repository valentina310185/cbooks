<?php

class Security
{
	//Edit the key for your application
	private static function Key()
	{
		return 'AD35B93A62C9ABA93C168137439A2';
	}
	
	private static function KeyHash()
	{
		return md5(self::key());
	}
	
	public static function EncryptText($string)
	{
		return trim(base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5(self::Key()), $string, MCRYPT_MODE_CBC, self::KeyHash())));
	}
	
	public static function DecrypText($string)
	{
		return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5(self::Key()), base64_decode($string), MCRYPT_MODE_CBC, self::KeyHash()));
	}
	
	public static function EncryptUrl($string)
	{
		return trim(urlencode(base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5(self::Key()), $string, MCRYPT_MODE_CBC, self::KeyHash()))));
	}
	
	public static function DecrypUrl($string)
	{
		return trim(urldecode(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5(self::Key()), base64_decode($string), MCRYPT_MODE_CBC, self::KeyHash())));
	}
}

?>