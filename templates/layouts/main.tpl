<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="/resources/logo.png"/>
    <title>Training-Module V.2</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/jqwidgets/styles/jqx.base.css">
    <link rel="stylesheet" href="/resources/css/multiple-select.css" />
    <link rel="stylesheet" href="/resources/css/app.css" />
    <link rel="stylesheet" href="/resources/css/cosmo.min.css" />
    <link rel="stylesheet" href="/resources/jqwidgets/styles/deestone.css"/>
    <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" />
    <link rel="stylesheet" href="/resources/css/boon-all.css" />
    <link rel="stylesheet" href="/resources/css/style.css" />
    <link rel="stylesheet" href="/resources/sweetalert-master/dist/sweetalert.css">
    <script src="/resources/sweetalert-master/dist/sweetalert.min.js"></script> 
    <script src="/resources/js/jquery-1.12.0.min.js"></script>
    <script src="/resources/js/jquery-ui.min.js"></script>
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/jqwidgets/jqxcore.js"></script>
    <script src="/resources/jqwidgets/jqxdata.js"></script> 
    <script src="/resources/jqwidgets/jqxbuttons.js"></script>
    <script src="/resources/jqwidgets/jqxscrollbar.js"></script>
    <script src="/resources/jqwidgets/jqxmenu.js"></script>
    <script src="/resources/jqwidgets/jqxcheckbox.js"></script>
    <script src="/resources/jqwidgets/jqxlistbox.js"></script>
    <script src="/resources/jqwidgets/jqxdropdownlist.js"></script>
    <script src="/resources/jqwidgets/jqxdropdownbutton.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.js"></script>
    <script src="/resources/jqwidgets/jqxgrid.sort.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.pager.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.selection.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.edit.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.filter.js"></script> 
    <script src="/resources/jqwidgets/jqxgrid.columnsresize.js"></script>
    <script src="/resources/jqwidgets/jqxcore.js"></script>
    <script src="/resources/jqwidgets/jqxbuttongroup.js"></script>
    <script src="/resources/jqwidgets/jqxbuttons.js"></script>
    <script src="/resources/jqwidgets/jqxradiobutton.js"></script>
    <script src="/resources/jqwidgets/jqxdatetimeinput.js"></script>
    <script src="/resources/jqwidgets/jqxcalendar.js"></script>
    <script src="/resources/js/gojax.min.js"></script>
    <script src="/resources/js/functions.js"></script>
    <script src="/resources/js/app.js"></script>
    <script src="/resources/js/gotify.min.js"></script>
    <script src="/resources/js/multiple-select.js"></script>
   
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
      <div class="container-fluid">
        
        <div class="navbar-header">
        <?php if (isset($_SESSION["logged"]) && $_SESSION["reset"]==0){ ?>
          <a class="navbar-brand" href="#"><img  src="/resources/DN2.png" style="padding-left:0px;height:15px; width:auto;" />
          </a>
          
        <?php }else{ ?> 
          <a class="navbar-brand" href="/"><img  src="/resources/DN2.png" style="padding-left:0px;height:15px; width:auto;" />
          </a>
          <a class="navbar-brand" href="/">
            Home
          </a>
        
        </div>

        <!-- <div class="navbar-header">
          <a class="navbar-brand" href="/">
            Home
          </a>
        </div> -->
        <ul class="nav navbar-nav navbar-left">
          <!-- <li class="dropdown"><a href="#">Menu</a></li> -->
          <!-- <li class="dropdown"><a href="#">Menu</a></li> -->
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Setup <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/usermaster">User</a></li>
              <li><a href="/companymaster">Company</a></li>
              <li><a href="/evaluationmaster">Evaluation</a></li>
              <li class="divider"></li>
              <li><a href="/syncmaster">Sync</a></li>
              <li class="divider"></li>
              <!-- <li><a href="#">...</a></li> -->
            </ul>
          </li>
          <!-- <li class="dropdown"><a href="warningmail">Warning mail</a></li> -->
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/profile"><span class="glyphicon glyphicon-user"></span> 
            <?php echo $_SESSION["email"]; ?>
            </a></li>
            <li><a href="/user/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </ul>
        <?php }?> 
      </div>
    </nav>
    <div class="container-fluid">
            <br><br>
            <?= $this->section('content'); ?>
    </div>
</body>
</html>