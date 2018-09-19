<?php $this->layout("layouts/form") ?>
<h4>TEST</h4>
<?php 
use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;
$conn = ConnectionController::connect();

$master = Sqlsrv::array(
    $conn,
    "SELECT * FROM EvaluationLineMaster
  	WHERE EvaluationNo=2"
);

$rows = count($master);
$i 	  = 1;

echo "<table border=1>";
	foreach ($master as $m) {
		echo "<tr>";
		echo "<td class=".'box'."".$i.">".$i.$m->Description."</td>";
		echo "</tr>";
		$i++;
	}
echo "</table>";	
?>
	
    <button type="button" onClick="onClick()">Click me</button>
    <p>Clicks: <a id="clicks">0</a></p>

    <script type="text/javascript">
    
    var length = '<?php echo $rows ?>';
	console.log(length);
	    for (i=2; i <= length; i++) {
		    $('.box'+i).hide();
		}

    var clicks = 1;

    function onClick() {
        clicks += 1;
        document.getElementById("clicks").innerHTML = clicks;



        for (i=1; i <= clicks; i++) {
		    $('.box'+i).hide();
		}

        $(".box"+clicks).show();

        if (clicks > length) {
        	alert("Complete");
        }

    };
    
    </script>

