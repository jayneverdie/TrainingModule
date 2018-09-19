<?php
// Application middleware

// e.g: $app->add(new \Slim\Csrf\Guard);
$auth = function ($request, $response, $next) {
  if (isset($_SESSION["logged"]) && $_SESSION["logged"] === true && $_SESSION["reset"] ===1) {
  	$response = $next($request, $response);
  } else {
  	return $response->withRedirect("/user/auth");
  }
  return $response;
};

$auth_profile = function ($request, $response, $next) {
	if (isset($_SESSION["logged"]) && $_SESSION["logged"] === true && $_SESSION["reset"] ===0){
  		// return $response->withRedirect("/profile");
  		$response = $next($request, $response);
  	} else {
	  	return $response->withRedirect("/user/auth");
	}
	  return $response;
};