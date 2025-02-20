class_name LootLocker
extends Node

var HttpRequest:HTTPRequest
var Response
var Returner:Callable

var Requests:Array[Api] = [
	Api.new(

func _ready() -> void:
	PrepareRequest()
func Test():


func PrepareRequest():
	HttpRequest = HTTPRequest.new()
	HttpRequest.connect("request_completed",completed)
	add_child(HttpRequest)

func Request(returner:Callable,uri:String):
	Returner = returner
	HttpRequest.request(uri)

func completed(result:int,resp:int,headers:PackedStringArray,body:PackedByteArray):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	Response = json.get_data()
	Returner.call(Response)
