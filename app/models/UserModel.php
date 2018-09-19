<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class UserModel
{	
	protected $mailer;
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function all()
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT U.RECID
			      ,U.Email
			      ,U.Password
			      ,U.Name
			      ,U.Company
			      ,U.Status
			      ,U.ResetPassword
			      ,C.Description
			      ,U.HeadEmail
		    FROM UserMaster U
		    LEFT JOIN CompanyMaster C ON U.Company=C.CompanyID"
		);
	}

	public function create($inpText_Email,$inpText_Password,$inpText_Name,$inpSelect_Comp,$inpCheck_Status,$inpText_HeadEmail) 
	{	
			$insert = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO UserMaster(Email,Password,Name,Company,Status,ResetPassword,HeadEmail)
				VALUES(?,?,?,?,?,?,?)",
				array(
					$inpText_Email,$inpText_Password,$inpText_Name,$inpSelect_Comp,$inpCheck_Status,0,$inpText_HeadEmail
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

	public function update($pass,$name,$status,$comp,$headmail,$id)
	{	
		if ($status === 'true') {
			$status = 1;
		} else {
			$status = 0;
		}

			$update = sqlsrv_query(
				$this->conn->connect(),
				"UPDATE UserMaster 
				SET Password = ?,
				Name 	= ?,
				Status 	= ?,
				Company = ?,
				HeadEmail = ?
				WHERE RECID = ?",
				array(
					$pass,$name,$status,$comp,$headmail,$id
				)
			);
			
			if($update){
				return true;
			}else{
				return false;
			}
	}

	public function isRealUser($email,$password)
	{	
		return Sqlsrv::hasRows(
			$this->conn->connect(),
			"SELECT * FROM UserMaster
			WHERE Email = ?
			AND Password = ?
			AND Status = ?",
			[
				$email, 
				$password,
				1
			]
		);
	}

	public function userInfo($email,$password)
	{
		$user =  Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM UserMaster
			WHERE Email = ?",
			[
				$email
			]
		);

		return $user;
	}

	public function isChangPass($confirmpassword,$iduser)
	{	
		$update = sqlsrv_query(
								$this->conn->connect(),
								"UPDATE UserMaster 
								SET Password = ?, ResetPassword = ?
								WHERE RECID = ?",
								array(
									$confirmpassword,1,$iduser
								)
						);
		
		if($update)
		{	
			$_SESSION["reset"] = 1;

			$arr = Sqlsrv::array($this->conn->connect(),
					"SELECT TOP 1 * FROM UserMaster WHERE RECID=? ",
					[$iduser]
			);
			$json_decode  = $arr;
			$_SESSION["password"] = $json_decode[0]->Password;
			
			return 	[
					"result" => true,
					"message" => "ChangePassword Successful !"
			];
		}else{
			return 	[
					"result" => true,
					"message" => "ChangePassword Failed !"
			];
		}
	}

}