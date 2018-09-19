<?php $this->layout("layouts/form") ?>
<?php 
use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;
$conn = ConnectionController::connect();

if (!isset($_GET['no'])) {
	echo "<h3>หน้าเว็บไม่พร้อมใช้งาน</h3>";
	exit;
}
$training_code  = $_GET['no'];
$email 			= $_GET['email'];
$hasRows = Sqlsrv::hasRows(
	$conn,
	"SELECT * FROM EvaluationTableLine
	WHERE TrainingCode = ?
	AND Status <= ?",
	[
		$training_code, 
		2
	]
);

if (!$hasRows) {
	echo "<h3>รายการนี้ดำเนินการไปแล้ว</h3>";
	exit;
}

$trans = Sqlsrv::array(
    $conn,
    "SELECT * FROM EvaluationTable WHERE TrainingCode=?",[$training_code]
);
$master = Sqlsrv::array(
    $conn,
    "SELECT L.RECID,L.EvaluationNo,L.Description,L.Company 
	FROM EvaluationLineMaster L
	LEFT JOIN  EvaluationMaster LM ON L.EvaluationNo = LM.RECID
  	WHERE LM.Active=1"
);
$listname = Sqlsrv::array(
    $conn,
    "SELECT L.TrainingCode,L.Employee,l.Title,L.EmployeeName,l.Alias,L.HeadEmail
	FROM  EvaluationTableLine L
	WHERE L.HeadEmail!=''
	AND L.TrainingCode='$training_code'
	AND L.HeadEmail='$email'
	AND L.Status!=4"
);
$rows = count($master);
$rowsname = count($listname);

foreach ($master as $key => $m) {
    $datamaster[] = array(
      "line"    =>  $m->RECID,
      "no" 	  	=>  $m->EvaluationNo
    );
}

foreach ($listname as $key => $value) {
    $dataname[] = array(
      "employee"    =>  $value->Employee,
      "code" 	 	=>	$value->TrainingCode
    );
}

function DateThai($strDate)
{
    $strYear = date("Y",strtotime($strDate))+543;
    $strMonth= date("n",strtotime($strDate));
    $strDay= date("j",strtotime($strDate));
    $strMonthCut = Array("","มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม");
    $strMonthThai=$strMonthCut[$strMonth];
    return "$strDay $strMonthThai $strYear";
}
?>
<style type="text/css">
	table {
	border: 1px solid #ddd;
    border-collapse: collapse;
    width: 100%;
    text-align: center;
    }
    td, th {
    border: 1px solid #ddd;
    padding: 8px;
</style>

<table>
	<tr>
		<td width="30%">
			<a class="navbar-brand"><img  src="/resources/DN2.png" 
            style="padding-left:80px;height:30px; width:auto;" /></a> 
		</td>
		<td colspan="5">
			<font size=5px>แบบสอบถามและติดตามผลหลังการฝึกอบรม </font>
		</td>
	</tr>
	<tr>
		<td colspan="6">
			คำชี้แจง  โปรดอ่านข้อความในแต่ละข้อและทำเครื่องหมาย   
			<img  src="/resources/true.png" 
            style="height:15px; width:15px;" />ลงในช่องที่ตรงกับความคิดเห็นของท่านมากที่สุดเพียงช่องเดียวเท่านั้น<br>
            แบบสอบถามนี้มีวัตถุประสงค์เพื่อเป็นข้อมูลในการติดตามผลการฝึกอบรม  ข้อมูลที่ได้รับจากแบบสอบถามในครั้งนี้จะนำเสนอในภาพรวม และจะไม่มีผลกระทบใดๆ ต่อการปฏิบัติงาน<br>
            ชื่อหลักสูตร    <?php echo $trans[0]->CourseDescription; ?>
            วันที่ฝึกอบรม   <?php echo DateThai($trans[0]->StartDate); ?>
            จัดโดย   		 <?php echo $trans[0]->ArrangedBy; ?>
		</td>
	</tr>
		<?php 
			$i=0;
			$z=1;
			foreach ($master as $m) {
				echo "<tr class=".'box'."".$i."><td>หัวข้อการประเมิน</td>";
				echo "<td colspan='5'>".$z.". ".$m->Description."</td></tr>";

				echo "<tr class=".'box'."".$i.">";
				echo "<td rowspan='2'>รายชื่อพนังงาน</td>";
				echo "<td colspan='5'>ประเมินความรู้ / ทักษะในการปฎิบัติงาน</td>";
				echo "</tr>";

				echo "<tr class=".'box'."".$i.">";
				echo "<td width='10%'>ดีมาก (5)</td>";
				echo "<td width='10%'>ดี (4)</td>";
				echo "<td width='10%'>ปานกลาง (3)</td>";
				echo "<td width='10%'>ค่อนข้างน้อย (2)</td>";
				echo "<td width='10%'>น้อย (1)</td>";
				echo "</tr>";
		?>
		<?php 
				$x=0;
				$y=1;
				foreach ($listname as $n) {
					echo "<tr class=".'box'."".$i.">";
					echo "<td align='left'>".$y.". ".$n->Title.$n->EmployeeName."&nbsp;&nbsp;&nbsp;&nbsp;".$n->Alias."</td>";
					echo "<td><input type='checkbox' value='5' name=".$i.$x."></td>";
					echo "<td><input type='checkbox' value='4' name=".$i.$x."></td>";
					echo "<td><input type='checkbox' value='3' name=".$i.$x."></td>";
					echo "<td><input type='checkbox' value='2' name=".$i.$x."></td>";
					echo "<td><input type='checkbox' value='1' name=".$i.$x."></td>";
					echo "</tr>";
					$x++;
					$y++;
				}

			$i++;
			$z++;
			}
		?>
	
	<tr class="box_finish">
		<td colspan="6">
			ข้อเสนอแนะอื่นๆ
		</td>
	</tr>
	<tr class="box_finish">
		<td>
			รายชื่อพนักงาน
		</td>
		<td colspan="5">
			ข้อเสนอแนะอื่นๆ
		</td>
	</tr>
	<?php 
		$j=0;
		$k=1;
		foreach ($listname as $name) {
			echo "<tr class='box_finish'>";
			echo "<td align='left'>".$k.$name->Title.$name->EmployeeName."&nbsp;&nbsp;&nbsp;&nbsp;".$name->Alias."</td>";
			echo "<td  colspan='5'><input type='text' size='90' name=".$name->Employee."></input></td>";
			echo "</tr>";
			$j++;
			$k++;
		}
		
	?>
	<tr>
		<td colspan="6">
			<button class="btn btn-primary btn-lg" id="onnext" onClick="onNext()"><span class="glyphicon glyphicon-forward"></span> Next</button>
		</td>
	</tr>
	<tr class="box_finish">
		<td colspan="6">
			<button class="btn btn-primary btn-lg" id="onsave" onClick="onSave()"><span class="glyphicon glyphicon-floppy-open"></span> ส่งข้อมูลการประเมิน</button>
		</td>
	</tr>
</table>
<br><br>

<script type="text/javascript">
	var clicks = 0;
	// var length = '<?php echo $rows ?>';
	var emp 	= <?php echo json_encode( $dataname ) ?>;
	var master 	= <?php echo json_encode( $datamaster ) ?>;
	var heademail = '<?php echo $listname[0]->HeadEmail ?>';
	var training_code = '<?php echo $training_code ?>';
	// console.log(master);
	    for (i=1; i <= master.length-1; i++) {
		    $('.box'+i).hide();
		}

	function onNext() {
		
			var form = [];

			for (i=0; i <= emp.length-1;  i++) {
				if ($('input[name='+clicks+i+']:checked').val() == undefined) {
					gotify("กรุณากรอกข้อมูลให้ครบถ้วน","danger");
					return false;
				}else{
					var dataform = $('input[name='+clicks+i+']:checked').val();
					var employee = emp[i].employee;
					var code 	 = emp[i].code;
					var line     = master[clicks].line;
					var no     = master[clicks].no;
					form.push(employee+'_'+code+'_'+dataform);
					// console.log(form);
				}
			}

			$('#onnext').html('รอสักครู่.....');
			$('#onnext').attr('disabled',true);

	        $.ajax({
	            url : '/api/v1/trans/insertform',
	            type : 'post',
	            data : {
	              score 	: form,
	              line 		: line,
	              no 		: no 

	            },
	            success : function(data){
	              // alert(data);
	              if (data.result == false) {
	                //swal(data.message, "", "error")
	                $('#onnext').attr('disabled',true);
	              }else{
	                //swal(data.message, "", "success")
	                $('#onnext').attr('disabled',false);
	              }
	              $('#onnext').html('Next');
	            }
	        });

	        clicks += 1;

	        $('#clicks').val(clicks);
	        for (i=0; i <= master.length-1; i++) {
			    $('.box'+i).hide();
			}

	        $(".box"+clicks).show();

	        if (clicks > master.length-1) {
	        	// alert("Complete");
	        	$('.box_finish').show();
	        	$('#onnext').hide();
	        }
    
    }
    
    $('.box_finish').hide();
    function onSave() {
    	$('#onsave').html('รอสักครู่.....');
		$('#onsave').attr('disabled',true);
    	var remark = [];

		for (i=0; i <= emp.length-1;  i++) {
			if ($('input[name='+emp[i].employee+']').val() !== '') {
				var employee = $('input[name='+emp[i].employee+']').val();
				var idemp 	 = emp[i].employee;
				var idtrain  = emp[i].code;
				remark.push(idemp+"_"+idtrain+"_"+employee);
			}else{
				gotify("ดำเนินการเสร็จสิ้น","success");
                setTimeout(function(){
                    window.open('', '_self', '');
                    window.close();
                }, 3000);
			}
		}

		$.ajax({
            url : '/api/v1/trans/insertremark',
            type : 'post',
            data : {
              	remark 	: remark,
	            heademail : heademail,
	            training_code : training_code 
            },
            success : function(data){
              // alert(data);
              if (data.result == false) {
                //swal(data.message, "", "error")
                gotify(data.message,"danger");
                $('#onsave').attr('disabled',false);
                return false;
              }else{
                //swal(data.message, "", "success")
                //$('#onsave').attr('disabled',true);
                gotify(data.message,"success");
                setTimeout(function(){
                    window.open('', '_self', '');
                    window.close();
                }, 3000);
              }

            }
        });
    }

	// CheckBox only one
	$("input:checkbox").on('click', function() {
	  var $box = $(this);
	  if ($box.is(":checked")) {
	    var group = "input:checkbox[name='" + $box.attr("name") + "']";
	    $(group).prop("checked", false);
	    $box.prop("checked", true);
	  }else{
	    $box.prop("checked", false);
	  }
	});
</script>
