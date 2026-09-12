class_name BBCodeExtensions
extends Node

## Parsea extensões customizadas para o BBText [br]
##  - [code][Lumina][/code][br]
##  - [code][Umbra][/code][br]
static func parse(text: String) -> String:
	var parsed_text = (text
		.replacen("[lumina]", "[color=yellow]Lumina[/color]")
		.replacen("[umbra]", "[color=purple]Umbra[/color]")
	)
	return parsed_text
