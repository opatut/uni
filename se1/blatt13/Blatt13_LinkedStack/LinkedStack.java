/**
 * Read the tasks to find out what this is supposed to do. Sincerely, an annoyed student.
 */
public class LinkedStack implements Stack
{   
    private Node _firstNode = null;

    public boolean isEmpty() {
        return _firstNode == null;    
    }
    
    public String peek() {
        if(_firstNode == null) {
            return null;
        }
        return _firstNode.content;    
    }
    
    public String pop() {
        if(_firstNode == null) {
            return null;
        }
        String s = _firstNode.content;
        _firstNode = _firstNode.next;
        return s;
    }
    
    public void push(String string) {
        _firstNode = new Node(string, _firstNode);
    }
    
    /**
     * Private sub-class for the nodes of this stack.
     */
    private class Node {
        public Node next;
        public String content;
        
        /**
         * Creates a node.
         */
        public Node(String _content, Node _next) {
            content = _content;
            next = _next;
        }
    }
}
