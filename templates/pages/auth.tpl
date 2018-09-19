<?php $this->layout('layouts/auth') ?>

<div class="container-fluid">
	<br><br><br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="panel panel-primary">
				<div class="panel-heading">Training-Module V.2</div>
				<div class="panel-body">
					<form id="form_user_auth">
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<p>E-mail</p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								      <input type="email" name="email" id="email" class="form-control" placeholder="E-mail" required>
								    </div>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="row">
								<div class="col-md-10">
									<p>Password</p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
								      <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
								    </div>
								</div>
							</div>
						</div>
						<button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-log-in"></span> Login</button>
						<button class="btn btn-default" type="reset"><span class="glyphicon glyphicon-remove"></span> Clear</button>
					<p align="right" class="text-primary"><i>เว็บไซต์นี้เหมาะสำหรับ : Browser IE 11 ขึ้นไป</i></p>
					<p align="right" class="text-primary"><i>Training-Module V.2</i></p>
					<p align="center" class="text-primary">Copyright © 2017 EA Team @ Deestone Co., Ltd</p>
					<p align="center" class="text-primary">Contact information :  IT_EA@deestone.com</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

	jQuery(document).ready(function($) {
		$('#username').val('').focus();

		$('#form_user_auth').on('submit', function(event) {
			event.preventDefault();
			gojax_f('post', '/api/v1/user/auths', '#form_user_auth')
			.done(function(data) {
				if (data.result === false) {
					swal("Login Failed!", "Please check E-mail and Password!", "error")
				} else {
					if (data.reset==0) {
						window.location = '/profile';
					}else{
						window.location = '/';
					}
				}
			});
		});

	});
	

</script>