# The Basics

The basic code file needs a function called Update that takes an input called I. It should look like this-

```
function Update(I)
-- put your code here 
end
```

'I' is the interface to the game and contains all the function calls you see on these help pages.

The code in Update will be executed every single physics step (the game runs at 40 physics steps per in game second of time)

-- creates a comment line so the line '-- put your code here' is never executed by the game. Comments are for explaining how your code functions.

Here is a simple example of a function that uses one of the interface functions to write 'Hello' to the HUD

```
function Update(I)
 I:Log('Hello') 
end
```

# LUA Syntax

## String Concatenation

String Concatenation is done with ..   i.e 'Hello' .. ' Player'   creates 'Hello Player'. Numbers are automatically converted to strings.

## For loops

For loops (in this example looping from 0 to 10 in increments of 1) use:

```
for ii=0,10,1 do
 -- your code here (note that we don't need to define the step size of 1.. 1 is the default anyway)
 end
```

## Calling functions

The colon (:) is used for calling functions. This is why all calls to the interface start with I:  (i.e. I:RequestWaterForwards(5))

## Comments

-- creates a comment. So this line, in LUA, would be a comment

## Global variables

Declare a variable outside of your Update function and it will be persistent from call to call, the example below will log the counter to the Log forever (1,2,3,4,5,etc).

```
count = 0 ;
function MyUpdateFunction()
count = count + 1 ;
I:Log(count);
 end
```

## If Statements

To conditionally execute some code you can use an if statement. In this example we only execute the line if 'a' is greater than 0.:

```
if a>0 then
-- your code here
end
```

# Logging and Messages

### `I:Log(message)`

```
inputs
-----
message: [string] the message you want to write to the log.

outputs
-------
N/A
```

Writes a message to the log. Log is visible when editing the LUA box and appears in the 'Errors / Log' panel. The last 100 log messages are maintained.


### `I:ClearLogs()`

```
inputs
-----
N/A

outputs
-------
N/A
```

Clears your log. Pretty harmless!


### `I:LogToHud(message)`

```
inputs
-----
message: [string] the message you want to write to the HUD.

outputs
-------
N/A
```

Writes a message to the HUD. HUD messages are visible during normal play and when on the map.


# Libraries

## Mathf

The Mathf Library is full of functions you can google. Each function is statically called so use Mathf.Min(1,2) rather than Mathf:Min(1,2).

## Vector3

Unity's Vector3 library is full exposed to you. You can create a new Vector3 with v =  Vector3(x,y,z), and call functions such as Vector3.Angle(v1,v2). Google Unity Vector3 for more information on this library

## Quaternion

Unity's Quaternion library is fully exposed to you also. Google it to find out more

# Fleet

The Fleet Awareness API provides scripts basic information about the fleet the craft is in.

### `I.FleetIndex` (read only)

```
outputs
-------
[int] Position of the ship in the fleet, starting from 0.
```

Returns the index of the ship in the fleet.  Starts at 0.


### `I.Fleet` (read only)

```
outputs
-------
[FleetInfo] Information about the fleet
```

Returns the current state of the fleet.


### `I.IsFlagship` (read only)

```
outputs
-------
[bool] Is the craft the fleet flagship?
```

Used to determine whether the ship is a flagship of a fleet.


### struct `FleetInfo`
```
ID:[int] Unique ID of the fleet.
Name:[string] Name of the fleet.
Flagship: [FriendlyInfo] Information about the flagship of the fleet.
Members: [FriendlyInfo[]] A table of information regarding the fleet's members.  MAY CONTAIN NILS!
```


# Resources

Scripts can use the following fields to get information about known resource zones.  May change in the future to require a detector.

### `I.ResourceZones` (read only)

```
outputs
-------
[ResourceZoneInfo[]] List of ResourceZones
```

Returns a Lua table containing a list of known resource zones.


### `I.Resources` (read only)

```
outputs
-------
[ResourceInfo] Ship resource data
```

Returns information about a ship's available resources.


### struct `ResourceZoneInfo`
```
Id [int]: Unique ID of the Resource Zone
Name [string]: Name of the Resource Zone
Position [Vector3]: Position of the Resource Zone
Radius [float]: Radius of the Resource Zone
Resources [ResourceInfo]: Available resources of the Resource Zone
```


### struct `ResourceInfo`
```
CrystalTotal [float]: Total Crystal resources.
CrystalMax [float]: Max Crystal resources.
MetalTotal [float]: Total Metal resources.
MetalMax [float]: Max Metal resources.
NaturalTotal [float]: Total Natural resources.
NaturalMax [float]: Max Natural resources.
OilTotal [float]: Total Oil resources.
OilMax [float]: Max Oil resources.
ScrapTotal [float]: Total Scrap resources.
ScrapMax [float]: Max Scrap resources.
```


# AI

### `I:GetAIMovementMode(index)`

```
inputs
-----
index: [int] index of the AI mainframe

outputs
-------
[string] movement mode of the AI mainframe. Possible modes: Off, Manual, Automatic, Fleet
```

returns the movement mode of the AI mainframe specified by the index


### `I:GetAIFiringMode(index)`

```
inputs
-----
index: [int] index of the AI mainframe

outputs
-------
[string] firing mode of the AI mainframe. Possible modes: Off, On
```

returns the firing mode of the AI mainframe specified by the index


### `I.AIMode - Obsolete, please use 'GetAIMovementMode' instead` (read only)

```
outputs
-------
[string] Returns the mode of the AI.  Possible modes: off, on
```

Returns the mode of the AI mainframe.


### `I.ConstructType - obsolete`

```
outputs
-------
[string] The type of construct.
```

AI's concept of what type of craft this ship is. Posible types: none


# Using Propulsion

### `I:TellAiThatWeAreTakingControl()`

```
inputs
-----


outputs
-------

```

Will stop the AI from issuing propulsion commands for the next second, after which it will assume control again. This is exactly what happens when the player presses a control key on an AI controlled vehicle.


### `I:AddPropulsionRequest(type, drive)`

```
inputs
-----
type: Main = 0, Secondary = 1, Tertiary = 2 , Roll = 3, Pitch = 4, Yaw = 5, Forwards = 6, Up = 7, Right = 8, A = 9, B = 10, C = 11, D = 12, E = 13]
drive: [float] the amount to add to the axis

outputs
-------
N/A
```

Adds a propulsion request to the specified axis. This is additive to any other requests made to the axis in the same frame and is clamped between -1 and 1


### `I:SetPropulsionRequest(type, drive)`

```
inputs
-----
type: Main = 0, Secondary = 1, Tertiary = 2 , Roll = 3, Pitch = 4, Yaw = 5, Forwards = 6, Up = 7, Right = 8, A = 9, B = 10, C = 11, D = 12, E = 13]
drive: [float] the amount the axis is set to

outputs
-------
N/A
```

Sets the propulsion request to the specified axis. This overwrites any other requests made to the axis in the same frame and is clamped between -1 and 1


### `I:GetPropulsionRequest(type)`

```
inputs
-----
type: Main = 0, Secondary = 1, Tertiary = 2 , Roll = 3, Pitch = 4, Yaw = 5, Forwards = 6, Up = 7, Right = 8, A = 9, B = 10, C = 11, D = 12, E = 13]

outputs
-------
N/A
```

Gets the sum of all requests made to the specified axis in the previous frame or reads the value that the drive is set to if the type is Main, Secondary or Tertiary


### `I:RequestComplexControllerStimulus(stim)`

```
inputs
-----
stim: none = 0,T =1,G =2 ,Y =3,H =4,U =5,J =6,I =7,K =8,O= 9,L =10,up=11,down=12,left=13,right=14

outputs
-------
N/A
```

Requests a stimuli as per the complex controller block.


### `I:MoveFortress`

```
inputs
-----
direction [Vector3]:  Direction to move the fortress in.  Limited to 1 meter.

outputs
-------
N/A
```

Move fortress in any direction.  Limited to 1 meter.


### `I:RequestCustomAxis(axisName,drive)`

```
inputs
-----
axisName [string]: name of axis to create/use. Limited to 32 characters.
drive [float]: value to add to the axis on this frame.

outputs
-------
N/A
```

Creates or uses an axis with a custom name. Adds a value to the axis. Axes values are limited to between -1 and 1. Axes names are limited to 32 characters.


### `I:GetCustomAxis(axisName)`

```
inputs
-----
axisName [string]: name of axis to get value for.

outputs
-------
The value of the axis as a float. 0 if axis not created yet.
```

Returns the value of the named axis that it had the previous frame, or 0 if axis not created yet.


# Accessing Target Info

### `I:GetNumberOfMainframes()`

```
inputs
-----
N/A

outputs
-------
The number of mainframes on your vehicle.
```

The mainframe count of your vehicle is useful for requesting targets


### `I:GetNumberOfTargets(mainframeIndex)`

```
inputs
-----
mainframeIndex: 0 being the first mainframe. Use GetNumberOfMainframes() to find out how many there are.

outputs
-------
The number of targets in this particular mainframe. Returns 0 if such a mainframe does not exist.
```

The target count is important when calling GetTarget(mainframeIndex, targetIndex).


### `I:GetTargetInfo(mainframeIndex, targetIndex)`

```
inputs
-----
mainframeIndex: 0 being the first mainframe. Use GetNumberOfMainframes() to find out how many there are.
targetIndex: 0 being the first target. If target prioritisation card is in use 0 is the highest priority target.

outputs
-------
A TargetInfo object
```

The TargetInfo object contains many interesting variables relating to the target. Valid will be false if the target has died but the AI has not yet cleared it.


### struct `TargetInfo`
```
Valid: [bool] true if a target was correctly returned
Priority: [int] 0 is highest priority
Score: [float] high is a good score- taken from target prioritisation card
AimPointPosition: [Vector3] position in game world of aim point (this is the current position of the block that's being aimed for)
Team: [int] team of target
Protected: [bool] is it salvage? Will be false for salvage.
Position: [Vector3] position in game world of target object.
Velocity: [Vector3] velocity in game world in meters per second
PlayerTargetChoice: [bool] has the player set this as the target?
Id: [int] the unique integer Id of the target.
```


### `I:GetTargetPositionInfo(mainframeIndex, targetIndex)`

```
inputs
-----
mainframeIndex: 0 being the first mainframe. Use GetNumberOfMainframes() to find out how many there are.
targetIndex: 0 being the first target. If target prioritisation card is in use 0 is the highest priority target.

outputs
-------
A TargetPositionInfo object
```

The TargetPositionInfo object contains many interesting variables relating to the target. Valid will be false if the target has died but the AI has not yet cleared it.


### `I:GetTargetPositionInfoForPosition(mainframeIndex, x,y,z)`

```
inputs
-----
mainframeIndex: [int] 0 being the first mainframe. Use GetNumberOfMainframes() to find out how many there are.
x: [float] east west in meters.
y: [float] up down in meters (0 is sea level).
z: north south in meters.

outputs
-------
A TargetPositionInfo object for this point in space. Velocity will be 0.
```

The TargetPositionInfo object contains many interesting variables relating to the target.


### struct `TargetPositionInfo`
```
Valid: [bool] true if target position info correctly returned.
Azimuth: [float] degrees off nose of our vehicle where positive is clockwise
Elevation: [float] degrees off nose of our vehicle where positive is downwards. This often has dodgy values
ElevationForAltitudeComponentOnly: [float] the elevation off nose of the target's altitude. Robustly calculated
Range: [float] the range to the target
Direction: [Vector3] the direction to the target (absolute, not normalised)
GroundDistance: [float] the distance along the ground (ignoring vertical component) to the target
AltitudeAboveSeaLevel: [float] in metres.
Position: [Vector3] position of target
Velocity: [Vector3] meters per second
```


# Misc Functions

### `I:GetTerrainAltitudeForPosition(x,y,z)`

```
inputs
-----
x: [float] game world east west position in meters.
y: [float] game world vertical (not important)
z: game world north south position in meters.

outputs
-------
[float] the terrain altitude in meters where 0 is sea level.
```

Returns altitude of the terrain at a position in the world. Can be overloaded with a single Vector3 rather than x,y,z components.


### `I:GetTerrainAltitudeForLocalPosition(x,y,z)`

```
inputs
-----
x: [float] right offset from construct position in meters.
y: [float] up offset from construct position in meters
z: forwards offset from construct position in meters.

outputs
-------
[float] the terrain altitude in meters where 0 is sea level.
```

Returns altitude of the terrain at a position relative to the construct. Can be overloaded with a single Vector3 rather than x,y,z components.


### `I:GetGravityForAltitude(alt)`

```
inputs
-----
alt: [float] altitude (0 is sea level)

outputs
-------
[Vector3] gravity vector
```

Returns gravity vector for an altitude. gravity.y is the component of interest.


### `I:GetTime()`

```
inputs
-----
N/A

outputs
-------
[float] the time in seconds.
```

Returns time with an arbitrary offset (i.e. the time will seldom be 0).


### `I:GetTimeSinceSpawn()`

```
inputs
-----
N/A

outputs
-------
[float] the time in seconds since the construct spawned.
```

Returns time since construct spawned in seconds.


### `I:GetGameTime()`

```
inputs
-----
N/A

outputs
-------
[float] The time since the Instance started in seconds.
```

Returns time since the instance started in seconds..


### `I:GetWindDirectionAndMagnitude()`

```
inputs
-----
N/A

outputs
-------
[Vector3] Vector representing the direction and the magnitude of the wind.
```

Get the direction and magnitude of the current wind.


# Self awareness

### `I:GetConstructPosition()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The position (Vector3 has members x, y, and z).
```

Returns the position of the construct. The construct's position is essentially the position of the first ever block placed, or the centre of the starting raft that it was built from.


### `I:GetConstructForwardVector()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The forward pointing vector of the construct (it has length 1)
```

Return the forward pointing vector of the construct


### `I:GetConstructRightVector()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The right pointing vector of the construct (it has length 1)
```

Return the right pointing vector of the construct


### `I:GetConstructUpVector()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The up pointing vector of the construct (it has length 1)
```

Return the up pointing vector of the construct


### `I:GetConstructMaxDimensions()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The size of the vehicle right, up and forwards of its origin
```

Returns the 'positive' size of the vehicle (right,up,forwards) relative to its origin (GetConstructPosition()). The coordinates are in local space. This minus GetConstructMinDimensions() provides the full size of the vehicle.


### `I:GetConstructMinDimensions()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The size of the vehicle left, down and back of its origin
```

Returns the 'negative' size of the vehicle (left,down,back) relative to its origin (GetConstructPosition()). The coordinates are in local space.


### `I:GetConstructRoll()`

```
inputs
-----
N/A

outputs
-------
[float] The roll angle in degrees
```

Return the roll angle in degrees


### `I:GetConstructPitch()`

```
inputs
-----
N/A

outputs
-------
[float] The pitch angle in degrees
```

Return the pitch angle in degrees


### `I:GetConstructYaw()`

```
inputs
-----
N/A

outputs
-------
[float] The yaw angle in degrees
```

Return the yaw angle in degrees


### `I:GetConstructCenterOfMass()`

```
inputs
-----
N/A

outputs
-------
[Vector3] The position (Vector3 has members x, y, and z).
```

Returns the position of the construct's centre of mass in the world


### `I:GetAiPosition(mainframeIndex)`

```
inputs
-----
mainframeindex: [int] 0 is the first mainframe.

outputs
-------
[Vector3] The position (Vector3 has members x, y, and z).
```

Returns the position of the mainframe in the world. Returns Vector3(0,0,0) if no such mainframe exists.


### `I:GetVelocityMagnitude()`

```
inputs
-----
N/A

outputs
-------
[float] magnitude of your velocity in meters per second.
```

Returns the magnitude of your velocity in meters per second.


### `I:GetForwardsVelocityMagnitude()`

```
inputs
-----
N/A

outputs
-------
[float] magnitude of your forwards velocity in meters per second.
```

Returns the magnitude of your velocity in the forwards direction in meters per second. A negative value means you're going predominently backwards.


### `I:GetVelocityVector()`

```
inputs
-----
N/A

outputs
-------
[Vector3] Your construct's velocity vector in meters per second
```

Returns your construct's velocity vector in world space in meters per second. x is east west, y is up down and z is north south..


### `I:GetVelocityVectorNormalized()`

```
inputs
-----
N/A

outputs
-------
[Vector3] Your construct's velocity vector in meters per second- normalized to have a length of 1.
```

Returns your construct's velocity vector in world space in meters per second. x is east west, y is up down and z is north south. It's normalized to have a length of 1.


### `I:GetAngularVelocity()`

```
inputs
-----
N/A

outputs
-------
[Vector3] Your construct's angular velocity in world space
```

Returns your angular velocity. x is speed of turn around the east->west axis, y is around the vertical axis and z is around the north south axis. You're probably going to want the next function instead of this one...


### `I:GetLocalAngularVelocity()`

```
inputs
-----
N/A

outputs
-------
[Vector3] Your construct's angular velocity in local space
```

Returns your angular velocity. x is pitch, y yaw and z roll. 


### `I:GetAmmoFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1. 1 if no ammo storage is available
```

Returns the fraction of ammo your construct has left


### `I:GetFuelFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1. 1 if no fuel storage is available
```

Returns the fraction of fuel your construct has left


### `I:GetSparesFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1. 1 if no spares storage is available
```

Returns the fraction of spares your construct has left


### `I:GetEnergyFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1. 1 if no batteries are available
```

Returns the fraction of energy your construct has left


### `I:GetPowerFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1
```

Returns the fraction of power your construct has left


### `I:GetElectricPowerFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1.
```

Returns the fraction of electric power your construct has left


### `I:GetHealthFraction()`

```
inputs
-----
N/A

outputs
-------
[float] fraction. 0 to 1. 1 if full health
```

Returns the fraction of health your construct has (including turrets etc)


### `I:IsDocked()`

```
inputs
-----
N/A

outputs
-------
[bool] Docked? true for yes.
```

Returns true if the vehicle is docked


### `I:GetHealthFractionDifference(time)`

```
inputs
-----
time[float]: the time you want the difference measured over. Time will be limited to be between 1 and 30.

outputs
-------
[float] health difference as a fraction (0 to 1)
```

Returns health difference over a specified measurement time


### `I:GetBlueprintName()`

```
inputs
-----
N/A

outputs
-------
[string] name of the bluepritn.
```

Returns the the name of this blueprint.


### `I:GetUniqueId()`

```
inputs
-----
N/A

outputs
-------
[int] the unique id.
```

Returns the the unique id of this construct. No other construct has the same id.


# Components

## Types

### struct `Component types and their logic.`
```
 0 = balloon deployer
	bool 0  	get     	Get whether the balloon is deployed.
       	 	set     	True to deploy the balloon. False to sever the balloon.
 1 = drive maintainer
	int 0   	get/set 	Get/set the channel of the drive mainainer (0 = Primary, 1 = Secondary, 2 = Tertiary).
	float 0 	get/set 	Get/set the drive that the drive maintainer is set to.
 2 = all pumps (helium and air)
	bool 0  	get     	Get whether the pump is on (buoyancy fraction > 0).
       	 	set     	False sets buoyance fraction to 0. True sets buoyancy fraction to 1.
	float 0 	get/set 	Get/set buoyancy fraction.
	float 1 	get     	Get fraction of volume that is flooded.
 3 = resource gatherer
	bool 0  	get/set 	On/off.
 4 = oil drill.
	bool 0  	get/set 	On/off.
 5 = ammo processor
	bool 0  	get/set 	On/off.
 6 = fuel refinery.
	bool 0  	get/set 	On/off.
	float 0 	get     	Get dangerous gas level.
	float 1 	get     	Get refining efficiency.
	float 2 	get     	Get time per batch.
 7 = tractor beams
	bool 0  	get/set 	On/off.
	int 0   	get     	Get the unique id of the selected vehicle. -1 if nothing is selected.
       	 	set     	Select the vehicle with the specified unique id.
	float 0 	get/set 	Get/set hold distance.
	float 1 	get/set 	Get/set hold azimuth.
	float 2 	get/set 	Get/set hold elevation.
 8 = hydrofoils
	float 0 	get/set 	Get/set angle.
 9 = propulsion
	float 0 	get/set 	Get/set drive fraction.
	float 1 	get     	Get propulsion requests to this component so far this frame.
       	 	set     	Add a propulsion request to this component.
	float 2 	get     	Get total propulsion request to this component last frame.
	float 3 	get     	Max force of this component.
10 = shield projector
	bool 0  	get     	Get whether the shield is functioning.
	int 0   	get/set 	Get/set the shield type (0 = off, 1 = reflect, 2 = disrupt, 3 = laser absorb).
	float 0 	get/set 	Get/set strength.
	float 1 	get/set 	Get/set azimuth.
	float 2 	get/set 	Get/set elevation.
	float 3 	get/set 	Get/set range.
	float 4 	get/set 	Get/set width.
	float 5 	get/set 	Get/set height.
	float 6 	get/set 	Get/set alpha.
	float 7 	get/set 	Get/set red.
	float 8 	get/set 	Get/set green.
	float 9 	get/set 	Get/set blue.
11 = helium pump
	bool 0  	get     	Get whether the airpump is on (buoyancy fraction > 0).
       	 	set     	False sets buoyance fraction to 0. True sets buoyancy fraction to 1.
	float 0 	get/set 	Get/set buoyancy fraction.
	float 1 	get     	Get fraction of volume that is flooded.
12 = spotlight
	float 0 	get/set 	Get/set cone angle.
	float 1 	get/set 	Get/set azimuth angle.
	float 2 	get/set 	Get/set elevation angle.
	float 3 	get/set 	Get/set intensity.
	float 4 	get/set 	Get/set range.
	float 5 	get/set 	Get/set red.
	float 6 	get/set 	Get/set green.
	float 7 	get/set 	Get/set blue.
13 = advanced cannon laser targetter
	int 0   	get     	Get the weapon index of the firing piece it is attached to. -1 otherwise.
	float 0 	get/set 	Get/set timed fuse time.
	float 1 	get     	Get altitude fuse 'low' altitude.
       	 	set     	Set altitude fuse altitude.
	float 2 	get     	Get altitude fuse 'high' altitude.
14 = CRAM cannon laser targetter
	int 0   	get     	Get the weapon index of the firing piece it is attached to. -1 otherwise.
	float 0 	get/set 	Get/set timed fuse time.
	float 1 	get     	Get altitude fuse 'low' altitude.
       	 	set     	Set altitude fuse altitude.
	float 2 	get     	Get altitude fuse 'high' altitude.
15 = warp drive
	bool 0  	get     	Is charging.
	int 0   	set     	0 = start charging, 1 = warp.
	float 0 	get     	Right jump distance.
	float 1 	get     	Up jump distance.
	float 2 	get     	Forwards jump distance.
	float 3 	get     	Right jump factor based on vehicle size and warp rod size.
	float 4 	get     	Up jump factor.
	float 5 	get     	Forwards jump factor.
	float 6 	get     	Total length of attached chargers.
	float 7 	get     	Charge duration.
16 = particle cannon lense
	int 0   	get     	Get the weapon index of the firing piece it is attached to. -1 otherwise.
17 = steam boiler controller
	float 0 	get/set 	Get/set burn rate.
	float 1 	get     	Volume of attached boiler.
	float 2 	get     	Pressure of attached boiler.
18 = fuel engine generator
	float 0 	get/set 	Get/set max relative rpm.
	float 1 	get/set 	Get/set battery charge drive.
	float 2 	get     	Current relative rpm.
	float 3 	get     	Estimate of maximum power.
	float 4 	get     	Fuel usage per second.
19 = sail main block
	int 0   	get     	Get the sail type (0 = three point sail, 1 = square rigged sail).
	float 0 	get     	Mast winch setting.
       	 	set     	Winch mast towards this setting.
	float 1 	get     	Boom winch setting.
       	 	set     	Winch boom towards this setting.
	float 2 	get     	Mast height.
	float 3 	get     	Boom length.
20 = advanced cannon ammo intake
	int 0   	get     	Get unique id of the associated ammo controller. -1 otherwise.
       	 	set     	Select an ammo controller by its unique id.
	int 1   	get     	Get component index of the associated ammo controller. -1 otherwise.
       	 	set     	Select an ammo controller by its component index.
	int 2   	get     	Get the weapon index of the firing piece it is attached to. -1 otherwise.
21 = advanced cannon ammo controller
	int 0   	get     	Get unique id.
22 = AI wireless transmitter
	int 0   	get/set 	Get/set channel.
23 = AI wireless receiver
	int 0   	get/set 	Get/set channel.
24 = AI aimpoint selection card
	int 0   	get/set 	Get/set aimpoint selection type (0 = random, 1 = ammo and AI).
	float 0 	get/set 	Get/set retarget time.
25 = detection component
	bool 0  	get/set 	On/off.
26 = AI mainframe
	int 0   	get/set 	AI movement mode (0 = Off, 1 = Manual, 2 = Automatic, 3 = Fleet).
	int 1   	get/set 	AI firing mode (0 = Off, 1 = On).
27 = laser colorer
	float 0 	get/set 	Get/set red.
	float 1 	get/set 	Get/set green.
	float 2 	get/set 	Get/set blue.
28 = laser missile defence
	float 0 	get/set 	Get/set red.
	float 1 	get/set 	Get/set green.
	float 2 	get/set 	Get/set blue.
29 = particle cannon
	float 0 	get/set 	Get/set red.
	float 1 	get/set 	Get/set green.
	float 2 	get/set 	Get/set blue.
30 = light fitting
	float 0 	get/set 	Get/set intensity.
	float 1 	get/set 	Get/set range.
	float 2 	get/set 	Get/set red.
	float 3 	get/set 	Get/set green.
	float 4 	get/set 	Get/set blue.
31 = simple laser
	float 0 	get/set 	Get/set red.
	float 1 	get/set 	Get/set green.
	float 2 	get/set 	Get/set blue.
32 = smoke generator
	float 0 	get/set 	Get/set particle speed.
	float 1 	get/set 	Get/set particle size.
	float 2 	get/set 	Get/set red.
	float 3 	get/set 	Get/set green.
	float 4 	get/set 	Get/set blue.
33 = hologram projector
	bool 0  	get/set 	On/off.
	bool 1  	get/set 	Get/set whether the image is mirrored.
	float 0 	get/set 	Get/set width.
	float 1 	get/set 	Get/set height.
	float 2 	get/set 	Get/set distance.
	float 3 	get/set 	Get/set right translation.
	float 4 	get/set 	Get/set up translation.
	float 5 	get/set 	Get/set aizumth.
	float 6 	get/set 	Get/set elevation.
	float 7 	get/set 	Get/set rotation.
34 = poster holder
	float 0 	get/set 	Get/set width.
	float 1 	get/set 	Get/set height.
35 = electric engine
	float 0 	get/set 	Get/set power fraction.
36 = steam boiler controller
	float 0 	get/set 	Get/set burn rate.
	float 1 	get     	Get storage module pressure.
 37 = air pump
	bool 0  	get     	Get whether the airpump is on (buoyancy fraction > 0).
       	 	set     	False sets buoyance fraction to 0. True sets buoyancy fraction to 1.
	float 0 	get/set 	Get/set buoyancy fraction.
	float 1 	get     	Get fraction of volume that is flooded.
```


### struct `BlockInfo`
```
Valid:[bool] false means this BlockInfo packet is useless
Position:[Vector3] position in world (east,up,north)
LocalPosition:[Vector3] position in construct (right,up,forwards)
LocalPositionRelativeToCom:[Vector3] local position relative to the center of mass
Forwards:[Vector3] forwards direction in world(east,up,north)
LocalForwards:[Vector3] forward direction in construct (right,up,forwards)
Rotation:[Quaternion] the rotation of the block in world coordinates
LocalRotation:[Quaternion] the rotation of the block in the vehicle's (or turret's) coordinate system.
SubConstructIdentifier:[int] the sub construct identifier of the subconstruct the block is part of.
CustomName:[string] the custom name assigned to the block
```


## Interface Functions / Methods

### `I:Component_GetCount(type)`

```
inputs
-----
type: [int] the type of component you want the count of.

outputs
-------
[int] the number of components of this type.
```

Returns the number of components of this type


### `I:Component_GetLocalPosition(type,index)`

```
inputs
-----
type: [int] the type of component you want the local position of.
index: [int] the index of the component you want the position of.


outputs
-------
[Vector3i] a Vector3i is a Vector3 where .x .y and .z are integers.
```

Returns the local position in the vehicle of this component.


### `I:Component_GetBlockInfo(type,index)`

```
inputs
-----
type: [int] the type of component you want information on.
index: [int] the index of the component you want block info for..


outputs
-------
[BlockInfo] a BlockInfo structure relating to the component.
```

Returns an extensive BlockInfo object for the component.


### `I:Component_GetBoolLogic(type, blockIndex)`

```
inputs
-----
type: [int] the type of component you want boolean logic for.
blockIndex: [int] the index of the component you want boolean logic for.


outputs
-------
[bool] the first boolean logic for this component. For a component without boolean logic, or a block index that doesn't exist, false is returned.
```

Returns a boolean (true/false) for a component. Depending on the type of this component this means different things (or nothing at all). Default return is false.


### `I:Component_GetBoolLogic_1(type, blockIndex, propertyIndex)`

```
inputs
-----
type: [int] the type of component you want boolean logic for.
blockIndex: [int] the index of the component you want boolean logic for.
propertyIndex: [int] the index of the index of the boolean logic you want.

outputs
-------
[bool] the specified boolean logic for this component. For a component without boolean logic, or an index that doesn't exist, false is returned.
```

Returns a boolean (true/false) for a component. Depending on the type of this component this means different things (or nothing at all). Default return is false.


### `I:Component_SetBoolLogic(type,index,bool)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
index: [int] the index of the component you want to set boolean logic for.
bool: [bool] the true/false you want to set.

outputs
-------
N/A
```

Sets the first boolean logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogic_1(type, blockIndex, propertyIndex1, bool1)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
blockIndex: [int] the index of the component you want to set boolean logic for.
propertyIndex1: [int] the index of the boolean logic you want to set.
bool1: [bool] the true/false you want to set.

outputs
-------
N/A
```

Sets the specified boolean logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogic_2(type, blockIndex, propertyIndex1, bool1, propertyIndex2, bool2)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
blockIndex: [int] the index of the component you want to set boolean logic for.
propertyIndex1: [int] the index of the first boolean logic you want to set.
bool1: [bool] the true/false you want to set the first logic to.
propertyIndex2: [int] the index of the second boolean logic you want to set.
bool2: [bool] the true/false you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified boolean logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogic_3(type, blockIndex, propertyIndex1, bool1, propertyIndex2, bool2, propertyIndex3, bool3)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
blockIndex: [int] the index of the component you want to set boolean logic for.
propertyIndex1: [int] the index of the first boolean logic you want to set.
bool1: [bool] the true/false you want to set the first logic to.
propertyIndex2: [int] the index of the second boolean logic you want to set.
bool2: [bool] the true/false you want to set the second logic to.
propertyIndex3: [int] the index of the third boolean logic you want to set.
bool3: [bool] the true/false you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified boolean logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_GetFloatLogic(type, blockIndex)`

```
inputs
-----
type: [int] the type of component you want float logic for.
blockIndex: [int] the index of the component you want float logic for.


outputs
-------
[float] the first float logic for this component. For a component without float logic, or a block index that doesn't exist, 0 is returned.
```

Returns a floating point value for a component. Depending on the type of this component this means different things (or nothing at all). Default return is 0.


### `I:Component_GetFloatLogic_1(type, blockIndex, propertyIndex)`

```
inputs
-----
type: [int] the type of component you want float logic for.
blockIndex: [int] the index of the component you want float logic for.
propertyIndex: [int] the index of the index of the float logic you want.

outputs
-------
[float] the specified float logic for this component. For a component without float logic, or an index that doesn't exist, 0 is returned.
```

Returns a floating point value for a component. Depending on the type of this component this means different things (or nothing at all). Default return is 0.


### `I:Component_SetFloatLogic(type,index,float)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
index: [int] the index of the component you want to set float logic for.
float: [float] the floating point value you want to set.

outputs
-------
N/A
```

Sets the first float logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogic_1(type, blockIndex, propertyIndex1, float1)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
blockIndex: [int] the index of the component you want to set float logic for.
propertyIndex1: [int] the index of the float logic you want to set.
float1: [float] the floating point value you want to set.

outputs
-------
N/A
```

Sets the specified float logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogic_2(type, blockIndex, propertyIndex1, float1, propertyIndex2, float2)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
blockIndex: [int] the index of the component you want to set float logic for.
propertyIndex1: [int] the index of the first float logic you want to set.
float1: [float] the floating point value you want to set the first logic to.
propertyIndex2: [int] the index of the second float logic you want to set.
float2: [float] the floating point value you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified float logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogic_3(type, blockIndex, propertyIndex1, float1, propertyIndex2, float2, propertyIndex3, float3)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
blockIndex: [int] the index of the component you want to set float logic for.
propertyIndex1: [int] the index of the first float logic you want to set.
float1: [float] the floating point value you want to set the first logic to.
propertyIndex2: [int] the index of the second float logic you want to set.
float2: [float] the floating point value you want to set the second logic to.
propertyIndex3: [int] the index of the third float logic you want to set.
float3: [float] the floating point value you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified float logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_GetIntLogic(type, blockIndex)`

```
inputs
-----
type: [int] the type of component you want int logic for.
blockIndex: [int] the index of the component you want int logic for.


outputs
-------
[int] the first int logic for this component. For a component without int logic, or a block index that doesn't exist, 0 is returned.
```

Returns a integer number for a component. Depending on the type of this component this means different things (or nothing at all). Default return is 0.


### `I:Component_GetIntLogic_1(type, blockIndex, propertyIndex)`

```
inputs
-----
type: [int] the type of component you want int logic for.
blockIndex: [int] the index of the component you want int logic for.
propertyIndex: [int] the index of the index of the int logic you want.

outputs
-------
[int] the specified int logic for this component. For a component without int logic, or an index that doesn't exist, 0 is returned.
```

Returns a integer number for a component. Depending on the type of this component this means different things (or nothing at all). Default return is 0.


### `I:Component_SetIntLogic(type,index,int)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
index: [int] the index of the component you want to set int logic for.
int: [int] the integer number you want to set.

outputs
-------
N/A
```

Sets the first int logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogic_1(type, blockIndex, propertyIndex1, int1)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
blockIndex: [int] the index of the component you want to set int logic for.
propertyIndex1: [int] the index of the int logic you want to set.
int1: [int] the integer number you want to set.

outputs
-------
N/A
```

Sets the specified int logic for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogic_2(type, blockIndex, propertyIndex1, int1, propertyIndex2, int2)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
blockIndex: [int] the index of the component you want to set int logic for.
propertyIndex1: [int] the index of the first int logic you want to set.
int1: [int] the integer number you want to set the first logic to.
propertyIndex2: [int] the index of the second int logic you want to set.
int2: [int] the integer number you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified int logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogic_3(type, blockIndex, propertyIndex1, int1, propertyIndex2, int2, propertyIndex3, int3)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
blockIndex: [int] the index of the component you want to set int logic for.
propertyIndex1: [int] the index of the first int logic you want to set.
int1: [int] the integer number you want to set the first logic to.
propertyIndex2: [int] the index of the second int logic you want to set.
int2: [int] the integer number you want to set the second logic to.
propertyIndex3: [int] the index of the third int logic you want to set.
int3: [int] the integer number you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified int logics for a component. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogicAll(type, bool)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.ool [bool] the bool (true/false) you want to set.

outputs
-------
N/A
```

Sets the first boolean logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogicAll_1(type, propertyIndex1, bool1)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
blockIndex: [int] the index of the component you want to set boolean logic for.
propertyIndex1: [int] the index of the boolean logic you want to set.
bool1: [bool] the true/false you want to set.

outputs
-------
N/A
```

Sets the specified boolean logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogicAll_2(type, propertyIndex1, bool1, propertyIndex2, bool2)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
propertyIndex1: [int] the index of the first boolean logic you want to set.
bool1: [bool] the true/false you want to set the first logic to.
propertyIndex2: [int] the index of the second boolean logic you want to set.
bool2: [bool] the true/false you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified boolean logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetBoolLogicAll_3(type, propertyIndex1, bool1, propertyIndex2, bool2, propertyIndex3, bool3)`

```
inputs
-----
type: [int] the type of component you want to set boolean logic for.
propertyIndex1: [int] the index of the first boolean logic you want to set.
bool1: [bool] the true/false you want to set the first logic to.
propertyIndex2: [int] the index of the second boolean logic you want to set.
bool2: [bool] the true/false you want to set the second logic to.
propertyIndex3: [int] the index of the third boolean logic you want to set.
bool3: [bool] the true/false you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified boolean logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogicAll(type, float)`

```
inputs
-----
type: [int] the type of component you want to set floating point logic for.
float [float] the floating point number you want to set.

outputs
-------
N/A
```

Sets the first floating point logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogicAll_1(type, propertyIndex1, float1)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
propertyIndex1: [int] the index of the float logic you want to set.
float1: [float] the floating point value you want to set.

outputs
-------
N/A
```

Sets the specified floating point logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogicAll_2(type, propertyIndex1, float1, propertyIndex2, float2)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
propertyIndex1: [int] the index of the first float logic you want to set.
float1: [float] the floating point value you want to set the first logic to.
propertyIndex2: [int] the index of the second float logic you want to set.
float2: [float] the floating point value you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified floating point logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetFloatLogicAll_3(type, propertyIndex1, float1, propertyIndex2, float2, propertyIndex3, float3)`

```
inputs
-----
type: [int] the type of component you want to set float logic for.
propertyIndex1: [int] the index of the first float logic you want to set.
float1: [float] the floating point value you want to set the first logic to.
propertyIndex2: [int] the index of the second float logic you want to set.
float2: [float] the floating point value you want to set the second logic to.
propertyIndex3: [int] the index of the third float logic you want to set.
float3: [float] the floating point value you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified floating point logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogicAll(type, int)`

```
inputs
-----
type: [int] the type of component you want to set integer logic for.
float [int] the integer you want to set.

outputs
-------
N/A
```

Sets the first integer logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogicAll_1(type, propertyIndex1, int1)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
propertyIndex1: [int] the index of the int logic you want to set.
int1: [int] the integer number you want to set.

outputs
-------
N/A
```

Sets the specified integer logic for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogicAll_2(type, propertyIndex1, int1, propertyIndex2, int2)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
propertyIndex1: [int] the index of the first int logic you want to set.
int1: [int] the integer number you want to set the first logic to.
propertyIndex2: [int] the index of the second int logic you want to set.
int2: [int] the integer number you want to set the second logic to.

outputs
-------
N/A
```

Sets the two specified integer logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:Component_SetIntLogicAll_3(type, propertyIndex1, int1, propertyIndex2, int2, propertyIndex3, int3)`

```
inputs
-----
type: [int] the type of component you want to set int logic for.
propertyIndex1: [int] the index of the first int logic you want to set.
int1: [int] the integer number you want to set the first logic to.
propertyIndex2: [int] the index of the second int logic you want to set.
int2: [int] the integer number you want to set the second logic to.
propertyIndex3: [int] the index of the third int logic you want to set.
int3: [int] the integer number you want to set the third logic to.

outputs
-------
N/A
```

Sets the three specified integer logics for all components of a specific type. Depending on the type of this component this means different things (or nothing at all).


### `I:SetHologramProjectorURL(index, url)`

```
inputs
-----
type: [int] the index of the hologram projector.
url: [string] the url to set the hologram projector to as a string.

outputs
-------
N/A
```

Sets the url of the specified hologram projector


### `I:SetPosterHolderURL(index, url)`

```
inputs
-----
type: [int] the index of the poster holder.
url: [string] the url to set the poster holder to as a string.

outputs
-------
N/A
```

Sets the url of the specified poster holder


# Weapons

### `I:GetWeaponCount()`

```
inputs
-----
N/A

outputs
-------
[int] the number of weapons on the hull- doesn't include weapons on the turrets but does include the turrets themselves.
```

Get the number of weapons on the hull. Knowing is number is useful for when you want to call GetWeaponInfo(i) to find out weapon information.


### `I:GetWeaponInfo(weaponIndex)`

```
inputs
-----
weaponIndex: [int] the index of the weapon you want information on. 0 is the first weapon.

outputs
-------
[WeaponInfo] information on the weapon. weaponInfo.Valid is false if you ask for an invalid weaponIndex.
```

Gets weapon information for a specific weapon. Useful to figure out what sort of weapon is present.


### struct `WeaponInfo`
```
Valid [bool]: false means this WeaponInfo packet is useless. Move onto the next valid one.
LocalPosition [Vector3]: the local position in the vehicle of the weapon. x is right, y is up and z is forwards.
GlobalPosition [Vector3]: the global position of the weapon. x is East, y is Up and Z is North.
LocalFirePoint [Vector3]: the local position in the vehicle where the projectile or laser will be created.
GlobalFirePoint [Vector3]: the global position in the world where the projectile or laser will be created.
Speed [float]: the speed in meters per second of the weapon- approximately correct for most weapon types.
CurrentDirection [Vector3]: the direction in global coordinate system that the weapon is facing
WeaponType [int]: the type of the weapon. cannon = 0,missile = 1 ,laser = 2,harpoon = 3,turret = 4,missilecontrol = 5,fireControlComputer  =6
WeaponSlot [int]: the weapon slot of the weapon itself. 0 -> 5.
WeaponSlotMask [int]: the weapon slot bit mask. The rightmost bit represents 'ALL' and is always on, and the second bit represents slot 1, etc. (for example 100111 will respond to slots All, 1, 2, and 5)
PlayerCurrentlyControllingIt [bool]: true if the player is controlling this weapon at the moment
```


### `I:GetWeaponConstraints(weaponIndex)`

```
inputs
-----
weaponIndex: [int] the index of the weapon you want the constraints off. 0 is the first weapon.

outputs
-------
[WeaponConsraints] information on the field-of-fire constraints of the weapon.
```

Gets field-of-fire constrains information for a specific weapon.


### struct `WeaponConstraints`
```
Valid [bool]: false means this WeaponConstraints packet is useless. Move onto the next valid one.
MinAzimuth [float]: the minimum azimuth angle in degrees.
MaxAzimuth [float]: the maximum azimuth angle in degrees.
MinElevation [float]: the minimum elevation angle in degrees.
MaxElevation [float]: the maximum elevation angle in degrees.
FlipAzimuth [bool]: true if the 'Flip azimuth constraints' toggle is selected.
InParentConstructSpace [bool]: true if the 'Set the restrictions in the parent construct space' toggle is selected.
```


### `I:GetWeaponBlockInfo(weaponIndex)`

```
inputs
-----
weaponIndex: [int] the index of the weapon you want information on. 0 is the first weapon.

outputs
-------
[BlockInfo] the block inforamation of the main component of the weapon. See 'Components' for information on BlockInfo.
```

Gets the block information for a specific weapon.


### `I:AimWeaponInDirection(weaponIndex, x,y,z, weaponSlot)`

```
inputs
-----
weaponIndex: [int] 0 is the first weapon.
x,y,z: [floats] the world coordinate scheme direction components to point in. They don't need to be normalised.
weaponSlot: [int] 0 for all, otherwise 1 to 5.

outputs
-------
[int] the number of weapons that can fire in this direction. 0 for none.
```

Aims a weapon in a specific direction. For a turret this will aim all weapons on the turret as well as the turret itself.


### `I:FireWeapon(weaponIndex, weaponSlot)`

```
inputs
-----
weaponIndex: [int] 0 is the first weapon.
weaponSlot: [int] 0 will control all weapons

outputs
-------
[bool] has any weapon fired? will be true if so.
```

Fires a specific weapon. It's important for most weapons that you aim them first as they won't fire if they can't fire in the direction they are aimed.


### `I:GetTurretSpinnerCount() - Obsolete`

```
inputs
-----
N/A

outputs
-------
[int] the number of turrets and spinners on the construct
```

Returns the number of turrets and spinners on the construct. You'll need this function if you want to control turreted or spin block mounted weapons individually


### `I:GetWeaponCountOnTurretOrSpinner(turretSpinnerIndex) - Obsolete, please use 'GetWeaponCountOnSubConstruct' instead`

```
inputs
-----
turretSpinnerIndex: [int] 0 is the first turret or spinner

outputs
-------
[int] the number of weapons on this turret or spinner, not including the turret itself
```

return the number of weapons on the turret or spinner. If you wanted to control the turret itself then note that it is treated as a hull mounted weapon.


### `I:GetWeaponInfoOnTurretOrSpinner(turretSpinnerIndex, weaponIndex) - Obsolete, please use 'GetWeaponInfoOnSubConstruct' instead`

```
inputs
-----
turretSpinnerIndex: [int] the index of the turret or spinner. 0 is the first one.
weaponIndex: [int] the index of the weapon. 0 is the first one.

outputs
-------
[WeaponInfo] a WeaponInfo object. See above for the definition of this structure. Note that changes to this structure in LUA do not affect the weapon itself.
```

Get weapon info of a weapon on a turret or spinner


### `I:AimWeaponInDirectionOnTurretOrSpinner(turretSpinnerIndex,weaponIndex,x,y,z,weaponSlot) - Obsolete, please use 'AimWeaponInDirectionOnSubConstruct' instead`

```
inputs
-----
First argument is now the turret spinner index, otherwise see 'AimWeaponInDirection'

outputs
-------
as per AimWeaponInDirection
```

Aims a specific weapon on the turret without aiming the turret


### `I:FireWeaponOnTurretOrSpinner(turretSpinnerIndex,weaponIndex,weaponSlot) - Obsolete, please use 'FireWeaponOnSubConstruct' instead`

```
inputs
-----
First argument is now the turret spinner index, otherwise see 'FireWeapon'

outputs
-------
[bool] has any weapon fired? will be true if so.
```

Fires a specific weapon. It's important for most weapons that you aim them first as they won't fire if they can't fire in the direction they are aimed.


### `I:GetWeaponCountOnSubConstruct(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier: [int] This identifier never change in the blueprint, use the SubConstructs-related functions to get it.

outputs
-------
[int] the number of weapons on this turret or spinner, not including the turret itself
```

return the number of weapons on the turret or spinner. If you wanted to control the turret itself then note that it is treated as a hull mounted weapon.


### `I:GetWeaponInfoOnSubConstruct(SubConstructIdentifier, weaponIndex)`

```
inputs
-----
SubConstructIdentifier: [int] This identifier never change in the blueprint, use the SubConstructs-related functions to get it.
weaponIndex: [int] the index of the weapon. 0 is the first one.

outputs
-------
[WeaponInfo] a WeaponInfo object. See above for the definition of this structure. Note that changes to this structure in LUA do not affect the weapon itself.
```

Get weapon info of a weapon on a turret or spinner


### `I:GetWeaponConstraintsOnSubConstruct(SubConstructIdentifier, weaponIndex)`

```
inputs
-----
SubConstructIdentifier: [int] This identifier never change in the blueprint, use the SubConstructs-related functions to get it.
weaponIndex: [int] the index of the weapon. 0 is the first one.

outputs
-------
[WeaponConsraints] information on the field-of-fire constraints of the weapon.
```

Gets field-of-fire constrains information for a specific weapon.


### `I:GetWeaponBlockInfoOnSubConstruct(SubConstructIdentifier, weaponIndex)`

```
inputs
-----
SubConstructIdentifier: [int] This identifier never change in the blueprint, use the SubConstructs-related functions to get it.
weaponIndex: [int] the index of the weapon. 0 is the first one.

outputs
-------
[BlockInfo] the block inforamation of the main component of the weapon. See 'Components' for information on BlockInfo.
```

Gets the block information for a specific weapon.


### `I:AimWeaponInDirectionOnSubConstruct(SubConstructIdentifier,weaponIndex,x,y,z,weaponSlot)`

```
inputs
-----
'SubConstructIdentifier' is the SubConstruct identifier. For the other parameters, see 'AimWeaponInDirection'

outputs
-------
as per AimWeaponInDirection
```

Aims a specific weapon on the turret without aiming the turret


### `I:FireWeaponOnSubConstruct(SubConstructIdentifier,weaponIndex,weaponSlot)`

```
inputs
-----
'SubConstructIdentifier' is the SubConstruct identifier. For the other parameters, see 'FireWeapon'

outputs
-------
[bool] has any weapon fired? will be true if so.
```

Fires a specific weapon. It's important for most weapons that you aim them first as they won't fire if they can't fire in the direction they are aimed.


# Missile Warning

### `I:GetNumberOfWarnings()`

```
inputs
-----
N/A

outputs
-------
[int] the number of missiles being warned on
```

Return the number of missiles the construct has warnings for


### `I:GetMissileWarning(missileIndex)`

```
inputs
-----
missileIndex: [int] the index of the missile

outputs
-------
[MissileWarningInfo] information on the missile. missileWarningInfo.Valid = false if you didn't request an existing missile index
```

Request information on a specific missile warning


### struct `MissileWarningInfo`
```
Valid: [bool] false if the warning is junk due to incorrect indices. 
Position: [Vector3] the position of the missile
Velocity: [Vector3] the velocity of the missile in meters per second
Range : [float] the distance from centre of mass of your construct to the missile
Azimuth :[float] the azimuth angle between your construct's forward direction and the missile (degrees)
Elevation: [float] the elevation angle between your construct's forward direction and the missile (degrees)
TimeSinceLaunch: [float] the time since missile launch.
Id: [int] the unique Id of the missile
```


# Missile Guidance

Connect LUA Transceivers to your missile blocks to allow missiles from those missile blocks to be send LUA Guidance points

### `I:GetLuaTransceiverCount()`

```
inputs
-----
N/A

outputs
-------
[int] the number of LuaTransceivers
```

Return the number of LuaTransceivers. Each transceiver can have a number of missiles which are controllable


### `I:GetLuaControlledMissileCount(luaTransceiverIndex)`

```
inputs
-----
luaTransceiverIndex: [int] the index of the LuaTransceiver where 0 is the first one

outputs
-------
[int] the number of missiles associated with that LuaTransceiver
```

Returns the number of missiles which that luaTransceiver has communications link to


### `I:GetLuaTransceiverInfo(luaTransceiverIndex)`

```
inputs
-----
luaTransceiverIndex: [int] the index of the LuaTransceiver where 0 is the first one

outputs
-------
[BlockInfo] a BlockInfo object for the LuaTransceiver's Launchpad
```

Returns a BlockInfo object for the LuaTransceiver's Launchpad. If no Launch pad exists it'll return it for the LuaTransceiver.


See the Components tab for the BlockInfo structure

### `I:GetLuaControlledMissileInfo(luaTransceiverIndex,missileIndex)`

```
inputs
-----
luaTransceiverIndex: [int] 0 is the first one.
missileIndex: [int] 0 is the first missile.

outputs
-------
[MissileWarningInfo] Get a MissileWarningInfo object for your missile.
```

Returns a MissileWarningInfo structure for your missile. You can tell where it is and how fast it is going from this


See the Missile Warning tab for the MissileWarningInfo structure

### `I:SetLuaControlledMissileAimPoint(luaTransceiverIndex,missileIndex,x,y,z)`

```
inputs
-----
luaTransceiverIndex: [int] as above.
missileIndex:[int] as above.
 x,y,z: [floats] global coordinates of the aim point

outputs
-------
N/A
```

Sets the aim point. No guidance modules will help achieve this aim point so do your own predictive guidance. Needs a lua receiver component ON the missile to work.


### `I:DetonateLuaControlledMissile(luaTransceiverIndex,missileIndex)`

```
inputs
-----
luaTransceiverIndex: [int] as above.
missileIndex:[int] as above.

outputs
-------
N/A
```

Explodes the missile. Needs a lua receiver component ON the missile to work.


### `I:IsLuaControlledMissileAnInterceptor(luaTransceiverIndex,missileIndex)`

```
inputs
-----
luaTranceiverIndex:[int] 0 is the first one
missileIndex:[int] 0 is the first one

outputs
-------
[bool]: true means the missile has an interceptor module, otherwise false is returned. If the missile has no lua receiver false will be returned.
```

Find out if the missile has an interceptor capability.


### `I:SetLuaControlledMissileInterceptorTarget(luaTransceiverIndex,missileIndex,targetIndex)`

```
inputs
-----
luaTransceiverIndex:[int] 0 is the first one
missileIndex:[int] 0 is the first one,
targetIndex:[int] 0 is the first missile which that mainframe has a warning for

outputs
-------
N/A
```

Set the target of an interceptor missile to be a specific missile for which a warning exists. This is enough to get the interceptor missile to behave normally but if you want to actually guide it yourself use SetLuaControlledMissileInterceptorStandardGuidanceOnOff to turn the guidance off.


### `I:SetLuaControlledMissileInterceptorStandardGuidanceOnOff(luaTranceiver,missileIndex, onOff)`

```
inputs
-----
luaTransceiverIndex:[int] 0 is the first one
missileIndex:[int] 0 is the first one
onOff:[bool] true will use standard missile guidance to aim at the interceptors target, false will rely on SetLuaControlledMissileAimPoint for aiming coordinates.

outputs
-------
N/A
```

Turns standard guidance for the missile on and off. Turn it off if you're going to guide the missile in yourself.


# Spinners

Spin blocks spinners have their own interface because they use 'SubConstruct' identifiers

### `I:SetSpinBlockSpeedFactor(SubConstructIdentifier,speedFactor)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
speedFactor:[float] 0 to 1, the fractional power output

outputs
-------
N/A
```

Set the speed factor. In continuous mode spinners this allows some blades to spin slower than others, in insta-spin blades this is related to the speed they are spinning at (1 is max speed, 0 is no speed), and in rotation spinners this does nothing.


### `I:SetSpinBlockPowerDrive(SubConstructIdentifier,drive)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
						drive:[float] the relative power use of the spinner (0 to 10).

outputs
-------
N/A
```

Sets the power drive. this allows heliblades to produce more force. Requires engine power. 0 removes engine use. 10 is maximum power use.


### `I:SetSpinBlockRotationAngle(SubConstructIdentifier, angle)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
angle:[float] angle in degrees to turn to.

outputs
-------
N/A
```

Sets the angle of rotation. Changes the spinner into Rotate mode. 'Rotatebackwards' is not available through this interface but you shouldn't need it.


### `I:SetSpinBlockContinuousSpeed(SubConstructIdentifier, speed)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
speed:[float] speed to rotate at. 30 is the maximum so values from -30 to 30 work.

outputs
-------

```

Sets the speed of rotation. Changes the spinner into continuous mode. 'ContinuouseReverse' mode is not available through this interface so set the speed negative to facilitate reverse spinning.


### `I:SetSpinBlockInstaSpin(SubConstructIdentifier,magnitudeAndDirection)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
magnitudeAndDirection:[float] -1 means spin backwards full speed, 1 is spin forwards full speed

outputs
-------
N/A
```

Spins the blades in a direction and speed determined by magnitudeAndDirection. Will set the spinner into instaspin forwards mode and will affect speed factor variable of the spinner.


Pistons have their own interface because they use 'SubConstruct' identifiers

### `I:GetPistonExtension(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.

outputs
-------
[float] the extension distance of the piston in meters
```

Get the extension of the piston, -1 if not found.


### `I:GetPistonVelocity(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.

outputs
-------
[float] the velocity of the piston in meters per second
```

Get the velocity of the piston (always positive), -1 if not found.


### `I:SetPistonExtension(SubConstructIdentifier,ExtensionDistance)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
ExtensionDistance:[float]the extension distance of the piston (in meters, will be clamped if necessary)

outputs
-------
N/A
```

Set the extension of the piston.


### `I:SetPistonVelocity(SubConstructIdentifier,ExtensionVelocity)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct.
ExtensionDistance:[float]the velocity of the piston in meters per second (between 0.1 and 2)

outputs
-------
N/A
```

Set the velocity of the piston.


Dedicated helicopter spinners have their own interface because they have their own indexing system

### `I:GetDedibladeCount()`

```
inputs
-----
N/A

outputs
-------
[int] the number of dedicated helicopter spinners
```

Returns the number of dedicated helicopter spinners


### `I:GetDedibladeInfo(DedibladeIndex)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner

outputs
-------
[BlockInfo] a block info object for the dedicated helicopter spinner.
```

Returns block info for the dedicated helicopter spinner.


### `I:IsDedibladeOnHull(DedibladeIndex)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner

outputs
-------
[bool] true if on hull
```

Returns whether the dedicated helicopter spinner is on the hull or on a SubConstruct.


### `I:SetDedibladeSpeedFactor(DedibladeIndex,speedFactor)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner.
speedFactor:[float] 0 to 1, the fractional power output

outputs
-------
N/A
```

Set the speed factor. In continuous mode spinners this allows some blades to spin slower than others, in insta-spin blades this is related to the speed they are spinning at (1 is max speed, 0 is no speed), and in rotation spinners this does nothing.


### `I:SetDedibladePowerDrive(DedibladeIndex,drive)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner.
drive:[float] the relative power use of the dedicated helicopter spinner (0 to 10).

outputs
-------
N/A
```

Sets the power drive. this allows heliblades to produce more force. Requires engine power. 0 removes engine use. 10 is maximum power use.


### `I:SetDedibladeContinuousSpeed(DedibladeIndex, speed)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner.
speed:[float] speed to rotate at. 30 is the maximum so values from -30 to 30 work.

outputs
-------

```

Sets the speed of rotation. Changes the dedicated helicopter spinner into continuous mode. 'ContinuouseReverse' mode is not available through this interface so set the speed negative to facilitate reverse spinning.


### `I:SetDedibladeInstaSpin(DedibladeIndex,magnitudeAndDirection)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner.
magnitudeAndDirection:[float] -1 means spin backwards full speed, 1 is spin forwards full speed

outputs
-------
N/A
```

Spins the blades in a direction and speed determined by magnitudeAndDirection. Will set the dedicated helicopter spinner into instaspin forwards mode and will affect speed factor variable of the spinner.


### `I:SetDedibladeUpFraction(DedibladeIndex,upFraction)`

```
inputs
-----
DedibladeIndex:[int] 0 is the first dedicated helicopter spinner.
upFraction:[float] 0 to 1.

outputs
-------
N/A
```

Sets the fraction of the force that will be applied directly upwards, regardless of blade orientation.


From now on, these functions are obsolete, please use the 'SubConstructs' set of functions

### `I:GetSpinnerCount() - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
N/A

outputs
-------
[int] the number of spinners. This includes 'dedicated helispinners', which may be mounted on traditional spin blocks.
```

Returns the number of spin blocks and dedicated helispinners


### `I:GetSpinnerInfo(index) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index:[int] 0 is the first spin block

outputs
-------
[BlockInfo] a block info object for the spin block.
```

Returns block info for the spinner. For a spin block it will return block info where local positions and rotations are those of the actual spinning assembly, not the block itself.


### `I:SetSpinnerSpeedFactor(index,speedFactor) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index:[int] the index of the spinner.
						speedFactor:[float] 0 to 1, the fractional power output

outputs
-------
N/A
```

Set the speed factor. In continuous mode spinners this allows some blades to spin slower than others, in insta-spin blades this is related to the speed they are spinning at (1 is max speed, 0 is no speed), and in rotation spinners this does nothing.


### `I:SetSpinnerPowerDrive(index,drive) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index[int] the index of the spinner. 0 is the first.
						drive:[float] the relative power use of the spinner (0 to 10).

outputs
-------
N/A
```

Sets the power drive. this allows heliblades to produce more force. Requires engine power. 0 removes engine use. 10 is maximum power use.


### `I:SetSpinnerRotationAngle(index, angle) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index:[int] 0 is the first spinner.
angle:[float] angle in degrees to turn to.

outputs
-------
N/A
```

Sets the angle of rotation. Changes the spinner into Rotate mode. 'Rotatebackwards' is not available through this interface but you shouldn't need it.


### `I:SetSpinnerContinuousSpeed(index, speed) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index:[int] 0 is the first spinner.
speed:[float] speed to rotate at. 30 is the maximum so values from -30 to 30 work.

outputs
-------

```

Sets the speed of rotation. Changes the spinner into continuous mode. 'ContinuouseReverse' mode is not available through this interface so set the speed negative to facilitate reverse spinning.


### `I:SetSpinnerInstaSpin(index,magnitudeAndDirection) - Obsolete, please see the 'SubConstructs' set of functions`

```
inputs
-----
index:[int] 0 is the first spinner.
magnitudeAndDirection:[float] -1 means spin backwards full speed, 1 is spin forwards full speed

outputs
-------
N/A
```

Spins the blades in a direction and speed determined by magnitudeAndDirection. Will set the spinner into instaspin forwards mode and will affect speed factor variable of the spinner.


### `I:IsSpinnerDedicatedHelispinner(index) - Obsolete`

```
inputs
-----
index:[int] 0 is the first spinner.

outputs
-------
[bool] true if the spinner is a dedicated spinner.
```

Returns whether the spinner in question is a dedicated helispinner


### `I:IsSpinnerOnHull(index) - Obsolete, please see the 'IsDedibladeOnHull' or 'IsSubConstructOnHull' function`

```
inputs
-----
index:[int] 0 is the first spinner

outputs
-------
[bool] true if on hull
```

Returns whether the spinner is on the hull or on another spin block. This can only be true for dedicated helispinners


### `I:SetDedicatedHelispinnerUpFraction(index,upFraction) - Obsolete, please use the 'SetDedibladeUpFraction' function`

```
inputs
-----
index:[int] 0 is the first spinner.
upFraction:[float] 0 to 1.

outputs
-------
N/A
```

Only works for dedicated helispinners. Sets the fraction of the force that will be applied directly upwards, regardless of blade orientation.


# SubConstructs

SubConstructs (turrets and spin blocks) have their own interface dedicated to work with stacked SubConstructs. They all have a unique persistent index which will never be modified in the blueprint (that index starts at 1)

### `I:GetAllSubconstructsCount()`

```
inputs
-----
N/A

outputs
-------
[int] the total number of SubConstructs on the vehicle
```

Returns the number of SubConstructs on the vehicle, including SubConstructs on SubConstructs


### `I:GetSubConstructIdentifier(index)`

```
inputs
-----
index:[int] 0 is the first SubConstruct

outputs
-------
[int] the persistent indentifier of the SubConstruct
```

Returns the identifier of the SubConstruct. The indices start at 0 and are in no particular order


### `I:GetSubconstructsChildrenCount(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[int] all the number of SubConstructs directly placed on the given SubConstruct.
```

Returns the number of SubConstructs on the given SubConstruct


### `I:GetSubConstructChildIdentifier(SubConstructIdentifier, index)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the parent SubConstruct
index:[int] 0 is the first child SubConstruct

outputs
-------
[int] the persistent indentifier of the SubConstruct
```

Returns the identifier of the child SubConstruct placed on the parent SubConstruct. The indices start at 0 and are in no particular order


### `I:GetParent(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[int] the persistent index of the parent SubConstruct of the given SubConstruct.
```

Returns the persistent index of the parent SubConstruct of the given SubConstruct, '0' for the MainConstruct, '-1' if not found


### `I:IsTurret(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[bool] 'true' if the SubConstruct is a turret, 'false' otherwise.
```

Indicates if the SubConstruct is a turret or not


### `I:IsSpinBlock(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[bool] 'true' if the SubConstruct is a spin block, 'false' otherwise.
```

Indicates if the SubConstruct is a spin block or not


### `I:IsPiston(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[bool] 'true' if the SubConstruct is a piston, 'false' otherwise.
```

Indicates if the SubConstruct is a piston or not


### `I:IsAlive(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[bool] 'true' if the SubConstruct is not completely destroyed.
```

Indicates if the SubConstruct is destroyed or not


### `I:IsSubConstructOnHull(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[bool] 'true' if the SubConstruct is on the hull.
```

Indicates if the SubConstruct is on the hull or not


### `I:GetSubConstructInfo(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[BlockInfo] a BlockInfo object for the SubConstruct active block (the SpinBlock block, the piston or the turret block)
```

Returns a BlockInfo object for the active block of the SubConstruct, and invalid BlockInfo if the SubConstruct hasn't been found.


### `I:GetSubConstructIdleRotation(SubConstructIdentifier)`

```
inputs
-----
SubConstructIdentifier:[int] the persistent identifier of the SubConstruct

outputs
-------
[Quaternion] the rotation of the subconstruct relative to its parent as it was first placed.
```

Returns a Quaternion representing the orientation of the block in its parent SubConstruct as it was when it was placed.


# Friendlies

The following API will provide you with the positions of friendly vehicles- in the same manner as 

### `I:GetFriendlyCount()`

```
inputs
-----
N/A

outputs
-------
[int] the number of friendlies spawned into the world
```

Returns the number of friendly constructs


### `I:GetFriendlyInfo(index)`

```
inputs
-----
index: [int] 0 is the first construct

outputs
-------
[FriendlyInfo] the FriendlyInfo object
```

Returns a friendly info object for a friendly vehicle


### `I:GetFriendlyInfoById(Id)`

```
inputs
-----
Id: [int] the Id you want

outputs
-------
[FriendlyInfo] the FriendlyInfo object
```

Returns a friendly info object for an Id


### struct `FriendlyInfo`
```
Valid:[bool] false if the Friendly Info could not be retrieved
Rotation:[Quaternion] the rotation of the friendly construct
ReferencePosition: [Vector3] the position of the construct (world East Up North frame) from which PositiveSize and Negative size are referenced
PositiveSize: [Vector3] the extent of the construct in the right,up,forwards direction relative to ReferencePostion
NegativeSize: [Vector3] the extent of the construct in the left,down,back direction relative to ReferencePosition
CenterOfMass: [Vector3] the centre of mass of the construct in world East Up North frame
Velocity: [Vector3] the velocity of the construct in world East Up North frame
UpVector: [Vector3] The up vector in world East Up North frame
RightVector: [Vector3] The up vector in world East Up North frame
ForwardVector: [Vector3] The forward vector in world East Up North frame
HealthFraction: [float] the fraction of health (including turrets etc)
SparesFraction: [float] the spares fraction. Returns 1 if no spares storage present
AmmoFraction: [float] the ammo fraction. Returns 1 if no ammo storage present
FuelFraction: [float] the fuel fraction. Returns 1 if no fuel storage present
EnergyFraction: [float] the energy fraction. Returns 1 if no batteries present
PowerFraction: [float] the power fraction. Returns 1 if no fuel storage present
ElectricPowerFraction: [float] the electric power fraction. Returns 1 if no fuel storage present
AxisAlignedBoundingBoxMinimum: [Vector3] the world East Up North minimum extent of the construct
AxisAlignedBoundingBoxMaximum: [Vector3] the world East Up North maximum extent of the construct
BlueprintName: [string] the name
Id: [int] the unique Id of the construct
```


