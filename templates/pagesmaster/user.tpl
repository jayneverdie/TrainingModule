<?php $this->layout("layouts/main") ?>

<h3>User</h3>
<hr>

<button class="btn btn-default" id="btn_create">Create User</button>
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
        <form id="form_create" onsubmit="return submit_create_user()">
          
          <div class="form-group">
            <label for="email">E-mail</label>
            <input type="email" name="inpText_Email" id="inpText_Email" class="form-control" autocomplete="off" placeholder="E-mail" required>
            <label for="password">Password</label>
            <input type="text" name="inpText_Password" id="inpText_Password" class="form-control" autocomplete="off" placeholder="Password" required>
            <label for="name">Name</label>
            <input type="text" name="inpText_Name" id="inpText_Name" class="form-control" autocomplete="off" placeholder="Name" required>
            <label for="comp">Company</label>
            <select name="inpSelect_Comp" id="inpSelect_Comp" class="form-control" required></select>
            <label for="heademail">Head E-mail</label>
            <input type="heademail" name="inpText_HeadEmail" id="inpText_HeadEmail" class="form-control" autocomplete="off" placeholder="E-mail" required><br>
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

<div id="grid_user"></div>

<script type="text/javascript">
    
    jQuery(document).ready(function($) {
        grid_user();

          $('#btn_create').on('click', function() {
              $('#modal_create').modal({backdrop: 'static'});
              $('#form_create').trigger('reset');
              $('.modal-title').text('Create User');
          });

          getPlant()
          .done(function(data) {
              $('select[name=inpSelect_Comp]').html("<option value=''>=Select=</option>");
              $.each(data, function(index, val) {
                $('select[name=inpSelect_Comp]').append('<option value="'+val.CompanyID+'">'+val.CompanyID+'</option>');
              });
          });

    });

    function grid_user() {
      
      var dataAdapter = new $.jqx.dataAdapter({
      datatype: "json",
      updaterow: function (rowid, rowdata, commit) {
        gojax('post', '/api/v1/user/update', {
          pass    : rowdata.Password,
          name    : rowdata.Name,
          status  : rowdata.Status,
          comp    : rowdata.Company,
          headmail: rowdata.HeadEmail,
          id      : rowdata.RECID
        }).done(function(data) {
          if (data.result === true) {
            $('#grid_user').jqxGrid('updatebounddata');
            commit(true);
          }
        }).fail(function() {
          commit(false);
        });
      },
      datafields: [
                { name: "RECID", type: "ID" },
                { name: "Email", type: "string"},
                { name: "Password", type: "string"},
                { name: "Name", type: "string"},
                { name: "Company", type: "string"},
                { name: "Description", type: "string"},
                { name: "Status", type: "bool"},
                { name: "ResetPassword", type: "bool"},
                { name: "HeadEmail", type: "string"}
      ],
        url : '/api/v1/user/load'
      });

      return $("#grid_user").jqxGrid({
          width: '70%',
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
            { text:"Email", datafield: "Email", editable : false, width : "25%"},
            { text:"Password", datafield: "Password"},
            { text:"Name", datafield: "Name", width : "25%"},
            { text:"Status", datafield: "Status", filtertype: 'bool', columntype: 'checkbox', editable: true},
            {
                        text: 'Company', datafield: 'Company', width: "10%", columntype: 'dropdownlist',
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
            },
            { text:"HeadEmail", datafield: "HeadEmail", width : "25%"},
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

    function submit_create_user() {
        //console.log($('form#form_create').serialize());
        $.ajax({
            url : '/api/v1/user/create',
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
              $('#grid_user').jqxGrid('updatebounddata');
            }
            // alert(data);
          });
      return false;
    }
</script>