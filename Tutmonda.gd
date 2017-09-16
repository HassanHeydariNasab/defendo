extends Node

var poentaro = 123456
var epoko = "nova"
var lingvo_elektita = null

func patro_nomo(korpo):
	var patro_nomo = korpo.get_parent().get_name().split("@")
	if patro_nomo.size() == 1:
		patro_nomo = patro_nomo[0]
	else:
		patro_nomo = patro_nomo[1]