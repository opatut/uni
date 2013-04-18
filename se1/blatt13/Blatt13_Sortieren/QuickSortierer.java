/**
 * Sortiert eine InPlaceSortierbareIntListe mit Quicksort.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
class QuickSortierer implements Sortierer
{
    /**
     * Sortiere die angegebene InPlaceSortierbareIntListe aufsteigend in situ.
     * 
     * @param liste die zu sortierende Liste
     */
    public void sortiere(InPlaceSortierbareIntListe liste)
    {
        sortiere(liste, 0, liste.gibLaenge() - 1);
    }
    
    /**
     * Sortiere den Ausschnitt der InPlaceSortierbareIntListe aufsteigend in situ.
     * 
     * @param liste die zu sortierende Liste
     * @param von der Anfang des Ausschnitts
     * @param bis das Ende des Ausschnitts
     */
    private void sortiere(InPlaceSortierbareIntListe liste, final int von, final int bis)
    {
        if(von < bis) {
            int links = von;
            int rechts = bis - 1;
            
            int p = liste.gib(bis); // das rechte Element ist unser Pivot-Element
           
            while(true) {
                // Suche von links ein Element, welches größer als das Pivotelement ist
                while(liste.gib(links) <= p && links < bis) {
                    links++;
                }
                
                // Suche von rechts ein Element, welches kleiner als das Pivotelement ist
                while(liste.gib(rechts) >= p && rechts > von) {
                    rechts--;
                }
                
                if(links < rechts) {
                    liste.vertausche(links, rechts);
                } else {
                    break;
                }
            }
            
            // Verschiebe Pivot-Element in die Mitte zwischen die Listen (außer wenn das Pivot-Element
            // das größte Element ist, dann ist das unnötig.
            if(liste.gib(links) > p) {
                liste.vertausche(links, bis);
            }
            
            sortiere(liste, von, links - 1);
            sortiere(liste, links + 1, bis);
        }
    }
}
