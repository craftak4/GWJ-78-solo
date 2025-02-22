class_name Api
extends Node

var name:String
var uri:String
var headers:PackedStringArray = []
var method:Method = 0
var data:String

func _init(_uri:String,_headers:PackedStringArray,_method:Method,_data:String,msgParams:Callable) -> void:
	uri = _uri
	headers = _headers
	method = _method
	data = _data

func Request(params:Array[String],rq:HTTPRequest):
	var msg = request.call(params,self)
	rq.request(msg)

