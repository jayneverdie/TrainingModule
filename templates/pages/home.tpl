<?php $this->layout("layouts/main") ?>

<h3>Home</h3>
<hr>

<button class="btn btn-warning" id="btn_send">Resend Email</button>
<br><br>   
<div id="grid_trans"></div>

<script type="text/javascript">
  jQuery(document).ready(function($) {
    grid_trans();

    $("#grid_trans").bind('rowdoubleclick', function (event) {
        var rowdata = row_selected("#grid_trans");
        // window.open("/line?trainingcode="+rowdata.TrainingCode);
        window.location.assign("/line?trainingcode="+rowdata.TrainingCode)
    });

    $('#btn_send').on('click', function() {
        var rowdata = row_selected("#grid_trans");
        if (typeof rowdata !== 'undefined' && rowdata.Status !== 4) {
          $('#btn_send').html('รอสักครู่.........');
          $('#btn_send').prop('disabled',true);
          $.ajax({
              url : '/api/v1/trans/resend',
              type : 'post',
              data : {
                trainingcode : rowdata.TrainingCode,
                course       : rowdata.CourseDescription
              },
              success : function(data){
                if (data.result == false) {
                  swal(data.message, "", "error")
                  $('#btn_send').html('Resend Email');
                  $('#btn_send').prop('disabled',false);
                }else{
                  swal(data.message, "", "success")
                  $('#grid_trans').jqxGrid('updatebounddata');
                  $('#btn_send').html('Resend Email');
                  $('#btn_send').prop('disabled',false);
                }
                // alert(data);
              }
          });
        }
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
                { name: "Status", type: "string"},
                { name: "Description", type: "string"},
                { name: "CreateDateTime", type: "date"}
      ],
        url : '/api/v1/trans/load'
      });

      return $("#grid_trans").jqxGrid({
          width: '100%',
          pageSize :'15',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
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
</script>