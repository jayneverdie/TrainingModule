<?php 

namespace App\Controllers;

use App\Models\EvaluationModel;

class EvaluationController
{
	public function __construct()
	{
		$this->evaluation = new EvaluationModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->evaluation->all());
	}

	public function allline($request, $response, $args)
	{
		$getParams = $request->getQueryParams();
		return $response->withJson($this->evaluation->allline($getParams["id"]));
	}

	public function update($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->evaluation->update($parsedBody["name"],$parsedBody["status"],$parsedBody["comp"],$parsedBody["id"]));
	}

	public function updateline($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->evaluation->updateline($parsedBody["name"],$parsedBody["id"]));
	}

	public function create($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		if (!isset($parsedBody["inpCheck_Status"])) {
			$inpCheck_Status=0;
		}else{
			$inpCheck_Status=1;
		}
	
		return $response->withJson($this->evaluation->create($parsedBody["inpText_Name"],$parsedBody["inpSelect_Comp"],$inpCheck_Status));

	}

	public function createline($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		return $response->withJson($this->evaluation->createline($parsedBody["inpText_Nameline"],$parsedBody["inpText_Compline"],$parsedBody["inpText_IDline"]));

	}

	public function delete($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->evaluation->delete($parsedBody["id"]));

	}

	public function deleteline($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->evaluation->deleteline($parsedBody["id"]));

	}

}