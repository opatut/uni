import java.util.Stack;

/**
 * Diese Klasse bietet eine Operation an,
 * die Ausdruecke in Postfixnotation auswertet.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
class Postfixrechner
{
    /**
     * Wertet einen Ausdruck in Postfixnotation aus.
     * Beispielsweise liefert werteAus("1 2 + 3 *") die Zahl 9.
     * 
     * Mögliche Fehler: 
     *  - Strings oder unbekannte Operatoren als Eingaben
     *  - Dezimalzahlen
     *  - Falsch geformte Ausdrücke (sodass der Stack leer wird, z.B. "3 2 + +", was in Infix-Notation
     *    "(3 + 2) +" und somit ungültig wäre
     * 
     * @param ausdruck der auszuwertende Ausdruck in Postfixnotation
     * @return des ausgewertete Ergebnis des Ausdrucks
     */
    public static int werteAus(String ausdruck)
    {
        Stack<Integer> stack = new Stack<Integer>();
        
        for(String op : ausdruck.split("\\s+")) {
            switch(op) {
                case "*":
                    stack.push(stack.pop() * stack.pop());
                    break;
                case "+":
                    stack.push(stack.pop() + stack.pop());
                    break;
                case "-":
                    stack.push(- stack.pop() + stack.pop());
                    break;
                case "/":
                    int tmp = stack.pop();
                    stack.push(stack.pop() / tmp);
                    break;
                default:
                    try {
                        int i = Integer.parseInt(op);
                        stack.push(i);
                    } catch(NumberFormatException e) {
                        System.err.println("Not a valid number or operator: " + op + " - skipping.");
                    }
            }
        }
        
        if(stack.size() > 0) {
            return stack.pop();
        } else {
            return 0;
        }
    }
}
