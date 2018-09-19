<?php 

namespace App\Controllers;

use App\Models\DepartmentModel;

class DepartmentController
{
	public function __construct()
	{
		$this->department = new DepartmentModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->department->all());
	}
}