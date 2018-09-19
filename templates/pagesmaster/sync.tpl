<?php $this->layout("layouts/main") ?>

<h3>Sync</h3>
<hr>

<button class="btn btn-default" id="btn_trans">Sync Training</button>
<br><br>   

<div id="grid_trans"></div>
<br><br>
<hr>
<button class="btn btn-default" id="btn_line">Sync Line</button>
<br><br> 
<div id="grid_line"></div>

<script type="text/javascript">
    
    jQuery(document).ready(function($) {
        grid_trans();
        grid_line();

        $('#btn_trans').on('click', function() {
            $('#btn_trans').html('รอสักครู่.........');
            $('#btn_trans').prop('disabled',true);
            $.ajax({
                url : '/api/v1/sync/data',
                type : 'post',
                data : {
                  id : 1
                },
                success : function(data){
                  if (data.result == false) {
                    swal(data.message, "", "error")
                    $('#btn_trans').html('Sync Training');
                    $('#btn_trans').prop('disabled',false);
                  }else{
                    swal(data.message, "", "success")
                    $('#grid_trans').jqxGrid('updatebounddata');
                    $('#btn_trans').html('Sync Training');
                    $('#btn_trans').prop('disabled',false);
                  }
                }
            });
            return false;
        });

        $('#btn_line').on('click', function() {
            $('#btn_line').html('รอสักครู่.........');
            $('#btn_line').prop('disabled',true);
            $.ajax({
                url : '/api/v1/sync/data',
                type : 'post',
                data : {
                  id : 2
                },
                success : function(data){
                  if (data.result == false) {
                    swal(data.message, "", "error");
                    $('#btn_line').html('Sync Line');
                    $('#btn_line').prop('disabled',false);
                  }else{
                    swal(data.message, "", "success")
                    $('#grid_line').jqxGrid('updatebounddata');
                    $('#btn_line').html('Sync Line');
                    $('#btn_line').prop('disabled',false);
                  }
                }
            });
            return false;
        });

    });

    function grid_trans() {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      datafields: [
                { name: "RECID", type: "int" },
                { name: "TrainingCode", type: "string"},
                { name: "CourseDescription", type: "string"},
                { name: "StartDate", type: "date"},
                { name: "EndDate", type: "date"},
                { name: "ArrangedBy", type: "string"},
                { name: "Company", type: "string"},
                { name: "Description", type: "string"},
                { name: "CreateDateTime", type: "date"}
      ],
        url : '/api/v1/trans/load'
      });

      return $("#grid_trans").jqxGrid({
          width: '100%',
          pageSize :'10',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
          // showfilterrow: true,
          //editable : true,
          theme: 'deestone',
        columns: [
            { text:"TrainingCode", datafield: "TrainingCode"},
            { text:"CourseDescription", datafield: "CourseDescription"},
            { text:"StartDate", datafield: "StartDate", cellsformat: 'dd-MM-yyyy'},
            { text:"EndDate", datafield: "EndDate", cellsformat: 'dd-MM-yyyy'},
            { text:"ArrangedBy", datafield: "ArrangedBy"},
            { text:"Status", datafield: "Description"},
            { text:"CreateDate", datafield: "CreateDateTime", cellsformat: 'dd-MM-yyyy'}
        ]
      });
    }

    function grid_line() {
      
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
                { name: "HeadEmail", type: "string"}
      ],
        url : '/api/v1/linesync/load'
      });

      return $("#grid_line").jqxGrid({
          width: '100%',
          pageSize :'10',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
          // showfilterrow: true,
          //editable : true,
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
            { text:"HeadEmail", datafield: "HeadEmail"}
        ]
      });
    }

</script>