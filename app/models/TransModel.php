<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class TransModel
{	
    	public function __construct()
    	{
    		$this->conn = new ConnectionController;
    	}

    	public function all()
    	{
    		return Sqlsrv::array(
    			$this->conn->connect(),
    			"SELECT T.RECID
                            ,T.TrainingCode
                            ,T.CourseDescription
                            ,T.StartDate
                            ,T.EndDate
                            ,T.ArrangedBy
                            ,T.Status
                            ,S.Description
                            ,T.CreateDateTime
                            ,T.UpdateDate
                            ,T.UpdateBy
                      FROM EvaluationTable T
                      LEFT JOIN StatusMaster S ON T.Status = S.StatusID"
    		);
    	}

      public function allline($code)
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
                  WHERE L.TrainingCode = ?
                  ORDER BY L.TrainingCode ASC",[$code]
            );
      }
      
      public function getMailLine($trainingcode)
      {
            return Sqlsrv::array(
                  $this->conn->connect(),
                  "SELECT L.HeadEmail
                  FROM  EvaluationTableLine L
                  WHERE L.HeadEmail!=''
                  AND L.TrainingCode=?
                  AND L.Status!=?
                  GROUP BY L.HeadEmail",[$trainingcode,4]
            ); 
      }

      public function getDataLine($trainingcode,$getEmail)
      {
            return Sqlsrv::array(
                  $this->conn->connect(),
                  "SELECT *
                  FROM  EvaluationTableLine L
                  WHERE L.HeadEmail!=''
                  AND L.TrainingCode=?
                  AND L.HeadEmail=?
                  AND L.Status!=?",[$trainingcode,$getEmail,4]
            ); 
      }      

      public function getSubjectMailLine($course)
      {
        return 'แบบสอบถามและติดตามผลหลังการฝึกอบรม ชื่อหลักสูตร '.$course;
      }

      public function getBodyMailLine($course,$listData,$trainingcode,$email)
      {
        $txt  = '';
        $txt .= 'เรียนผู้จัดการฝ่าย <br><br>';
        $txt .= 'แบบสอบถามและติดตามผลหลังการฝึกอบรม ชื่อหลักสูตร <i>'.$course.'</i><br>';
        $txt .= 'มีพนักงานที่ต้องติดตามผลดังนี้';
        $txt .= '<table cellpadding=10px border=1 style="border-collapse:collapse;">
        <tr bgcolor="#9966CC">
        <td>Employee</td>
        <td>Title</td>
        <td>Employee name</td>
        <td>Alias</td>
        <td>Company</td>
        <td>PositionName</td>
        </tr>';
        foreach($listData as $value) {
          $txt .= '<tr><td>' . $value->Employee . '</td><td>' . 
          $value->Title . '</td><td>' . 
          $value->EmployeeName . '</td><td>' . 
          $value->Alias . '</td><td>' . 
          $value->Company . '</td><td>' . 
          $value->PositionName . '</td></tr>';
        }
        $txt .= '</table>';
        $txt .= '<br><br><b>แบบประเมิน : </b>'."<a href='http://192.168.21.166:4002/form?no=$trainingcode&email=$email'>เลือกที่นี่</a>";       
        return $txt;
      }

      public function updateStatusTable($status,$email,$trainingcode)
      { 
          if ($status==4) {
            $sql = Sqlsrv::array(
                $this->conn->connect(),
                "SELECT Status
                FROM  EvaluationTableLine
                GROUP BY Status"
            );
            $numrows = count($sql);
            
            if ($numrows==1) {
                $status=4;
            }else{
                $status=3;
            }
            
            $update = sqlsrv_query(
                $this->conn->connect(),
                "UPDATE EvaluationTable 
                SET Status = ?,
                UpdateBy = ?,
                UpdateDate = getdate()
                WHERE TrainingCode = ?",
                array(
                  $status,$email,$trainingcode
                )
            );

          }else{
            $update = sqlsrv_query(
                $this->conn->connect(),
                "UPDATE EvaluationTable 
                SET Status = ?,
                UpdateBy = ?,
                UpdateDate = getdate()
                WHERE TrainingCode = ?",
                array(
                  $status,$_SESSION["email"],$trainingcode
                )
            ); 
          }

          if($update){
            return true;
          }else{
            return false;
          }
      }

      public function updateStatusTableLine($status,$email,$trainingcode)
      {
        if ($status!=4) {
          $updateby = $_SESSION["email"];
        }else{
          $updateby = $email;
        }
        
        $update = sqlsrv_query(
            $this->conn->connect(),
            "UPDATE EvaluationTableLine 
            SET Status = ?,
            UpdateBy = ?,
            UpdateDate = getdate()
            WHERE HeadEmail = ? AND TrainingCode = ?",
            array(
              $status,$updateby,$email,$trainingcode
            )
        );  
          if($update){
            return true;
          }else{
            return false;
          }
      }

      public function resend($trainingcode,$course)
      {
          $countRows    = self::getMailLine($trainingcode);
          if (count($countRows) == 0) {
            return ['result' => false, 'message' => 'Data Not Exists.'];
            exit;
          }
          
          $listMail     = self::getMailLine($trainingcode);
          $sender_mail  = $_SESSION["heademail"];

          foreach ($listMail as $value) {
              $email        = $value->HeadEmail;
              $listData     = self::getDataLine($trainingcode,$email);
              $SubjectMail  = self::getSubjectMailLine($course);
              $BodyMail     = self::getBodyMailLine($course,$listData,$trainingcode,$email);
             
              $mail     = new \PHPMailer;
              $mail->isSMTP();
              $mail->Host = "idc.deestone.com";
              $mail->SMTPAuth = true;
              $mail->SMTPSecure = "ssl";
              $mail->Username = "ea_webmaster@deestone.com";
              $mail->Password = "c,]'4^j";
              $mail->CharSet = "utf-8";
              $mail->Port = 465;
              $mail->From = $sender_mail;
              $mail->FromName = $sender_mail;
              $mail->addAddress($email);
              $mail->isHTML(true);
              $mail->Subject = $SubjectMail;
              $mail->Body = $BodyMail;

              if($mail->send()) {
                $sendsuccess = 1;
                $update_status    = self::updateStatusTable(2,$email,$trainingcode);
                $update_line      = self::updateStatusTableLine(2,$email,$trainingcode);
              }else{
                $sendsuccess = $mail->ErrorInfo;
              }
          }

          if($sendsuccess==1) {
            return ['result' => true, 'message' => 'Send Success.'];
          }else{
            return ['result' => false, 'message' => $sendsuccess];
          }
          
      }

      public function sendMail()
      {
        $testMail = ['harit_j@deestone.com','jeamjit_p@deestone.com'];
        $sender_mail = 'ea_webmaster@deestone.com';

        foreach ($testMail as $customerMailTo) {
          
          $mail   = new \PHPMailer;
          $mail->isSMTP();
          $mail->Host = "idc.deestone.com";
          $mail->SMTPAuth = true;
          $mail->SMTPSecure = "ssl";
          $mail->Username = "ea_webmaster@deestone.com";
          $mail->Password = "c,]'4^j";
          $mail->CharSet = "utf-8";
          $mail->Port = 465;
          $mail->From = $sender_mail;
          $mail->FromName = $sender_mail;

          // if (count($mailTo) > 0) {
          //   foreach ($mailTo as $customerMailTo) {
          $mail->addAddress($customerMailTo);
          //   }
          // } else {
          //   return ['result' => false, 'message' => 'No recipients mail.'];
          // }

          $mail->isHTML(true);
          $mail->Subject = "TEST TRAINING";
          $mail->Body = "TEST TRAINING";

          if($mail->send()) {
            echo  "Send";
          }else{
            echo $mail->ErrorInfo;
          }

        }
        
      }

      public function insertform($score=[],$line,$no) 
      { 
        foreach ($score as $value) {
          $employees  = $value;
          $employee   = explode("_", $employees);
          $code       = $employee[1]."_".$employee[0];
          $insert = sqlsrv_query(
            $this->conn->connect(),
            "INSERT INTO EvaluationTrans(TransID,EvaluationNo,EvaluationLineNo,TrainingCode,EmployeeCode,Rate)
            VALUES(?,?,?,?,?,?)",
            array(
              $code,$no,$line,$employee[1],$employee[0],$employee[2]
            )
          );
        }

        if($insert){
          return  [
            "result" => true,
            "message" => "Create Successful !"
          ];
        }else{
          return  [
            "result" => false,
            "message" => "Create Failed !"
          ];
        }

      }

      public function insertremark($remark=[],$heademail,$training_code) 
      { 
        foreach ($remark as $value) {
          $remarks  = $value;
          $remark   = explode("_", $remarks);
          // $code       = $employee[1]."_".$employee[0];
          $insert = sqlsrv_query(
            $this->conn->connect(),
            "INSERT INTO EvaluationTransRemark(EmployeeCode,TrainingCode,Remark)
            VALUES(?,?,?)",
            array(
              $remark[0],$remark[1],$remark[2]
            )
          );
        }

        $update_line      = self::updateStatusTableLine(4,$heademail,$training_code);
        $update_table     = self::updateStatusTable(4,$heademail,$training_code);

        if($insert){
          return  [
            "result" => true,
            "message" => "ดำเนินการเสร็จสิ้น"
          ];
        }else{
          return  [
            "result" => false,
            "message" => "ดำเนินการล้มเหลว"
          ];
        }

      }
}