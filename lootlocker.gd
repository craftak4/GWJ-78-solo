class_name LootLocker
extends Node

var HttpRequest:HTTPRequest
var Response
var Returner:Callable

const GameKey:String = "dev_d54145d3012c43a0baa5c54b0c60fe3d"
const Domain:String = "j7qpzwem"
const Version:String = "0.10.0.0"
var CurrentID:String

var Requests:Array[Api] = [
	Api.new("register",)
]

func GetRequest(apiName:String) -> Api:
	return Requests.filter(func(item:Api): return item.apiName == apiName)[0]

func _ready() -> void:
	PrepareRequest()


func Test():
	pass

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
