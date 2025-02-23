class_name LootLockerClass
extends Node

var HttpRequest:HTTPRequest
var Response
var Returner:Callable

const GameKey:String = "prod_88c58a3d0d1143da9ce6153c68052d4a"
const Domain:String = "j7qpzwem"
const Version:String = "0.10.0.0"
const MainLeaderboardID:String = "times"
const InkID:String = "01JMT8JNC914SHCVAQJY2AGZXP"
const RubbersID:Dictionary = {
	"AdvancedRubber" : "745770",
	"SuperRubber" : "745772",
}

var CurrentID:String
var CurrentWalletID:String
var CurrentToken:String
var NewAccountSession:bool = true

var Requests:Array[Api] = [
	Api.new("registerNew","https://api.lootlocker.io/game/v2/session/guest",["Content-Type: application/json"],HTTPClient.Method.METHOD_POST,"{\"game_key\": \"" + GameKey + "\", \"game_version\": \"" + Version + "\"}",func(params:Array[String],api:Api) -> HTTPMessage: return null),
	Api.new("registerExisting", "https://api.lootlocker.io/game/v2/session/guest",["Content-Type: application/json"],HTTPClient.Method.METHOD_POST,"", func(params:Array[String],api:Api): 
		var msg:HTTPMessage = api.message
		msg.Data = "{\"game_key\": \"" + GameKey + "\", \"player_identifier\": \"" + params[0] + "\", \"game_version\": \"" + Version + "\"}"
		return msg),
	Api.new("getLeaderboard","https://api.lootlocker.io/game/leaderboards/"+MainLeaderboardID+"/list?count=2000",[],HTTPClient.Method.METHOD_GET,"",func(p:Array[String],api:Api): 
		var msg:HTTPMessage = api.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		return msg),
	Api.new("submitLeaderboard","https://api.lootlocker.io/game/leaderboards/"+MainLeaderboardID+"/submit",["Content-Type: application/json"],HTTPClient.Method.METHOD_POST,"",func(p:Array[String],a:Api):
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Data = "{\"score\": \""+p[0]+"\", \"metadata\": \"\"}"
		return msg),
	Api.new("changeName","https://api.lootlocker.io/game/player/name",["LL-Version: 2021-03-01","Content-Type: application/json"],HTTPClient.Method.METHOD_PATCH,"",func(p:Array[String],a:Api):
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Data = "{\"name\": \"" + p[0] + "\"}"
		return msg),
	Api.new("walletBalance","https://api.lootlocker.io/game/balances/wallet/",[],HTTPClient.Method.METHOD_GET,"",func(p:Array[String],a:Api):
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Uri = msg.Uri + CurrentWalletID
		return msg),
	Api.new("walletCredit","https://api.lootlocker.io/game/balances/credit",[],HTTPClient.Method.METHOD_POST,"",func(p:Array[String],a:Api): 
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Data = "{\"amount\": \""+p[0]+"\", \"wallet_id\": \""+CurrentWalletID+"\", \"currency_id\": \""+InkID+"\"}"
		return msg),
	Api.new("walletDebit","https://api.lootlocker.io/game/balances/debit",[],HTTPClient.Method.METHOD_POST,"",func(p:Array[String],a:Api): 
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Data = "{\"amount\": \""+p[0]+"\", \"wallet_id\": \""+CurrentWalletID+"\", \"currency_id\": \""+InkID+"\"}"
		return msg),
	Api.new("inv","https://api.lootlocker.io/game/v1/player/inventory/list",[],HTTPClient.Method.METHOD_GET,"",func(p:Array[String],a:Api):
		var msg:HTTPMessage = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		return msg),
	Api.new("invGrant","https://api.lootlocker.io/game/player/inventory/grant",["Content-Type: application/json"],HTTPClient.Method.METHOD_POST,"",func(p:Array[String],a:Api): 
		var msg = a.message
		msg.Headers.append("x-session-token: " + CurrentToken)
		msg.Data = "{\"asset_id\": "+p[0]+", \"asset_variation_id\": 1, \"asset_rental_option_id\": 1}"
		return msg)
]

#4a5c1021-d561-4734-9b84-55d67fe9c6e7

func GetRequest(apiName:String) -> Api:
	return Requests.filter(func(item:Api): return item.apiName == apiName)[0]

func _ready() -> void:
	PrepareRequest()
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	#Test()

func Test():
	Returner = func(resp): 
		CurrentToken = resp["session_token"]
		CurrentWalletID = resp["wallet_id"]
		Returner = func(r): 
			Returner = func(rr): return
			GetRequest("inv").Request([],HttpRequest)
		GetRequest("invGrant").Request([RubbersID["AdvancedRubber"]],HttpRequest)
	GetRequest("registerExisting").Request(["4a5c1021-d561-4734-9b84-55d67fe9c6e7"],HttpRequest)

func PrepareRequest():
	HttpRequest = HTTPRequest.new()
	HttpRequest.connect("request_completed",completed)
	add_child(HttpRequest)

func completed(result:int,resp:int,headers:PackedStringArray,body:PackedByteArray):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	Response = json.get_data()
	print_rich("[color=orange]"+str(Response))
	Returner.call_deferred(Response)
	#Returner = func(resp): return
