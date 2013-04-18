/**
 * Ein Sortierer kann eine InPlaceSortierbareIntListe sortieren. In den implementierenden
 * Klassen kann ein beliebiger In-Place-Sortieralgorithmus umgesetzt werden.
 * 
 * @author Petra Becker-Pechau, Fredrik Winkler
 * @version 2007-01
 */
interface Sortierer
{
    /**
     * Sortiere die angegebene InPlaceSortierbareIntListe aufsteigend in situ.
     * @param liste die zu sortierende Liste
     */
    public void sortiere(InPlaceSortierbareIntListe liste);
}
