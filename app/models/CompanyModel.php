<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class CompanyModel
{	
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function all()
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM CompanyMaster"
		);
	}

	public function update($name,$id)
	{	
			$update = sqlsrv_query(
				$this->conn->connect(),
				"UPDATE CompanyMaster 
				SET Description = ?
				WHERE CompanyID = ?",
				array(
					$name,$id
				)
			);
			
			if($update){
				return true;
			}else{
				return false;
			}
	}

	public function create($inpText_Name,$inpText_Comp) 
	{	
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO CompanyMaster(Description,CompanyID)
				VALUES(?,?)",
				array(
					$inpText_Name,$inpText_Comp
				)
			);
			if($insert){
				return 	[
					"result" => true,
					"message" => "Create Successful !"
				];
			}else{
				return 	[
					"result" => false,
					"message" => "Create Failed !"
				];
			}

	}
}