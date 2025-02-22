class_name Api
extends Node

var apiName:String
var uri:String
var headers:PackedStringArray = []
var method:HTTPClient.Method = 0
var request:Callable

func _init(_apiName:String,_uri:String,_headers:PackedStringArray,_method:HTTPClient.Method,msgParams:Callable) -> void:
	uri = _uri
	headers = _headers
	method = _method
	request = msgParams
	apiName = _apiName

func Request(params:Array[String],rq:HTTPRequest):
	var msg = request.call(params,self)
	rq.request(msg)
