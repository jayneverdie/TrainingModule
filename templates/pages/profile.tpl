<?php $this->layout("layouts/main") ?>

<h3>Account Setting</h3>
<hr>

<div class="container">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="panel panel-default">
				<div class="panel-heading">Change Password</div>
				<div class="panel-body">
					<form id="profilefrom">
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<label for="username">Username</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="form-group">
								      <input type="username" name="username" id="username" class="form-control" value='<?php echo $_SESSION["email"]; ?>'; readonly>
								    </div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<label for="password">Password</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="form-group">
								      <input type="text" name="password" id="password" class="form-control" placeholder="Password" required>
								    </div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<label for="newpassword">New Password</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="form-group">
								      <input type="password" name="newpassword" id="newpassword" class="form-control" placeholder="New Password" required>
								    </div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<label for="confirmpassword">Confirm New Password</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="form-group">
								      <input type="password" name="confirmpassword" id="confirmpassword" class="form-control" placeholder="Confirm New Password" required>
								    </div>
								</div>
							</div>
						</div>
						<input type="hidden" name="iduser" id="iduser" value="<?php echo $_SESSION["user_id"]; ?>">
						<button class="btn btn-primary" type="submit">submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

	jQuery(document).ready(function($) {

		$('#profilefrom').on('submit', function(event) {
	        event.preventDefault();
	        var sess_pass = "<?php echo $_SESSION["password"]; ?>";
	        if (sess_pass!=$('#password').val()) {
	        	swal("Please Check Password","","error")
	        }else if($('#password').val()==$('#newpassword').val()){
	            swal("Please Check Password","","error")
	        }else if($('#newpassword').val()!=$('#confirmpassword').val()){
	            swal("Please Check New Password & Comfirm New Password","","error")
	        }else{
	        	$.ajax({
	              url : '/api/v1/user/profile',
	              type : 'post',
	              cache : false,
	              dataType : 'json',
	              data : $('form#profilefrom').serialize()
	            })
	            .done(function(data) {
	              	if (data.result==false) {
	              		swal(data.message, "", "error");
	              	}else{
	              		swal({  title: data.message,
				                text: "Do you want logout ?",
				                imageUrl: "resources/sweetalert-master/example/images/change.png",  
				                showCancelButton: true,
				                closeOnConfirm: false, 
				                cancelButtonText: "Cancel",
				                confirmButtonText: "Ok",
				                confirmButtonColor: "#33CCFF",  
				                showLoaderOnConfirm: true, 
				            }, function(isConfirm){   
				            if (isConfirm) {  
				                window.location = '/user/logout';
				            }else{
				                window.location = '/';
				            } 
				        }); 
	              		
	              	}
	                
	              
	            });
	        }
	    });

  	});

</script>