
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>


<script src="https://code.jquery.com/jquery-3.4.1.js"
	type="text/javascript"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
	function getPersons() {

					$('#tbl-person tr:gt(0)').remove();
		
					$.ajax({
					type : 'GET',
					dataType : 'JSON',
					url : '/RestfulServerExample/rest/service/getAllPersonsInJSON',
					success : function(result) {
						console.log(result);
						$.each(result,function(i, item) {
											var $tr = $('<tr>').append($('<td>').text(item.id),
													  $('<td>').text(item.fullName),
															$('<td>').text(item.age),
															$('<td>').html(
																			"<button type=\"button\" class=\"btn btn-success\""
																					+ "data-toggle=\"modal\" data-target=\"#updateModal\" onclick = 'veriCekme("
																					+ JSON
																							.stringify(item)
																					+ ")'>Update</button> | "
																					+ "<button type=\"button\" class=\"btn btn-danger\""
																					+ "data-toggle=\"modal\" data-target=\"#deleteModal\" onclick = 'deletePerson("
																					+ item.id
																					+ ")'>Delete</button>"));

											$tr.appendTo('#tbl-person');

										});
					}	

				});
	}

	function addPerson() {

		var formData = new FormData();

		formData.fullName = $('#personName').val();
		formData.age = $('#personAge').val();

		//var person = formData;
		
		if (formData.fullName == '' || formData.age == '') {

			swal({
				  title: "Fields empty !!",
				  text: "Please check the missing field",
				  icon: "warning",
				  button: "OK"
				});

			} else {

		var person = JSON.stringify(formData);

		console.log(person);

		$.ajax({
			type : 'POST',
			url : '/RestfulServerExample/rest/service/addPerson',
			dataType : 'application/json',
			contentType : 'application/json',
			data : person,
			success : function(result) {
				
				console.log(result);
			}
		});
		swal({
			  title: "Successfully submitted",
			  text: "You clicked the button!",
			  icon: "success",
			  button: "Aww yiss!"
			});
		getPersons();
	}
}

	function deletePerson(id) {

		var formData = new FormData();

		formData.id = id;

		var person = JSON.stringify(formData);
		console.log(person);

		swal({
			  title: "Are you sure?",
			  text: "Once deleted, you will not be able to recover this person!",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    swal("Poof! Your person has been deleted!", 
				{
			      icon: "success",
			    });

		$.ajax({
			url : '/RestfulServerExample/rest/service/deletePerson',
			type : 'POST',
			contentType : 'application/json',
			dataType : 'application/json',
			data : person,
			success : function(result) {
				console.log(result);
				
			},
			error : function(e) {
				console.log(e);
			}
		});
		getPersons();
			  } else {
			    swal("Your person is safe!");
			  }
			});
		
	}

	function veriCekme(item) {

		$('#personIDModal').val(item.id);
		$('#personNameModal').val(item.fullName);
		$('#personAgeModal').val(item.age);

	}

	function updatePerson() {

		var formData = new FormData();

		formData.id = $('#personIDModal').val();
		formData.fullName = $('#personNameModal').val();
		formData.age = $('#personAgeModal').val();

		var person = JSON.stringify(formData);
		console.log(person);

		$.ajax({
			type : 'POST',
			url : '/RestfulServerExample/rest/service/updatePerson',
			dataType : 'application/json',
			contentType : 'application/json',
			data : person,
			success : function(result) {

				console.log(result);
			}
		});
		
		swal("Good job!", "You changed the fields!", "success");
		
	}

	
</script>
</head>
<body class="container">

	<nav class="navbar navbar-dark bg-primary">
		<h2 style="color: white" class="navbar-brand mb-0 h2">Person
			Management System CRUD Using JSP AJAX</h2>
	</nav>


	<div class="row">

		<div class="col-sm-4">
			<div class="container">

				<br>

				<form id="formPerson" name="formPerson">

					<div class="form-group" align="left">
						<label><b>Person Full Name:</b></label><br> <input
							type="text" name="personName" id="personName"
							class="form-control" placeholder="Person Full Name">
					</div>

					<div class="form-group" align="left">
						<label><b>Person Age:</b></label><br> <input type="text"
							name="personAge" id="personAge" class="form-control"
							placeholder="Person Age">
					</div>

					<div class="form-group" align="center">

						<button type="button" class="btn btn-info" id="save"
							onclick="addPerson()">Add Person</button>
					</div>

					<br>

					<div class="form-group" align="center">
						<label><b>Fetch all records:</b></label><br>
						<button type="button" class="btn btn-warning" id="getAllPerson"
							onclick="getPersons()">Get All Person</button>

					</div>
				</form>
			</div>
		</div>

		<div class="col-sm-8">
			<br> <br>
			<div class="panel-boy">
				<table id="tbl-person" class="table table-bordered" cellpadding="0"
					cellspacing="0" width="100%">
					<thead align="center">
						<tr>
							<th>Person ID</th>
							<th>Person Full Name</th>
							<th>Person Age</th>
							<th>Actions</th>
						</tr>
					</thead>

				</table>
			</div>
		</div>

		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Update</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>


					<div class="modal-body">
						
						<input
							type="hidden" name="personIDModal" id="personIDModal"
							class="form-control"> 
						
						
						<label><b>Person Full Name:</b></label><br> <input
							type="text" name="personNameModal" id="personNameModal"
							class="form-control"> <br> <label><b>Person
								Age:</b></label><br> <input type="text" name="personAgeModal"
							id="personAgeModal" class="form-control">

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							onclick="updatePerson()" data-dismiss="modal">Save Changes</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>