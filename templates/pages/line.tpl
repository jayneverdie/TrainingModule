<?php $this->layout("layouts/main") ?>

<h3>Line</h3>
<hr>
<form id="printsub" method="post" action="/api/v1/report/ask" target="_blank" >
<input type="hidden" name="no" id="no">
<input type="hidden" name="emp" id="emp">
<button class="btn btn-warning" type="button" id="btn_print">Print</button>
</form>
<br><br>   
<div id="grid_line"></div>

<script type="text/javascript">
	jQuery(document).ready(function($) {
    var code = '<?php echo $_GET["trainingcode"] ?>';
    var record =[];
    var lastrecord;
    var emp =[];
    var lastemp;
		grid_line(code);

    $('#btn_print').on('click', function(event) {
        if (record.length > 0) {
          // window.open("/askquestions?no="+record);
            printreport(record,emp);
        }
    });

    $("#grid_line").on('rowselect', function (event) {
      var args = event.args;
      var rowBoundIndex = args.rowindex;
      var rowData = args.row;

      if (rowData.Status !== 4) {
        $(this).jqxGrid('resetSelection');
      }else{
        record.push(rowData.RECID);
        lastrecord = rowData.RECID; 

        emp.push(rowData.Employee);
        lastemp = rowData.Employee; 
      }
    });

    $("#grid_line").on('rowunselect', function (event) {   
      var args = event.args;
      var rowBoundIndex = args.rowindex;
      var rowData = args.row;
      var index = record.indexOf(rowData.RECID);

        if (index > -1) {
            record.splice(index, 1);
        }
      var index = emp.indexOf(rowData.Employee);
        
        if (index > -1) {
            emp.splice(index, 1);
        }

    });

	});

	function grid_line(code) {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      datafields: [
                { name: "RECID", type: "int" },
                { name: "TrainingCode", type: "string"},
                { name: "Employee", type: "string"},
                { name: "Title", type: "string"},
                { name: "EmployeeName", type: "string"},
                { name: "Alias", type: "string"},
                { name: "Company", type: "string"},
                { name: "PositionName", type: "string"},
                { name: "DivisionName", type: "string"},
                { name: "DepartmentName", type: "string"},
                { name: "HeadName", type: "string"},
                { name: "HeadEmail", type: "string"},
                { name: "Status", type: "int"},
                { name: "StatusName", type: "string"}
      ],
        url : '/api/v1/line/load?code='+code
      });

      return $("#grid_line").jqxGrid({
          width: '100%',
          source: dataAdapter,  
          columnsresize: true,
          pageable: true,
          autoHeight: true,
          filterable: true,
          showfilterrow: true,
          enableanimations: false,
          altrows: true,
          sortable: true,
          pagesize: 10,
          // selectionmode: 'checkbox',
          selectionmode: 'multiplerows',
          theme: 'deestone',
        columns: [
            { text:"TrainingCode", datafield: "TrainingCode",width: "6%"},
            { text:"Employee", datafield: "Employee"},
            { text:"Title", datafield: "Title"},
            { text:"EmployeeName", datafield: "EmployeeName"},
            { text:"Alias", datafield: "Alias"},
            { text:"Company", datafield: "Company"},
            { text:"PositionName", datafield: "PositionName"},
            { text:"DivisionName", datafield: "DivisionName"},
            { text:"DepartmentName", datafield: "DepartmentName"},
            { text:"HeadName", datafield: "HeadName",width: "12%"},
            { text:"HeadEmail", datafield: "HeadEmail"},
            { text:"Status", datafield: "StatusName"}
        ]
      });
  }

  function printreport(record,emp){
      // alert(record+emp);
      if (record==='') {
        return false;
      }else{
        $('#no').val(record);
        $('#emp').val(emp);
        document.getElementById("printsub").submit();
      }
  }
</script>