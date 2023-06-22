# ImprovedMagnitude

## Introduction:
The ImprovedMagnitude module revolutionizes hitbox calculations, offering enhanced accuracy and flexibility. It takes into account various properties, including the size of the enemy, to deliver precise results. Whether you need to determine the closest foe, the farthest adversary, or even hit the nearest target within a specific range, ImprovedMagnitude has got you covered.

### Why Use ImprovedMagnitude?
- Pinpoint Accuracy: Consider the size of the enemy when calculating hitboxes, ensuring you accurately hit your targets, even if they're colossal.
- Customizable Options: Tailor the hitbox behavior by choosing from multiple types, such as nearest, closest, farthest, or furthest, to suit your gameplay requirements.
- Efficient Range Calculation: Specify a maximum distance and an ignore list to streamline hitbox calculations and exclude unwanted objects.

## Usage:

```lua
-- Import the ImprovedMagnitude module
local ImprovedMagnitude = require(script.ImprovedMagnitude)

-- Create a new instance of ImprovedMagnitude
local Hitbox = ImprovedMagnitude.new()

-- Set the properties of the hitbox
Hitbox.HitPoint = MyHumanoidRootPart.Position -- Center point for hitbox calculations
Hitbox.MaxDistance = 10 -- Maximum range

Hitbox.Directory = workspace.Players -- Enemies' Directory
Hitbox.IgnoreList = {MyCharacter}

Hitbox.Type = "Nearest" -- Get the Nearest Player

-- Calculate the enhanced magnitude of the hitbox
local target = Hitbox:Get()
```

## Types of Hitbox:
#### ImprovedMagnitude offers different types to determine the order in which objects are returned:
- "Nearest":
Returns the character closest to the hit point based on the calculated enhanced magnitude.
- "Farthest":
Returns the character farthest from the hit point based on the calculated enhanced magnitude.
- "Asc":
Returns all characters within the specified range in ascending order of their distances from the hit point, from the closest to the farthest.
- "Desc":
Returns all characters within the specified range in descending order of their distances from the hit point, from the farthest to the closest.

> By choosing the appropriate Type, you can organize the returned list based on your desired criteria, enhancing your gameplay strategies.
