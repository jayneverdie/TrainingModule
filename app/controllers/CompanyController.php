<?php 

namespace App\Controllers;

use App\Models\CompanyModel;

class CompanyController
{
	public function __construct()
	{
		$this->company = new CompanyModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->company->all());
	}

	public function update($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		return $response->withJson($this->company->update($parsedBody["name"],$parsedBody["id"]));
	}

	public function create($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		if (!isset($parsedBody["inpCheck_Status"])) {
			$inpCheck_Status=0;
		}else{
			$inpCheck_Status=1;
		}
	
		return $response->withJson($this->company->create($parsedBody["inpText_Name"],$parsedBody["inpText_Comp"]));

	}

}