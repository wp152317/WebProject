<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<script>
	function saveRecord(){
		var bd=document.getElementById('mBody');
		$('#myModal').modal('hide');
	}
</script>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
			</div>
			<div class="modal-body" id='mBody'></div>
			<div class="modal-footer">
				<button onclick='saveRecord()' type="button" class="btn btn-success">OK</button>
			</div>
		</div>
	</div>
</div>