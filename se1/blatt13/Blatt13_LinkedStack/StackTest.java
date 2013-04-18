/**
 * Diese Klasse testet den Stack.
 *
 * @author Fredrik Winkler
 * @version Januar 2012
 */
public class StackTest extends junit.framework.TestCase
{
    private Stack _stack;
    
    /**
     * Jede Testmethode arbeitet auf einem frisch erzeugten Exemplar.
     */
    public StackTest()
    {
        _stack = new LinkedStack();
    }
    
    /**
     * Stellt sicher, dass ein neuer Stack leer ist.
     */
    public void testNeuerStackIstLeer()
    {
        assertTrue(_stack.isEmpty());
    }

    /**
     * Stellt sicher, dass ein Stack nach einem Push nicht mehr leer ist.
     */
    public void testNachPushNichtLeer()
    {
        _stack.push("test");
        assertFalse(_stack.isEmpty());
    }
    
    /**
     * I am not going to comment this.
     */
    public void testNachPushUndPopWiederLeer()
    {
        _stack.push("Omg");
        _stack.pop();
        assertTrue(_stack.isEmpty());
    }
    
    /**
     * Read the method name and understand.
     */
    public void testPeekEntferntKeinElement()
    {
        _stack.push("test123");
        _stack.peek();
        assertFalse(_stack.isEmpty());
        assertEquals("test123", _stack.peek());
        assertEquals("test123", _stack.pop());
    }

    /**
     * Are you serious about this?
     */
    public void testPeekAufLeeremStackLiefertNull()
    {
        assertNull(_stack.peek());
    }

    /**
     * No I do not want to comment any further.
     */
    public void testPopAufLeeremStackLiefertNull()
    {
        assertNull(_stack.pop());
    }
    
    /**
     * Enough of this.
     */
    public void testLastInFirstOutReihenfolge()
    {
        _stack.push("A");
        _stack.push("B");
        assertEquals("B", _stack.pop());
        assertEquals("A", _stack.pop());
    }
}
