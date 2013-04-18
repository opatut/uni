/**
 * Sortiert eine InPlaceSortierbareIntListe mit Bubblesort.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
class BubbleSortierer implements Sortierer
{
    /**
     * Sortiere die angegebene InPlaceSortierbareIntListe aufsteigend in situ.
     * @param liste die zu sortierende Liste
     */
    public void sortiere(InPlaceSortierbareIntListe liste)
    {
        for(int n = liste.gibLaenge(); n > 1; n--) {
            // Bubble-Phase für die ersten n Elemente ausführen
            for(int i = 0; i < n - 1; i++) {
                // jedes Element dann mit seinem Nachfolger vertauschen, wenn es größer
                // ist als dieser Nachfolger
                if(liste.gib(i) > liste.gib(i + 1)) {
                    liste.vertausche(i, i + 1);
                }
            }
        }
    }
}
