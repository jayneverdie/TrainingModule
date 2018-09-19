<?php  
require '../vendor/autoload.php'; 
function DateThai($strDate)
{
    $strYear = date("Y",strtotime($strDate))+543;
    $strMonth= date("n",strtotime($strDate));
    $strDay= date("j",strtotime($strDate));
    $strMonthCut = Array("","มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม");
    $strMonthThai=$strMonthCut[$strMonth];
    return "$strDay $strMonthThai $strYear";
}

$pdf = ob_get_clean();
$pdf = new mPDF('th','A4-L', 0, 5, 5, 5, 5);  
$pdf->SetTitle('แบบสอบถาม​และ​ติดตาม​ผล​หลัง​การ​ฝึก​อบ​รม');

$css = '<html><head>
        <style type="text/css">
            table {
                border-collapse: collapse;
                width: 100%;
                text-align: center;
                font-family: THSarabun;
            }
            td, tr, th {
                border: 1px solid #000000;
                text-align: center;
                padding: 2px;
                font-size: 15pt;
                font-family: THSarabun;
            }
        </style>
        </head></html>';
$classcss = '<html><head>
        <style type="text/css">
            .td, .tr, .th {
                border-collapse: collapse;
                text-align: center;
                padding: 2px;
                font-size: 12pt;
                font-family: THSarabun;
            }
        </style>
        </head></html>';

    $pdf->WriteHTML($css);
    $pdf->WriteHTML($classcss);
        $i=1;
        $numrows = count($data_name);
        foreach ($data_name as $n) {
            
            $pdf->WriteHTML("<table width=100%>
            <thead>
            <tr>
                <td width='30%'>
                    <a>
                    <img src='/resources/DN2.png' 
                    style='padding-left:10px;height:20px; width:auto;'/></a> 
                </td>
                <td colspan='6'>
                    <h2>แบบสอบถามและติดตามผลหลังการฝึกอบรม<br>
                    ".$n->CompanyName."</h2>
                </td>
            </tr>
            <tr>
                <td colspan='7' align='left'>
                    <b><u>คำชี้แจง</u></b>
                    โปรดอ่านข้อความในแต่ละข้อและทำเครื่องหมาย   
                    <img  src='/resources/true.png'
                    style='height:15px; width:15px;' />ลงในช่องที่ตรงกับความคิดเห็นของท่านมากที่สุดเพียงช่องเดียวเท่านั้น<br>
                    แบบสอบถามนี้มีวัตถุประสงค์เพื่อเป็นข้อมูลในการติดตามผลการฝึกอบรม  ข้อมูลที่ได้รับจากแบบสอบถามในครั้งนี้จะนำเสนอในภาพรวม และจะไม่มีผลกระทบใดๆ ต่อการปฏิบัติงาน
                </td>
            </tr>
            </thead>
            <tr>
                <td colspan='7' align='left'><b style='text-decoration: underline;'>
                ส่วนที่ 1 ข้อมูลทั่วไปของผู้ใต้บังคับบัญชา</b><br>
                ชื่อ-นามสกุล   &nbsp;&nbsp;&nbsp;".$n->Title.$n->EmployeeName."
                                &nbsp;&nbsp;&nbsp;".$n->Alias."
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ตำแหน่ง       &nbsp;&nbsp;&nbsp;".$n->PositionName."
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                แผนก           &nbsp;&nbsp;&nbsp;".$n->DepartmentName."
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ฝ่าย            &nbsp;&nbsp;&nbsp;".$n->DivisionName."<br>
                ชื่อหลักสูตร   &nbsp;&nbsp;&nbsp;".$n->CourseDescription."
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                วันที่ฝึกอบรม  &nbsp;&nbsp;&nbsp;".DateThai($n->StartDate)."
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                จัดโดย          &nbsp;&nbsp;&nbsp;".$n->ArrangedBy."</td>
            </tr>
            <tr>
                <td colspan='7' align='left'><b style='text-decoration: underline;'>ส่วนที่ 2 ประเมินผลหลังการฝึกอบรม</b></td>
            </tr>
            <tr>
                <td colspan='2' rowspan='2'>".$n->Evaform."</td>
                <td colspan='5'>ประเมินความรู้ / ทักษะในการปฎิบัติงาน</td>
            </tr>
            <tr>
                <td width='10%' class=td>ดีมาก (5)</td>
                <td width='10%' class=td>ดี (4)</td>
                <td width='10%' class=td>ปานกลาง (3)</td>
                <td width='10%' class=td>ค่อนข้างน้อย (2)</td>
                <td width='10%' class=td>น้อย (1)</td>
            </tr>
            ");
            $y=1;
            foreach ($data_master as $m) {
                if($n->Employee==$m->EmployeeCode){
                    $pdf->WriteHTML("<tr>
                        <td colspan='2' align='left'>".$y.'. '.$m->Description."</td>
                    ");
                    if ($m->Rate==5) {
                        $pdf->WriteHTML("<td><img  src='/resources/true.png' style='height:13; width:13;' /></td>
                        ");
                    }else{
                        $pdf->WriteHTML("<td></td>");
                    }
                    if ($m->Rate==4) {
                        $pdf->WriteHTML("<td><img  src='/resources/true.png' style='height:13; width:13;' /></td>
                        ");
                    }else{
                        $pdf->WriteHTML("<td></td>");
                    }
                    if ($m->Rate==3) {
                        $pdf->WriteHTML("<td><img  src='/resources/true.png' style='height:13; width:13;' /></td>
                        ");
                    }else{
                        $pdf->WriteHTML("<td></td>");
                    }
                    if ($m->Rate==2) {
                        $pdf->WriteHTML("<td><img  src='/resources/true.png' style='height:13; width:13;' /></td>
                        ");
                    }else{
                        $pdf->WriteHTML("<td></td>");
                    }
                    if ($m->Rate==1) {
                        $pdf->WriteHTML("<td><img  src='/resources/true.png' style='height:13; width:13;' /></td>
                        ");
                    }else{
                        $pdf->WriteHTML("<td></td>");
                    }
                    $pdf->WriteHTML("</tr>");
            $y++;
                }

            }

            $pdf->WriteHTML("<tr>
                <td colspan='7' align='left'>
                    <b style='text-decoration: underline;'>สรุปภาพรวม</b>
                ความรู้/ทักษะของพนักงานหลังการฝึกอบรมในหลักสูตรนี้
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <img  src='/resources/square.png' style='height:20px; width:20px;'/> 
                    ดีมาก &nbsp;
                <img  src='/resources/square.png' style='height:20px; width:20px;'/> 
                    ดี &nbsp;&nbsp;&nbsp;
                <img  src='/resources/square.png' style='height:20px; width:20px;'/> 
                    ปานกลาง 
                <img  src='/resources/square.png' style='height:20px; width:20px;'/>
                    ค่อนข้างน้อย &nbsp;
                <img  src='/resources/square.png' style='height:20px; width:20px;'/> น้อย
                <br>
                ข้อเสนอแนะอื่นๆ &nbsp;&nbsp;
                ".$n->Remark." <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                <b style='text-decoration: underline;'>ผู้ประเมิน</b>&nbsp;&nbsp;&nbsp;
                ลงชื่อ&nbsp;&nbsp;
                ".$n->HeadName."
                &nbsp;&nbsp;&nbsp;ผู้จัดการฝ่าย <br><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                วันที่ 
                ".DateThai($n->UpdateDate)."
                </td>
            </tr>  
            <tr style='border: 0px solid #000000;'>
                <td colspan='7' align='left' style='border: 0px solid #000000;'>
                <b style='text-decoration: underline;'>หมายเหตุ</b> โปรดส่งคืนแบบสอบถามและติดตามผลหลังฝึกอบรมที่แผนกฝึกอบรมฝ่ายทรัพยากรบุคคลและธุรการ  ขอขอบคุณในการตอบแบบสอบถามนี้
                </td>
            </tr>");

            $pdf->WriteHTML("</table>");
            $pdf->SetHTMLFooter("<table width=100%>
                <tr style='border: 0px solid #000000;'>
                    <td align='left' style='border: 0px solid #000000;'>
                        <h6>Ref.QP-RM-3</h6>
                    </td>
                    <td align='right' style='border: 0px solid #000000;'>
                         <h6>FM-RM-3.10,  Issued # 3</h6>
                    </td>
                </tr>
            </table>");

            if ($i<$numrows) {
                $pdf->AddPage();
            }
            $i++;
        }
?>


<?php 
ob_clean(); // clean
$pdf->Output(); // print on browser
ob_end_flush();
