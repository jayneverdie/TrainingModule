<?php 

namespace App\Controllers;

use Wattanar\Sqlsrv;

class ConnectionController
{
	public static function connect()
	{
		$server = "192.168.90.30\develop";
		//$server = "SVO-LT-ICT-005";
		$user = "sa";
		$password = "c,]'4^j";
		$database = "TrainingModuleV2";

		return Sqlsrv::connect(
			$server, 
			$user,
			$password,
			$database
		);
	}

	public static function connectext()
	{
		$server = "axcust\develop";
		$user = "sa";
		$password = "c,]'4^j";
		$database = "axcust";

		return Sqlsrv::connect(
			$server, 
			$user,
			$password,
			$database
		);
	}

	public static function convertforin($str)
	{
		$strploblem = "";
        $a =explode(',', $str);
        foreach ($a as $value) {
            if($strploblem===""){
                $strploblem.=$value;
            }else{
                $strploblem.=",".$value;
            }
        }
        return $strploblem;
	}
}