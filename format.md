| ID  | Text Structure (Array Content) |
|-----|--------------------------------|
| 0  | ["Log", {"value": "", "t": "any"}] |
| 1  | ["Warn", {"value": "", "t": "any"}] |
| 2  | ["Error", {"value": "", "t": "any"}] |
| 3  | ["Wait", {"value": "", "t": "number"}, "seconds"] |
| 4  | ["Redirect to", {"href": "true", "t": "string"}] |
| 5  | ["Play audio", {"t": "string", "assetbrowser": "audio", "l": "id"}, "→", {"t": "string", "l": "variable?"}] |
| 7  | ["Stop all audio"] |
| 8  | ["Make", {"value": "", "t": "object"}, "invisible"] |
| 9  | ["Make", {"value": "", "t": "object"}, "visible"] |
| 10  | ["Set", {"value": "", "t": "object"}, "text to", {"value": "", "t": "string"}] |
| 11  | ["Set", {"t": "string", "l": "variable"}, "to", {"t": "string", "l": "any"}] |
| 12  | ["Increase", {"t": "string", "l": "variable"}, "by", {"t": "number"}] |
| 13  | ["Decrease", {"t": "string", "l": "variable"}, "by", {"t": "number"}] |
| 14  | ["Multiply", {"t": "string", "l": "variable"}, "by", {"t": "number"}] |
| 15  | ["Divide", {"t": "string", "l": "variable"}, "by", {"t": "number"}] |
| 16  | ["Round", {"t": "string", "l": "variable"}] |
| 17  | ["Floor", {"t": "string", "l": "variable"}] |
| 18  | ["If", {"value": "", "l": "any", "t": "string"}, "is equal to", {"value": "", "l": "any", "t": "string"}] |
| 19  | ["If", {"value": "", "l": "any", "t": "string"}, "is not equal to", {"value": "", "l": "any", "t": "string"}] |
| 20  | ["If", {"value": "", "l": "any", "t": "string"}, "is greater than", {"value": "", "l": "any", "t": "string"}] |
| 21  | ["If", {"value": "", "l": "any", "t": "string"}, "is lower than", {"value": "", "l": "any", "t": "string"}] |
| 22  | ["Repeat", {"value": "", "t": "number"}, "times"] |
| 23  | ["Repeat forever"] |
| 24  | ["Break"] |
| 25  | ["end"] |
| 26  | ["Play looped audio", {"t": "string", "assetbrowser": "audio", "l": "id"}, "→", {"t": "string", "l": "variable?"}] |
| 27  | ["Set", {"t": "string", "l": "var"}, "to random", {"t": "number", "l": "n"}, "-", {"t": "number", "l": "n"}] |
| 30  | ["Get text from", {"value": "", "l": "input", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 31  | ["Set", {"value": "", "t": "string", "l": "property"}, "of", {"value": "", "t": "object"}, "to", {"value": "", "t": "any"}] |
| 32  | ["Broadcast", {"t": "string", "l": "message"}, "across page"] |
| 33  | ["Broadcast", {"t": "string", "l": "message"}, "across site"] |
| 37  | ["If", {"value": "", "t": "string"}, "contains", {"value": "", "t": "string"}] |
| 38  | ["If", {"value": "", "t": "string"}, "doesn't contain", {"value": "", "t": "string"}] |
| 39  | ["Get", {"value": "", "t": "string", "l": "property"}, "of", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 40  | ["Raise", {"t": "string", "l": "variable"}, "to the power of", {"t": "number"}] |
| 41  | [{"t": "string", "l": "variable"}, "modulo", {"t": "number"}] |
| 42  | ["Sub", {"t": "string", "l": "variable"}, {"t": "number", "l": "start"}, "-", {"t": "number", "l": "end"}] |
| 43  | ["Replace", {"t": "string"}, "in", {"t": "string", "l": "variable"}, "by", {"t": "string"}] |
| 44  | ["If", {"value": "", "l": "variable", "t": "string"}, "AND", {"value": "", "l": "variable", "t": "string"}] |
| 45  | ["If", {"value": "", "l": "variable", "t": "string"}, "OR", {"value": "", "l": "variable", "t": "string"}] |
| 46  | ["If", {"value": "", "l": "variable", "t": "string"}, "NOR", {"value": "", "l": "variable", "t": "string"}] |
| 47  | ["If", {"value": "", "l": "variable", "t": "string"}, "XOR", {"value": "", "l": "variable", "t": "string"}] |
| 48  | ["Get length of", {"t": "string"}, "→", {"t": "string", "l": "variable"}] |
| 49  | ["Duplicate", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 50  | ["Delete", {"value": "", "t": "object"}] |
| 51  | ["Get local username →", {"t": "string", "l": "variable"}] |
| 52  | ["Get local user ID →", {"t": "string", "l": "variable"}] |
| 53  | ["Get local display name →", {"t": "string", "l": "variable"}] |
| 54  | ["Create table", {"t": "string", "l": "table"}] |
| 55  | ["Set entry", {"t": "string", "l": "entry"}, "of", {"t": "string", "l": "table"}, "to", {"t": "string", "l": "any"}] |
| 56  | ["Get entry", {"t": "string", "l": "entry"}, "of", {"t": "string", "l": "table"}, "→", {"t": "string", "l": "variable"}] |
| 57  | ["Split", {"t": "string"}, {"t": "string", "l": "separator"}, "→", {"t": "string", "l": "table"}] |
| 58  | ["Parent", {"value": "", "t": "object"}, "under", {"value": "", "t": "object"}] |
| 59  | ["Get length of", {"t": "string", "l": "array"}, "→", {"t": "string", "l": "variable"}] |
| 63  | ["Run function in background", {"t": "string", "l": "function"}, {"t": "tuple"}] |
| 66  | ["Set entry", {"t": "string", "l": "entry"}, "of", {"t": "string", "l": "table"}, "to", {"t": "object"}] |
| 67  | ["Get query string parameter", {"t": "string"}, "→", {"t": "string", "l": "variable"}] |
| 68  | ["Get unix timestamp →", {"t": "string", "l": "variable"}] |
| 69  | ["Lower", {"t": "string"}, "→", {"t": "string", "l": "variable"}] |
| 70  | ["Upper", {"t": "string"}, "→", {"t": "string", "l": "variable"}] |
| 71  | ["Format current date/time", {"t": "string", "l": "format"}, "→", {"t": "string", "l": "variable"}] |
| 72  | ["Format from unix", {"t": "number"}, {"t": "string", "l": "format"}, "→", {"t": "string", "l": "variable"}] |
| 73  | ["Set volume of", {"t": "string", "l": "variable"}, "to", {"t": "number"}] |
| 74  | ["Stop audio", {"t": "string", "l": "variable"}] |
| 75  | ["Pause audio", {"t": "string", "l": "variable"}] |
| 76  | ["Resume audio", {"t": "string", "l": "variable"}] |
| 77  | ["Set speed of", {"t": "string", "l": "variable"}, "to", {"t": "number"}] |
| 78  | ["Ceil", {"t": "string", "l": "variable"}] |
| 79  | ["If left mouse button down"] |
| 80  | ["If middle mouse button down"] |
| 81  | ["If right mouse button down"] |
| 82  | ["If", {"t": "key"}, "down"] |
| 83  | ["Get tick →", {"t": "string", "l": "variable"}] |
| 84  | ["Get viewport size →", {"t": "string", "l": "x"}, {"t": "string", "l": "y"}] |
| 85  | ["Get cursor position →", {"t": "string", "l": "x"}, {"t": "string", "l": "y"}] |
| 87  | ["Run function", {"t": "string", "l": "function"}, {"t": "tuple"}, "→", {"t": "string", "l": "variable?"}] |
| 88  | ["Tween", {"value": "", "l": "property", "t": "string"}, "of", {"value": "", "t": "object"}, "to", {"value": "", "t": "any"}, "-", {"value": "", "t": "number", "l": "time"}, {"value": "", "l": "style", "t": "string"}, {"value": "", "l": "direction", "t": "string"}] |
| 89  | ["Insert", {"t": "string", "l": "any"}, "at position", {"t": "number", "l": "number?"}, "of", {"t": "string", "l": "array"}] |
| 90  | ["Delete entry", {"t": "string", "l": "entry"}, "of", {"t": "string", "l": "table"}] |
| 91  | ["Remove entry at position", {"t": "number", "l": "number?"}, "of", {"t": "string", "l": "array"}] |
| 92  | ["If", {"value": "", "l": "variable", "t": "string"}, "exists"] |
| 93  | ["If", {"value": "", "l": "variable", "t": "string"}, "doesn't exist"] |
| 94  | ["Set", {"l": "property", "t": "string"}, "of", {"t": "string", "l": "variable"}, "to", {"t": "any"}] |
| 95  | ["Get", {"l": "property", "t": "string"}, "of", {"t": "string", "l": "variable"}, "→", {"t": "string", "l": "variable"}] |
| 96  | ["Delete", {"t": "string", "l": "variable"}] |
| 97  | ["Get parent of", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 98  | ["Find ancestor named", {"value": "", "t": "string"}, "in", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 99  | ["Find child named", {"value": "", "t": "string"}, "in", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 100 | ["Find descendant named", {"value": "", "t": "string"}, "in", {"value": "", "t": "object"}, "→", {"value": "", "l": "variable", "t": "string"}] |
| 101 | ["Get children of", {"value": "", "t": "object"}, "→", {"value": "", "l": "table", "t": "string"}] |
| 102 | ["Get descendants of", {"value": "", "t": "object"}, "→", {"value": "", "l": "table", "t": "string"}] |
| 103 | ["If", {"t": "object"}, "is ancestor of", {"t": "object"}] |
| 104 | ["If", {"t": "object"}, "is child of", {"t": "object"}] |
| 105 | ["If", {"t": "object"}, "is descendant of", {"t": "object"}] |
| 106 | ["Set", {"value": "", "t": "object"}, "image to", {"value": "", "t": "id", "assetbrowser": "image"}] |
| 107 | ["Set", {"value": "", "t": "object"}, "image to avatar of", {"value": "", "l": "userid", "t": "number"}, {"value": "", "t": "string", "l": "resolution?"}] |
| 108 | ["If dark theme enabled"] |
| 109 | ["Concatenate", {"t": "string"}, "with", {"t": "string"}, "→", {"t": "string", "l": "variable"}] |
| 110 | ["Join", {"t": "string", "l": "array"}, "using", {"t": "string", "l": "string"}, "→", {"t": "string", "l": "variable"}] |
| 112 | ["else"] |
| 113 | ["Iterate through", {"t": "string", "l": "table"}, "({l!index},{l!value})"] |
| 114 | ["Run math function", {"l": "function", "t": "string"}, {"t": "tuple"}, "→", {"t": "string", "l": "variable"}] |
| 115 | ["Return", {"t": "string", "l": "any"}] |
| 116 | ["Get server unix timestamp →", {"t": "string", "l": "variable"}] |
| 117 | ["Get URL →", {"t": "string", "l": "variable"}] |
| 118 | ["Get timezone →", {"t": "string", "l": "variable"}] |
| 119 | ["Convert", {"t": "string", "l": "hex"}, "to RGB →", {"t": "string", "l": "variable"}] |
| 120 | ["Convert", {"t": "string", "l": "hex"}, "to HSV →", {"t": "string", "l": "variable"}] |
| 121 | ["Convert", {"t": "string", "l": "RGB"}, "to hex →", {"t": "string", "l": "variable"}] |
| 122 | ["Convert", {"t": "string", "l": "HSV"}, "to hex →", {"t": "string", "l": "variable"}] |
| 123 | ["Lerp", {"t": "string", "l": "hex"}, "to", {"t": "string", "l": "hex"}, "by", {"t": "number", "l": "alpha"}, "→", {"t": "string", "l": "variable"}] |
| 124 | [{"value": "", "t": "string", "l": "comment"}] |
