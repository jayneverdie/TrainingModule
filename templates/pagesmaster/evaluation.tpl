<?php $this->layout("layouts/main") ?>

<h3>Evaluation</h3>
<hr>

<button class="btn btn-default" id="btn_create">Create Evaluation</button>
<button class="btn btn-warning" id="btn_line">Line Evaluation</button>
<button class="btn btn-danger" id="btn_del">Delete Evaluation</button>
<br><br>   

<div class="modal" id="modal_create" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">this title</h4>
      </div>
      <div class="modal-body">
        <form id="form_create" onsubmit="return submit_create_evaluation()">
          
          <div class="form-group">
            <label for="name">Description</label>
            <input type="text" name="inpText_Name" id="inpText_Name" class="form-control" autocomplete="off" placeholder="Description" required>
            <label for="comp">Company</label>
            <!-- <select name="inpSelect_Comp" id="inpSelect_Comp" class="form-control" required></select> -->
            <input type="text" name="inpSelect_Comp" id="inpSelect_Comp" class="form-control" autocomplete="off" placeholder="Description" required><br>
            <label for="Status">Status</label>
            <input type="checkbox" name="inpCheck_Status" id="inpCheck_Status" checked="true">
            
            
          </div>

          <label>
            <button class="btn btn-primary">Save</button>
          </label>

        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal_line" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">EvaluationLine</h4>
      </div>
      <div class="modal-body">
        <button class="btn btn-default" id="btn_create_line">Create</button>
        <button class="btn btn-danger" id="btn_delete_line">Delete</button>
        <br><br>
        <div id="grid_evaluationline"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal_create_line" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="glyphicon glyphicon-remove-circle"></span>
        </button>
        <h4 class="modal-title">Create EvaluationLine</h4>
      </div>
      <div class="modal-body">
        <form id="form_create_line" onsubmit="return submit_line_evaluation()">
          
          <div class="form-group">
            <label for="name">Description</label>
            <input type="text" name="inpText_Nameline" id="inpText_Nameline" class="form-control" autocomplete="off" placeholder="Description" required>
            <label for="comp">Company</label>
            <input type="text" name="inpText_Compline" id="inpText_Compline" class="form-control" autocomplete="off" placeholder="Description" required>
            <input type="hidden" name="inpText_IDline" id="inpText_IDline">
          </div>

          <label>
            <button class="btn btn-primary">Save</button>
          </label>

        </form>
      </div>
    </div>
  </div>
</div>

<div id="grid_evaluation"></div>

<script type="text/javascript">
    
    jQuery(document).ready(function($) {
        grid_evaluation();
          var sessComp = '<?php echo $_SESSION['company'] ?>';
          $('#btn_create').on('click', function() {
              $('#modal_create').modal({backdrop: 'static'});
              $('#form_create').trigger('reset');
              $('.modal-title').text('Create Evaluation');
              $('input[name=inpSelect_Comp]').prop('readonly', true);
              $('input[name=inpSelect_Comp]').val(sessComp);
          });
          $('#btn_del').on('click', function() {
                var rowdata = row_selected("#grid_evaluation");
                if (typeof rowdata !== 'undefined') {
                    // alert(rowdata.RECID);
                    delete_evaluation(rowdata.RECID);
                }
          });
          $('#btn_line').on('click', function() {
              var rowdata = row_selected("#grid_evaluation");
              if (typeof rowdata !== 'undefined') {
                grid_evaluationline(rowdata.RECID);
                $('#modal_line').modal({backdrop: 'static'});
              }
          });
          $('#btn_create_line').on('click', function() {
                var rowdata = row_selected("#grid_evaluation");
                $('#form_create_line').trigger('reset');
                $('#modal_create_line').modal({backdrop: 'static'});
                $('input[name=inpText_Compline]').prop('readonly', true);
                $('input[name=inpText_Compline]').val(rowdata.Company);
                $('input[name=inpText_IDline]').val(rowdata.RECID);
          });
          $('#btn_delete_line').on('click', function() {
                var rowdata = row_selected("#grid_evaluationline");
                if (typeof rowdata !== 'undefined') {
                    // alert(rowdata.RECID);
                    delete_line_evaluation(rowdata.RECID);
                }
          });

        // getPlant()
        //   .done(function(data) {
        //       $('select[name=inpSelect_Comp]').html("<option value=''>=Select=</option>");
        //       $.each(data, function(index, val) {
        //         $('select[name=inpSelect_Comp]').append('<option value="'+val.CompanyID+'">'+val.CompanyID+'</option>');
        //       });
        //   });
    });

    function grid_evaluation() {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      updaterow: function (rowid, rowdata, commit) {
        gojax('post', '/api/v1/evaluation/update', {
          name    : rowdata.Description,
          status  : rowdata.Active,
          comp    : rowdata.Company,
          id      : rowdata.RECID
        }).done(function(data) {
          if (data.result === true) {
            $('#grid_evaluation').jqxGrid('updatebounddata');
            commit(true);
          }
        }).fail(function() {
          commit(false);
        });
      },
      datafields: [
                { name: "RECID", type: "int" },
                { name: "Description", type: "string"},
                { name: "Active", type: "bool"},
                { name: "Company", type: "string"}
      ],
        url : '/api/v1/evaluation/load'
      });

      return $("#grid_evaluation").jqxGrid({
          width: '60%',
          pageSize :'15',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
          showfilterrow: true,
          editable : true,
          theme: 'deestone',
        columns: [
            { text:"Description", datafield: "Description"},
            { text:"Active", datafield: "Active", filtertype: 'bool', columntype: 'checkbox', editable: true},
            {
                        text: 'Company', datafield: 'Company', width: 150, columntype: 'dropdownlist',
                        createeditor: function (row, column, editor) {
                            var list = ['svo', 'str', 'dsi','dsl','drb','dsc'];
                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list,theme: 'deestone' });
                        },
                        cellvaluechanging: function (row, column, columntype, oldvalue, newvalue) {
                            if (newvalue == "") return oldvalue;
                        },
                        geteditorvalue: function (row, cellvalue, editor) {
                            var selectedIndex = editor.jqxDropDownList('getSelectedIndex');
                            return editor.find('input').val();
                        }
            }
        ]
      });
    }

    function grid_evaluationline(id) {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      updaterow: function (rowid, rowdata, commit) {
        gojax('post', '/api/v1/evaluationline/update', {
          name    : rowdata.Description,
          id      : rowdata.RECID
        }).done(function(data) {
          if (data.result === true) {
            $('#grid_evaluationline').jqxGrid('updatebounddata');
            commit(true);
          }
        }).fail(function() {
          commit(false);
        });
      },
      datafields: [
                { name: "RECID", type: "int" },
                { name: "EvaluationNo", type: "int"},
                { name: "Description", type: "string"},
                { name: "Company", type: "string"}
      ],
        url : '/api/v1/evaluationline/load?id='+id
      });

      return $("#grid_evaluationline").jqxGrid({
          width: '100%',
          pageSize :'15',
          source: dataAdapter,
          autoheight: true,
          columnsresize: true,
          pageable: true,
          filterable: true,
          showfilterrow: true,
          editable : true,
          theme: 'deestone',
        columns: [
            { text:"Description", datafield: "Description"},
            { text:"Company", datafield: "Company", editable : false}
        ]
      });
    }

    function getPlant() {
      return $.ajax({
        url : '/api/v1/company/load',
        type : 'get',
        dataType : 'json',
        cache : false
      });
    }

    function submit_create_evaluation() {
        $.ajax({
            url : '/api/v1/evaluation/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create').serialize()
          })
          .done(function(data) {
            if (data.result == false) {
              swal(data.message, "", "error")
            }else{
              swal(data.message, "", "success")
              $('#modal_create').modal('hide');
              $('#grid_evaluation').jqxGrid('updatebounddata');
            }
            // alert(data);
          });
      return false;
    }

    function submit_line_evaluation() {
        $.ajax({
            url : '/api/v1/evaluationline/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create_line').serialize()
          })
          .done(function(data) {
            if (data.result == false) {
              swal(data.message, "", "error")
            }else{
              swal(data.message, "", "success")
              $('#modal_create_line').modal('hide');
              $('#grid_evaluationline').jqxGrid('updatebounddata');
            }
            // alert(data);
          });
      return false;
    }

    function delete_line_evaluation(id) {
        $.ajax({
            url : '/api/v1/evaluationline/delete',
            type : 'post',
            data : {
              id : id
            },
            success : function(data){
              if (data.result == false) {
                swal(data.message, "", "error")
              }else{
                swal(data.message, "", "success")
                $('#grid_evaluationline').jqxGrid('updatebounddata');
              }
            }
        });
      return false;
    }

    function delete_evaluation(id) {
        $.ajax({
            url : '/api/v1/evaluation/delete',
            type : 'post',
            data : {
              id : id
            },
            success : function(data){
              if (data.result == false) {
                swal(data.message, "", "error")
              }else{
                swal(data.message, "", "success")
                $('#grid_evaluation').jqxGrid('updatebounddata');
              }
            }
        });
      return false;
    }
</script>