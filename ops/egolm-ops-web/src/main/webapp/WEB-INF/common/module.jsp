<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
var Ego = {};

Ego.success = function(msg, callback) {
	layer.alert(msg, {icon: 1}, function(index){
		layer.close(index);
		callback && callback();
	});
};
Ego.error = function(msg, callback) {
	layer.alert(msg, {icon: 2}, function(index){
		layer.close(index);
		callback && callback();
	});
};
Ego.alert = function(msg, callback) {
	layer.confirm(msg, {icon: 3, title:'提示'}, function(index){
		layer.close(index);
		callback && callback();
	});
};
Ego.dialog = function(msg, code, callback) {
	layer.alert(msg, {icon: code}, function(index){
		layer.close(index);
		callback && callback();
	});
};
</script>