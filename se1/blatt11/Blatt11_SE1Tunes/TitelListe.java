/**
 * Eine Schnittstelle fuer Titel-Listen. Eine Titel-Liste enthaelt eine Reihe von 
 * Musiktiteln in einer benutzerdefinierten Reihenfolge.
 * <br>
 * Da die Reihenfolge von Musiktiteln sehr wichtig ist, stehen indexbezogene
 * Operationen zur Verfuegung. Duplikate sind zugelassen, weil in einer Titel-Liste
 * derselbe Titel durchaus mehrfach gewuenscht sein kann.
 * 
 * @author Till Aust, Axel Schmolitzky, Petra Becker-Pechau, Christian Spaeh
 * @version Januar 2010
 */
interface TitelListe
{
    /**
     * Fuege einen Titel an der Position <code>position</code> in die Titelliste
     * ein. Alle folgenden Eintraege werden um eine Indexposition verschoben.
     * Wenn <code>position</code> gleich der Laenge der Titelliste ist, dann
     * fuege den <code>titel</code> am Ende an.
     * 
     * @param titel
     *              Ein Titel.
     * @param position
     *              Die Positon des Titels. Der gueltige Bereich ist von 0 bis gibLaenge()-1.
     */
    public void fuegeEin(Titel titel, int position);

    /**
     * Entferne den Titel an der angegebenen Position. Alle folgenden Eintraege
     * werden um eine Indexposition verschoben.<br>
     * 
     * @param position
     *              Eine Position in der Liste. Der gueltige Bereich ist von 0 bis gibLaenge()-1.
     */
    public void entferne(int position);

    /**
     * Pruefe, ob ein Titel in der Liste enthalten ist.
     * 
     * @param titel
     *            Ein Titel.
     * @return Liefert <code>true</code> wenn der Titel in der Liste ist,
     *         ansonsten <code>false</code>.
     */
    public boolean enthaelt(Titel titel);

    /**
     * Gib den Titel an der angegebenen Position zurueck.
     * 
     * @param position
     *              Die Position des Titels, der zurueckgeben werden soll.
     *              Der gueltige Bereich ist von 0 bis gibLaenge()-1.
     * @return Den Titel auf der Position <code>position</code>.
     */
    public Titel gibTitel(int position);

    /**
     * Gib die Laenge der Liste zurueck.
     * 
     * @return Anzahl der Titel in der Liste.
     */
    public int gibLaenge();

    /**
     * Entferne alle Titel aus der Liste.
     */
    public void leere();
}
