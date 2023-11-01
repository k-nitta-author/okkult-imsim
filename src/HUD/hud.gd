extends CanvasLayer


@onready
var position_label : Label = $position_label


func _ready():

    var actor = get_node("../ACTOR")

    actor.connect("motion_updated", test)


func test(message):


    position_label.set_text(message)