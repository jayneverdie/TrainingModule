<?php 

namespace App\Controllers;

use App\Models\SyncModel;

class SyncController
{
	public function __construct()
	{
		$this->sync = new SyncModel;
	}

	public function syncTable($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		
		if ($parsedBody["id"]==1) {
			return $response->withJson($this->sync->syncTable($parsedBody["id"]));
		}else{
			return $response->withJson($this->sync->syncLine($parsedBody["id"]));
		}

	}

	public function allline($request, $response, $args)
	{
		return $response->withJson($this->sync->allline());
	}

}