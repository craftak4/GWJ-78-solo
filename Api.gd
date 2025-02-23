class_name Api
extends Node

var apiName:String
var request:Callable
var message:HTTPMessage

func _init(_apiName:String,_uri:String,_headers:PackedStringArray,_method:HTTPClient.Method, _data:String,msgParams:Callable) -> void:
	request = msgParams
	apiName = _apiName
	message = HTTPMessage.new(_uri,_headers,_method,_data)

func Request(params:Array[String],rq:HTTPRequest):
	var msg:HTTPMessage = request.call(params,self)
	if msg == null: msg = message
	print("====[[",apiName,"]] ")
	print(msg.Headers)
	print(msg.Data)
	print("====")
	rq.request(msg.Uri,msg.Headers,msg.Method,msg.Data)
