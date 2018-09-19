<?php 

namespace App\Controllers;

use App\Models\ReportModel;
use Interop\Container\ContainerInterface;

class ReportController
{
	protected $container;
	public function __construct(ContainerInterface $container)
	{
		$this->report = new ReportModel;
		$this->container = $container;
		$this->template = $this->container->get('plate');
	}

	public function ask($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
			//id
			$ask_array = explode(",", $parsedBody["no"]);
	   		$ask_select = $ask_array;
	   		$askreport  = '';
	   		foreach ($ask_select as $v) {
	   			$askreport .= '\''.$v .'\',';
	   		}
	   		$askreport = trim($askreport, ', ');

	   		//emp
	  //  		$emp_array = explode(",", $parsedBody["emp"]);
	  //  		$emp_select = $emp_array;
	  //  		$empreport  = '';
	  //  		foreach ($emp_select as $v) {
	  //  			$empreport .= '\''.$v .'\',';
	  //  		}
	  //  		$empreport = trim($empreport, ', ');

			$data_name 		= $this->report->line($askreport);
			$data_master 	= $this->report->master();
			// $data_score 	= $this->report->score($empreport);

			return $this->template->render("report/askquestions",[
				"data_name" 	=> $data_name,
				"data_master"	=> $data_master
			]);

			// echo "<pre>". print_r($data_score, true) . "</pre>";
			// exit;
		
	}
}