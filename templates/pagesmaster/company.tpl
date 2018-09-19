<?php $this->layout("layouts/main") ?>

<h3>Company</h3>
<hr>

<button class="btn btn-default" id="btn_create">Create Company</button>
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
        <form id="form_create" onsubmit="return submit_create_company()">
          
          <div class="form-group">
            <label for="comp">CompanyID</label>
            <input type="comp" name="inpText_Comp" id="inpText_Comp" class="form-control" autocomplete="off" placeholder="CompanyID" required>
            <label for="name">Description</label>
            <input type="text" name="inpText_Name" id="inpText_Name" class="form-control" autocomplete="off" placeholder="Description" required>
            
            
          </div>

          <label>
            <button class="btn btn-primary">Save</button>
          </label>

        </form>
      </div>
    </div>
  </div>
</div>

<div id="grid_company"></div>

<script type="text/javascript">
    
    jQuery(document).ready(function($) {
        grid_company();

          $('#btn_create').on('click', function() {
              $('#modal_create').modal({backdrop: 'static'});
              $('#form_create').trigger('reset');
              $('.modal-title').text('Create Company');
          });

    });

    function grid_company() {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      updaterow: function (rowid, rowdata, commit) {
        gojax('post', '/api/v1/company/update', {
          name    : rowdata.Description,
          id    : rowdata.CompanyID
        }).done(function(data) {
          if (data.result === true) {
            $('#grid_company').jqxGrid('updatebounddata');
            commit(true);
          }
        }).fail(function() {
          commit(false);
        });
      },
      datafields: [
                { name: "CompanyID", type: "string" },
                { name: "Description", type: "string"}
      ],
        url : '/api/v1/company/load'
      });

      return $("#grid_company").jqxGrid({
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
            { text:"CompanyID", datafield: "CompanyID", editable : false, width : "20%"},
            { text:"Description", datafield: "Description"}
        ]
      });
    }

    function submit_create_company() {
        $.ajax({
            url : '/api/v1/company/create',
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
              $('#grid_company').jqxGrid('updatebounddata');
            }
            // alert(data);
          });
      return false;
    }
</script>