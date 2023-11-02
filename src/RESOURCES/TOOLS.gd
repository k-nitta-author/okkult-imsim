extends Resource

@export var name:= ""
@export var description:= ""
@export var strength:= ""
@export var uses:= -1


# called when an actor uses its equipped tool and calls its "interact" method
# e.g. a monster has as its equipped tool the shotgun, when it calls "interact"
# the code in this method is called, spawning a bullet and running calculations.
func use_tool():
    pass


# use this to log when a tool is used, where, and by whom
func log_tool_use(user: String, coords: Vector3, time: String):
    return "%s used tool: %s at %s on %s" % user % self.name % coords % time