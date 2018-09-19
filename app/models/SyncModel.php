<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class SyncModel
{	
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function syncTable($id) 
	{	
			$sync = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO EvaluationTable(TrainingCode, CourseDescription, StartDate, EndDate, ArrangedBy, Status, CreateDateTime)
				SELECT T.DSG_TrainingCode,T.DSG_CourseDescription,T.DSG_StartDate,T.DSG_EndDate,T.DSG_ArrangedBy,1,getdate()
				FROM [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_TrainingTable] T
				WHERE T.DSG_FOLLOWUP=1 
				AND T.DSG_TrainingCode NOT IN 
							(
								SELECT TrainingModuleV2.dbo.EvaluationTable.TrainingCode FROM TrainingModuleV2.dbo.EvaluationTable
							)"
			);
			if($sync){
				return 	[
					"result" => true,
					"message" => "Sync Successful !"
				];
			}else{
				return 	[
					"result" => false,
					"message" => "Sync Failed !"
				];
			}

	}

	public function syncLine($id) 
	{	
			$sync = sqlsrv_query(
				$this->conn->connect(),
				"INSERT INTO EvaluationTableLine(TrainingCode, Employee, Title, EmployeeName, Alias, Company, PositionName, DivisionName, DepartmentName, HeadName, HeadEmail, Status)
				SELECT  T.DSG_TrainingCode,
						E.DSG_EmplId,
						E.DSG_Title,
						E.DSG_EmplName,
						E.DSG_EmplAlias,
						E.DSG_COMPANY,
						P.DSG_DESCRIPTION[POSITION],
						D.DSG_DESCRIPTION[DIVISION],
						DM.DSG_DESCRIPTION[DEPARTMENT],
						M.TITLE+M.NAME+' '+M.ALIAS[HEADNAME],
						M.EMAIL,
						1
				FROM [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_TrainingTable] T
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_Taininglog] L ON T.DSG_TRAININGCODE = L.DSG_TRAININGCODE AND T.DATAAREAID = L.DATAAREAID
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_TraineeTrans] E ON T.DSG_TRAININGCODE = E.DSG_TRAININGCODE
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_PositionTable] P ON E.DSG_POSITIONCODE = P.DSG_POSITIONCODE
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_DIVISIONTABLE] D ON E.DSG_DIVISIONCODE = D.DSG_DIVISIONCODE AND E.DATAAREAID = D.DATAAREAID
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[DSG_DepartmentTable] DM ON E.DSG_DEPARTMENTCODE = DM.DSG_DEPARTMENTCODE AND E.DATAAREAID = DM.DATAAREAID
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[EmplTable] EM ON E.DSG_EMPLID = EM.EMPLID AND E.DATAAREAID = EM.DATAAREAID
				LEFT JOIN [PENTOS\DEVELOP].[AX_Customize].[dbo].[EmplTable] M ON EM.DSG_EMPLID = M.EMPLID AND E.DATAAREAID = M.DATAAREAID
				WHERE T.DSG_FOLLOWUP=1
				 AND L.DSG_FollowDate <= GETDATE()
				 AND L.DSG_SENDEMAIL=1
				 AND T.DSG_TrainingCode NOT IN 
							(
								SELECT TrainingModuleV2.dbo.EvaluationTableLine.TrainingCode FROM TrainingModuleV2.dbo.EvaluationTableLine
							)
				AND E.DSG_EmplId NOT IN 
							(
								SELECT TrainingModuleV2.dbo.EvaluationTableLine.Employee FROM TrainingModuleV2.dbo.EvaluationTableLine
							)
				ORDER BY T.DSG_TRAININGCODE ASC"
			);
			if($sync){
				return 	[
					"result" => true,
					"message" => "Sync Successful !"
				];
			}else{
				return 	[
					"result" => false,
					"message" => "Sync Failed !"
				];
			}

	}

	public function allline()
  	{
        return Sqlsrv::array(
              $this->conn->connect(),
              "SELECT L.RECID
                    ,L.TrainingCode
                    ,L.Employee
                    ,L.Title
                    ,L.EmployeeName
                    ,L.Alias
                    ,L.Company
                    ,L.PositionName
                    ,L.DivisionName
                    ,L.DepartmentName
                    ,L.HeadName
                    ,L.HeadEmail
                    ,L.Status
                    ,S.Description[StatusName]
                    ,L.UpdateDate
                    ,L.UpdateBy
              FROM EvaluationTableLine L
              LEFT JOIN StatusMaster S ON L.Status=S.StatusID
              ORDER BY L.TrainingCode ASC"
        );
  	}

}