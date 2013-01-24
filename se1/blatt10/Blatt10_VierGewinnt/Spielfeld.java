/**
 * Ein Spielfeld besteht aus mehreren gleich hohen Spalten, in denen 
 * man Spielsteine ablegen kann.
 * 
 * Das Spielfeld geht davon aus, dass es genau zwei Spieler gibt, Spieler 1 und 
 * Spieler 2. Ein unbesetztes Feld wird mit dem Wert 0 markiert.
 * 
 * Das Spielfeld hat 7 Spalten, in die man jeweils maximal 6 Steine werfen kann.
 * Die Zeilen werden von unten gezaehlt, d.h. die unterste Zeile hat die Nummer 0.
 * 
 * @author Fredrik Winkler
 * @author Petra Becker-Pechau
 * @version 17. Dezember 2012
 */
interface Spielfeld
{
    public static final int BREITE = 7;
    public static final int HOEHE = 6;

    /**
     * Gibt an, ob das Spielfeld voll ist.
     */
    public boolean istSpielfeldVoll();

    /**
     * Gibt an, ob die Spalte voll ist.
     */
    public boolean istSpalteVoll(int spalte);

    /**
     * Gibt den Besitzer der angegebenen Position auf dem Spielfeld.
     * 
     * @param zeile
     *            vertikale Position
     * @param spalte
     *            horizontale Position
     * @return 0 (unbesetzt), 1 (Spieler 1), 2 (Spieler 2)
     */
    public int gibBesitzer(int zeile, int spalte);

    /**
     * Legt einen Spielstein in einer Spalte ab.
     * 
     * @param spalte
     *            die Spalte
     * @param spieler
     *            1 (Spieler 1), 2 (Spieler 2)
     */
    public void legeSpielsteinAb(int spalte, int spieler);
}
