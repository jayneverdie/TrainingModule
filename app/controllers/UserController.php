<?php 

namespace App\Controllers;

use App\Models\UserModel;

class UserController
{
	public function __construct()
	{
		$this->user = new UserModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->user->all());
	}

	public function create($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		if (!isset($parsedBody["inpCheck_Status"])) {
			$inpCheck_Status=0;
		}else{
			$inpCheck_Status=1;
		}
		// print_r($parsedBody);
		// exit;
		return $response->withJson($this->user->create($parsedBody["inpText_Email"],$parsedBody["inpText_Password"],$parsedBody["inpText_Name"],$parsedBody["inpSelect_Comp"],$inpCheck_Status,$parsedBody["inpText_HeadEmail"]));

	}

	public function update($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->user->update($parsedBody["pass"],$parsedBody["name"],$parsedBody["status"],$parsedBody["comp"],$parsedBody["headmail"],$parsedBody["id"]));
	}

	public function auth($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		try {
			$isRealUser = $this->user->isRealUser($parsedBody["email"],$parsedBody["password"]);
		} catch (Exception $e) {
			return $response->withJson([
				"result" => false, 
				"message" => $e->getMessage()
			]);
		}
		
		if ($isRealUser === false) {
			return $response->withJson([
				"result" => false, 
				"message" => "กรุณาเช็คชื่อผู้ใช้ และรหัสผ่าน"
			]);
		}

		try {
			$getUserInfo = $this->user->userInfo($parsedBody["email"],$parsedBody["password"]);
		} catch (Exception $e) {
			return $response->withJson([
				"result" => false, 
				"message" => $e->getMessage()
			]);
		}
		
		$_SESSION["logged"] 	= true;
		$_SESSION["user_id"] 	= $getUserInfo[0]->RECID;
		$_SESSION["company"] 	= $getUserInfo[0]->Company;
		$_SESSION["email"] 		= $getUserInfo[0]->Email;
		$_SESSION["heademail"] 	= $getUserInfo[0]->HeadEmail;
		$_SESSION["password"] 	= $getUserInfo[0]->Password;
		$_SESSION["name"] 		= $getUserInfo[0]->Name;
		$_SESSION["status"] 	= $getUserInfo[0]->Status;
		$_SESSION["reset"] 		= $getUserInfo[0]->ResetPassword;
		
		return $response->withJson([
			"result" => true,
			"reset" => $_SESSION["reset"]
		]);
	}

	public function profile($request, $response, $args){
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->user->isChangPass($parsedBody["confirmpassword"],$parsedBody["iduser"]));
	}

	public function logout($request, $response, $args)
	{
		session_destroy();
		return $response->withRedirect("/user/auth");
	}
}