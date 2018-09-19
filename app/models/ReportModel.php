<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class ReportModel
{	
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function line($askreport)
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT L.TrainingCode,L.Employee,l.Title,L.EmployeeName,L.Alias,L.Company,L.DepartmentName,L.DivisionName,L.PositionName,T.CourseDescription,T.StartDate,T.ArrangedBy,
			(SELECT TOP 1 Description FROM EvaluationMaster WHERE Active=1 )[Evaform],R.Remark,L.HeadName,C.Description[CompanyName],L.UpdateDate
			FROM  EvaluationTableLine L
			LEFT JOIN EvaluationTable T ON L.TrainingCode=T.TrainingCode
			LEFT JOIN EvaluationTransRemark R ON L.Employee=R.EmployeeCode
			LEFT JOIN CompanyMaster C ON L.Company=C.CompanyID
			WHERE L.HeadEmail!=''
			AND L.RECID IN ($askreport)"
		);
	}

	public function master()
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			// "SELECT L.EvaluationNo,LM.Description,L.RECID,L.Description[LineDescription],L.Company 
			// FROM EvaluationLineMaster L
			// LEFT JOIN  EvaluationMaster LM ON L.EvaluationNo = LM.RECID
		 //  	WHERE LM.Active=1"
			"SELECT L.EvaluationNo,LM.Description,L.RECID,L.Description,L.Company,T.EmployeeCode,T.Rate 
			FROM EvaluationLineMaster L
			LEFT JOIN EvaluationMaster LM ON L.EvaluationNo = LM.RECID
			LEFT JOIN EvaluationTrans T ON L.RECID=T.EvaluationLineNo
		  	WHERE LM.Active=1"
		);
	}

	public function score($empreport)
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM EvaluationTrans 
			WHERE EmployeeCode IN ($empreport)"
		);
	}

}