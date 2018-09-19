<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class EvaluationModel
{	
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function all()
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM EvaluationMaster"
		);
	}

	public function allline($id)
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM EvaluationLineMaster
			WHERE EvaluationNo=?",[$id]
		);
	}

	public function update($name,$status,$comp,$id)
	{	
		if ($status === 'true') {
			$status = 1;
		} else {
			$status = 0;
		}
		
			$update = sqlsrv_query(
				$this->conn->connect(),
				"UPDATE EvaluationMaster 
				SET Description = ?, Active	= ?, Company = ?
				WHERE RECID = ?",
				array(
					$name,$status,$comp,$id
				)
			);
			
			if($update){
				return true;
			}else{
				return false;
			}
	}

	public function updateline($name,$id)
	{	
			$update = sqlsrv_query(
				$this->conn->connect(),
				"UPDATE EvaluationLineMaster 
				SET Description = ?
				WHERE RECID = ?",
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

	public function updateNoactive()
	{	
			$update = sqlsrv_query(
				$this->conn->connect(),
				"UPDATE EvaluationMaster 
				SET Active = ?",
				array(
					0
				)
			);
			
			if($update){
				return true;
			}else{
				return false;
			}
	}

	public function create($inpText_Name,$inpSelect_Comp,$inpCheck_Status) 
	{	
		$updateNoactive = self::updateNoactive();
		if ($updateNoactive===true) {
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO EvaluationMaster(Description,Company,Active)
				VALUES(?,?,?)",
				array(
					$inpText_Name,$inpSelect_Comp,$inpCheck_Status
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
		}else{
			return 	[
					"result" => false,
					"message" => "Create Failed !"
				];
		}
	}

	public function createline($inpText_Nameline,$inpText_Compline,$inpText_IDline) 
	{	
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO EvaluationLineMaster(Description,Company,EvaluationNo)
				VALUES(?,?,?)",
				array(
					$inpText_Nameline,$inpText_Compline,$inpText_IDline
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

	public function delete($id) 
	{	
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"DELETE FROM EvaluationMaster WHERE RECID = ?",[$id]
			);
			if($insert){
				return 	[
					"result" => true,
					"message" => "Delete Successful !"
				];
			}else{
				return 	[
					"result" => false,
					"message" => "Delete Failed !"
				];
			}

	}

	public function deleteline($id) 
	{	
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"DELETE FROM EvaluationLineMaster WHERE RECID = ?",[$id]
			);
			if($insert){
				return 	[
					"result" => true,
					"message" => "Delete Successful !"
				];
			}else{
				return 	[
					"result" => false,
					"message" => "Delete Failed !"
				];
			}

	}

}