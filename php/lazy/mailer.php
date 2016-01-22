<?php
//This class is not fully implemented yet
abstract class Mailer
{
	static protected function SendMail($from, $to, $subject, $message, $Cc = null, $Bcc = null) 
	{
		$headers = 'Content-type:text/html;charset=utf-8' . "\r\n";
		$headers .= 'MIME-Version: 1.0' . "\r\n";
		$headers .= 'From: ' . $from . "\r\n";
		if($Cc !== null)
			$headers .= 'Cc: ' .  $Cc . "\r\n";
		if($Bcc !== null)
			$headers .= 'Bcc: ' . $Bcc . "\r\n";
		return mail($to, '=?UTF-8?B?'.base64_encode($subject).'?=', $message, $headers);	
	}
	
	static protected function SendSMS($from, $to, $subject, $message, $Cc = null, $Bcc = null) 
	{
		$headers = 'Content-type:text/html;charset=utf-8' . "\r\n";
		$headers .= 'MIME-Version: 1.0' . "\r\n";
		$headers .= 'From: ' . $from . "\r\n";
		if($Cc !== null)
			$headers .= 'Cc: ' .  $Cc . "\r\n";
		if($Bcc !== null)
			$headers .= 'Bcc: ' . $Bcc . "\r\n";
		return mail($to, '=?UTF-8?B?'.base64_encode($subject).'?=', $message, $headers);	
	}
}
/*
function mailer_send_mail($to, $subject, $body)
{
$mail = new PHPMailer;
$mail->isSMTP();
$mail->Host = 'smtp.gmail.com';
$mail->Port = 465; 
$mail->SMTPAuth = true;                               
$mail->Username = 'anthony.revocodez@gmail.com';                
$mail->Password = 'elgueta#123';                          
$mail->SMTPSecure = 'ssl';                          
$mail->From = 'anthony.revocodez@gmail.com';
$mail->FromName = 'CBooks Mailer';
//$mail->addAddress('joe@example.net', 'Joe User');
$mail->addAddress($to);      
//$mail->addReplyTo('info@example.com', 'Information');
//$mail->addCC('cc@example.com');
//$mail->addBCC('bcc@example.com');
$mail->WordWrap = 50;                               
//$mail->addAttachment('/var/tmp/file.tar.gz');
//$mail->addAttachment('/tmp/image.jpg', 'new.jpg');   
$mail->isHTML(true);                                
$mail->Subject = $subject;
$mail->Body    = $body;
//$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
return $mail->send();
}*/

/*
function send_easy_smtp($send_to, $subject, $body)
{
	require_once 'swift/lib/swift_required.php'; 					
	$sent_from = array('mailer@cbooks.com' => 'CBooks Mailer');
	$transport = Swift_SmtpTransport::newInstance()
		->setHost('ssrs.reachmail.net')
		->setPort(465)
		->setUsername('REVOCODE\\admin')
		->setPassword('1c#bY343')
		->setEncryption('ssl') 
		;
	$mailer = Swift_Mailer::newInstance($transport);
	$message = Swift_Message::newInstance()
		->setSubject($subject)
		->setContentType('text/html') 
		->setFrom($sent_from)
		->setTo($send_to)
		->setBody($body)
		;
	$headers = $message->getHeaders();  
	return ($mailer->send($message) > 0);
}

function send_easy_sms($phone, $body)
{
	require_once 'swift/lib/swift_required.php'; 					
	$sent_from = array('mailer@cbooks.com' => 'CBooks Mailer');
	$transport = Swift_SmtpTransport::newInstance()
		->setHost('ssrs.reachmail.net')
		->setPort(465)
		->setUsername('REVOCODE\\admin')
		->setPassword('1c#bY343')
		->setEncryption('ssl') 
		;
	$mailer = Swift_Mailer::newInstance($transport);
	$message = Swift_Message::newInstance()
		->setContentType('text/plain') 
		->setFrom($sent_from)
		->setBody($body)
		;
	$headers = $message->getHeaders();  
	return ($mailer->send($message) > 0);
}*/

?> 