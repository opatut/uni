/**
 * Schnittstelle eines Stacks, der Strings aufnehmen kann.
 * 
 * @author Till Aust, Petra Becker-Pechau
 * 
 * Version 21. Januar 2010
 */
interface Stack
{
    /**
     * Gib an, ob der Stack leer ist.
     * 
     * @return true, wenn der Stack leer ist, ansonsten false.
     */
    public boolean isEmpty();

    /**
     * Liefere den obersten String auf dem Stack, ohne ihn zu entfernen.<br>
     * Wird diese Operation auf einem leeren Stack ausgefuehrt, gibt sie
     * null zurueck.
     * 
     * @return der oberste String des Stacks, oder null, wenn
     *         der Stack leer ist.
     */
    public String peek();

    /**
     * Entferne den obersten String des Stacks und gib ihn zurueck.<br>
     * Wird diese Operation auf einem leeren Stack ausgefuehrt, gibt sie
     * null zurueck.
     * 
     * @return der oberste String des Stacks, oder null, wenn
     *         der Stack leer ist.
     */
    public String pop();

    /**
     * Lege einen String auf den Stack.
     * 
     * @param string der String, der auf den Stack gelegt werden soll
     */
    public void push(String string);
}
