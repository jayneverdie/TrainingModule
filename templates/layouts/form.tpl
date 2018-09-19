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
  
	<div class="container">
		<?= $this->section('content'); ?>
	</div>

</body>
</html>

