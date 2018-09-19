<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" type="image/png" href="/resources/logo.png"/>
	<title>Training-Module V.2</title>
	<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/app.css" />
	<link rel="stylesheet" href="/resources/css/cosmo.min.css" />
	<link rel="stylesheet" href="/resources/sweetalert-master/dist/sweetalert.css">
	<link rel="stylesheet" href="/resources/css/boon-all.css" />
	<link rel="stylesheet" href="/resources/css/style.css" />
	<script src="/resources/sweetalert-master/dist/sweetalert.min.js"></script> 
	<script src="/resources/js/jquery-1.12.0.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/gojax.min.js"></script>
	<script src="/resources/js/app.js"></script>
	<script src="/resources/js/gotify.min.js"></script>
</head>
<body>

	<!-- GOTIFY -->
  	<div class="gotify-overlay"></div>

  	<div class="gotify">
      <div class="gotify-wrap">
          <div class="close-gotify" onclick="return close_gotify()"></div>
          <div class="gotify-content"></div>
      </div>
  	</div>
  

	<nav class="navbar navbar-inverse navbar-fixed-top">
	  <div class="container">
	    <div class="navbar-header">
	      
	      <a class="navbar-brand" href="/"><img  src="/resources/DN2.png" style="padding-left:0px;height:15px; width:auto;" />
	      </a>

	    </div>

	    <ul class="nav navbar-nav navbar-left">
          <li class="dropdown"><a href="#"><span class="glyphicon glyphicon-book"></span> คู่มือการใช้งาน</a></li>
        </ul>
	    <ul class="nav navbar-nav navbar-right">
	    	<?php if (isset($_SESSION["logged"])): ?>
	    		<li><a href="/user/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
	    	<?php endif ?>
	    </ul>
	  </div>
	</nav>
	
	<div class="container">
		<?= $this->section('content'); ?>
	</div>

</body>
</html>

