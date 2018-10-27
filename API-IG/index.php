<?php
// Coded by Suhada
// ZeroByte.ID
// API Instgram Photos Downloader 
if( isset($_GET['username']) )
{
  $userigu = $_GET['username'];
  $uRLuser = "https://www.instagram.com/".$_GET['username']."/";
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36");
  curl_setopt($ch, CURLOPT_URL, $uRLuser);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

  $result = curl_exec($ch);
  if (curl_errno($ch)) {
      echo 'Error:' . curl_error($ch);
  }
  $uNoTf = '/Page Not Found &bull; Instagram/';
  $uaP = '/is_private":true/';
  if (preg_match($uNoTf, $result)) {
    echo "g";
  }elseif (preg_match($uaP, $result)) {
    echo "Account Private";
  }else{
    header('Content-type: text/xml');
    ob_start();
    echo '<?xml version="1.0"?'.'>'."\n";
    echo "
      <userIG>";
    $getP = '#(?<="display_url":")[^",]*#';
    preg_match_all($getP, $result, $matches);
    $x = 1;
    $y = 1;
    foreach($matches[0] as $link)
    {
      //echo $x++;
      echo "
      <PiG".$x++.">{$link}</PiG".$y++.">";
      //echo $link;
    }
    echo "</userIG>";
    
  }
  curl_close ($ch);
}
else{
  echo "<br /><center><h2>Please, don't steal me</h2><img src='https://images-cdn.9gag.com/photo/a0Kz00O_700b.jpg' style='width:20%;'><br />sUHada@ZeroByte.ID</center>";
}
?>