
$(document).ready(function(){
	$('#updateUsername').submit(function(){
		//debugger;
		$.ajax({
			url:'update',
			type:'POST',
			dataType:'json',
			data: $('#updateUsername').serialize(),
			success:function(result){ 
				if(result.isValid){
					$('#displayName').html('Your name is: ' + result.username);
					$('#displayName').slideDown(500);
				}
				else {
					alert('Please enter a valid username !');
				}
			} 
		});
		return false;
	});
	
	
});