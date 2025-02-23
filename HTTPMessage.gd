class_name HTTPMessage
extends Node

var Uri:String
var Headers:PackedStringArray
var Method:HTTPClient.Method
var Data:String

func _init(uri:String,headers:PackedStringArray,method:HTTPClient.Method,data:String) -> void:
	Uri = uri
	Headers = headers
	Method = method
	Data = data
