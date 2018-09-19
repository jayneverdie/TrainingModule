<?php

$app->get("/", "App\Controllers\PageController:index")->add($auth);
$app->get("/home", "App\Controllers\PageController:home")->add($auth);
$app->get("/line", "App\Controllers\PageController:line")->add($auth);
$app->get("/profile", "App\Controllers\PageController:profile")->add($auth_profile);
$app->get("/usermaster", "App\Controllers\PageController:usermaster")->add($auth);
$app->get("/companymaster", "App\Controllers\PageController:companymaster")->add($auth);
$app->get("/evaluationmaster", "App\Controllers\PageController:evaluationmaster")->add($auth);
$app->get("/syncmaster", "App\Controllers\PageController:syncmaster")->add($auth);
$app->get("/user/auth", "App\Controllers\PageController:auth");
$app->get("/user/logout", "App\Controllers\UserController:logout");
$app->get("/form", "App\Controllers\PageController:form");
$app->get("/test", "App\Controllers\PageController:test");
$app->get("/test2", "App\Controllers\PageController:test2");
$app->get("/askquestions", "App\Controllers\PageController:askquestions");
$app->group("/api/v1", function() use ($app, $auth) {	
	//Create
	$app->post("/user/auths", "App\Controllers\UserController:auth");
	$app->post("/user/create", "App\Controllers\UserController:create");
	$app->post("/user/update", "App\Controllers\UserController:update");
	$app->post("/user/profile", "App\Controllers\UserController:profile");
	$app->post("/company/create", "App\Controllers\CompanyController:create");
	$app->post("/company/update", "App\Controllers\CompanyController:update");
	$app->post("/evaluation/create", "App\Controllers\EvaluationController:create");
	$app->post("/evaluation/update", "App\Controllers\EvaluationController:update");
	$app->post("/evaluation/delete", "App\Controllers\EvaluationController:delete");
	$app->post("/evaluationline/create", "App\Controllers\EvaluationController:createline");
	$app->post("/evaluationline/update", "App\Controllers\EvaluationController:updateline");
	$app->post("/evaluationline/delete", "App\Controllers\EvaluationController:deleteline");
	$app->post("/sync/data", "App\Controllers\SyncController:syncTable");
	$app->post("/trans/resend", "App\Controllers\TransController:resend");
	$app->post("/trans/insertform", "App\Controllers\TransController:insertform");
	$app->post("/trans/insertremark", "App\Controllers\TransController:insertremark");

	$app->post("/report/ask", "App\Controllers\ReportController:ask");

	$app->get("/user/load", "App\Controllers\UserController:all");
	$app->get("/company/load", "App\Controllers\CompanyController:all");
	$app->get("/evaluation/load", "App\Controllers\EvaluationController:all");
	$app->get("/evaluationline/load", "App\Controllers\EvaluationController:allline");
	$app->get("/linesync/load", "App\Controllers\SyncController:allline");

	$app->get("/trans/load", "App\Controllers\TransController:all");
	$app->get("/line/load", "App\Controllers\TransController:allline");
	
});


