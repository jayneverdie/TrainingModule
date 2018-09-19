<?php 

namespace App\Controllers;

use App\Models\TransModel;

class TransController
{
	public function __construct()
	{
		$this->trans = new TransModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->trans->all());
	}
	
	public function allline($request, $response, $args)
	{
		$code = $request->getQueryParams();
		return $response->withJson($this->trans->allline($code["code"]));
	}

	public function resend($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->trans->resend($parsedBody["trainingcode"],$parsedBody["course"]));
	}

	public function insertform($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		$score = $parsedBody["score"];
		// print_r($score);
		// exit();
		return $response->withJson($this->trans->insertform($parsedBody["score"],$parsedBody["line"],$parsedBody["no"]));

	}

	public function insertremark($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		return $response->withJson($this->trans->insertremark($parsedBody["remark"],$parsedBody["heademail"],$parsedBody["training_code"]));

	}
}