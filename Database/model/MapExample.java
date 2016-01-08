package model;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class MapExample {

    public static void main(String[] args) {
                // Create a Empty HashMap 
                HashMap<String, String> obHashMap = new HashMap<String, String>();
                // Put values in hash map
                obHashMap.put("AB", "1");
                obHashMap.put("EF", "2");
                obHashMap.put("Gh", "3");
                obHashMap.put("CD", "4");
                //Store entry (Key/Value)of HashMap in set
                Set mapSet = (Set) obHashMap.entrySet();
                //Create iterator on Set 
                Iterator mapIterator = mapSet.iterator();
                System.out.println("Display the key/value of HashMap.");
                while (mapIterator.hasNext()) {
                        Map.Entry mapEntry = (Map.Entry) mapIterator.next();
                        // getKey Method of HashMap access a key of map
                        String keyValue = (String) mapEntry.getKey();
                        //getValue method returns corresponding key's value
                        String value = (String) mapEntry.getValue();
                        System.out.println("Key : " + keyValue + "= Value : " + value);
                }
        }
}