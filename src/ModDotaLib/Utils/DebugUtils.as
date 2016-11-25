package ModDotaLib.Utils {
	public class DebugUtils {
		// Shamelessly stolen from Frota
        public static function strRep(str, count) {
            var output = "";
            for(var i=0; i<count; i++) {
                output = output + str;
            }

            return output;
        }

        public static function isPrintable(t) {
        	if(t == null || t is Number || t is String || t is Boolean || t is Function || t is Array) {
        		return true;
        	}
        	// Check for vectors
        	if(flash.utils.getQualifiedClassName(t).indexOf('__AS3__.vec::Vector') == 0) return true;

        	return false;
        }

        public static function PrintTable(t, indent=0, done=null) {
        	var i:int, key, key1, v:*;

        	// Validate input
        	if(isPrintable(t)) {
        		trace(t);
        		return;
        	}

        	if(indent == 0) {
        		trace("{");
        	}

        	// Stop loops
        	done ||= new flash.utils.Dictionary(true);
        	if(done[t]) {
        		trace(strRep("\t", indent+1)+"\"object\" : \"<loop object>"+t+"\"");
        		return;
        	}
        	done[t] = true;

        	// Grab this class
        	var thisClass = flash.utils.getQualifiedClassName(t);

        	// Print methods
			trace(strRep("\t", indent+1) + "\"methods\" : [");
			for each(key1 in flash.utils.describeType(t)..method) {
				// Check if this is part of our class
				if(key1.@declaredBy == thisClass) {
					// Yes, log it
					trace(strRep("\t", indent+2)+"\""+key1.@name+"()\",");
				}
			}
			trace(strRep("\t", indent+2)+"\"###IGNOREME###\""); //This is to validate the json
			trace(strRep("\t", indent+1) + "],");

			// Check for text
			if("text" in t) {
				trace(strRep("\t", indent+1)+"\"text\" : \""+escape(t.text)+"\",");
			}

			// Print variables
			//trace(strRep("\t", indent+1)+"##DEBUG: We are doing variables now");
			for each(key1 in flash.utils.describeType(t)..variable) {
				key = key1.@name;
				v = t[key];

				// Check if we can print it in one line
				if(isPrintable(v)) {
					trace(strRep("\t", indent+1)+"\""+key+"\" : \""+v+"\",");
				} else {
					// Open bracket
					trace(strRep("\t", indent+1)+"\""+key+"\" : {");

					// Recurse!
					PrintTable(v, indent+1, done)

					// Close bracket
					trace(strRep("\t", indent+1)+"},");
				}
			}

			// Find other keys
			//trace(strRep("\t", indent+1)+"##DEBUG: We are doing keys now");
			for(key in t) {
				v = t[key];

				// Check if we can print it in one line
				if(isPrintable(v)) {
					trace(strRep("\t", indent+1)+"\""+key+"\" : \""+v+"\",");
				} else {
					// Open bracket
					trace(strRep("\t", indent+1)+"\""+key+"\" : {");

					// Recurse!
					PrintTable(v, indent+1, done)

					// Close bracket
					trace(strRep("\t", indent+1)+"},");
				}
        	}

        	// Get children
			//trace(strRep("\t", indent+1)+"##DEBUG: We are doing children now");
			trace(strRep("\t", indent+1)+"\"children\" : [");
        	if(t is MovieClip) {
        		// Loop over children
	        	for(i = 0; i < t.numChildren; i++) {
	        		// Open bracket
					trace(strRep("\t", indent+2)+"{");
					//add type
					trace(strRep("\t", indent+3)+"\"name\" : \""+t.name+"\",");
					trace(strRep("\t", indent+3)+"\"type\" : \""+t+"\",");
					// Recurse!
	        		PrintTable(t.getChildAt(i), indent+2, done);

	        		// Close bracket
					trace(strRep("\t", indent+2)+"},");
	        	}
				trace(strRep("\t", indent+2)+"\"###IGNOREME###\""); //This is to validate the json
        	}
			trace(strRep("\t", indent+1)+"]");
        	// Close bracket
        	if(indent == 0) {
        		trace("}");
        	}
        }
	}
}