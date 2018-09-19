<?php $this->layout("layouts/form") ?>
<h4>TEST2</h4>
<?php 
use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;
$conn = ConnectionController::connect();
$master = Sqlsrv::array(
    $conn,
    "SELECT * FROM EvaluationLineMaster
  	WHERE EvaluationNo=2"
);
$listname = Sqlsrv::array(
    $conn,
    "SELECT L.Employee
	FROM  EvaluationTableLine L
	WHERE L.HeadEmail!=''
	AND L.TrainingCode='TRAI9986'
	AND L.Status!=4"
);

$rows = count($master);
$rowsname = count($listname);

foreach ($listname as $key => $value) {
    $data[] = array(
      "employee"    =>  $value->Employee
    );
}

?>

<!-- <p id="demo"></p> -->
<script type="text/javascript">

    // var plant = getPlant();
    var emp = <?php echo json_encode( $data ) ?>;
    // console.log(emp);

        var form = [];

        for (var i = 0; i <= emp.length-1; i++) {
            form.push(emp[i].employee);
            console.log(emp[i].employee);
        }
   
    alert(form);
	// getPlant().done(function(data) {
 //        $.each(data, function(index, val) {
 //            console.log(val.CompanyID);
 //        });
 //    });

	// for (var i = 1; i <=listdata.length; i++) {
	// 	display.push(i);
	// 	console.log(i);
	// }
	// display[1] = "block";
	// display[2] = "none";

	// console.log(display);


	function getPlant() {
      return $.ajax({
        url : '/api/v1/company/load',
        type : 'get',
        // dataType : 'json',
        cache : false
      });
    }
</script>