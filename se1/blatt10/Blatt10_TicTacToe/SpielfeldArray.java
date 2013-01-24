/**
 * Implementierung für das Spielfeld über ein zweidimensionales Array von Integers.
 */
public class SpielfeldArray implements Spielfeld
{
    // Array-Deklaration
    private int[][] _felder;
    
    /**
     * Konstruktor, erstellt ein leeres Spielfeld.
     */
    public SpielfeldArray() {
        _felder = new int[3][3]; // Array-Erzeugung
    }

    public int gibBesitzer(int zeile, int spalte) {
        return _felder[zeile][spalte]; // Lesender Arrayzugriff
    }

    public void besetzePosition(int zeile, int spalte, int spieler) {
        _felder[zeile][spalte] = spieler;  // Schreibender Arrayzugriff
    }

    public boolean istVoll() {
        for(int[] zeile : _felder) {  // Array-Deklaration, Lesender Arrayzugriff
            for(int zelle : zeile) {  // Lesender Arrayzugriff
                if(zelle == 0) {
                    return false;
                }
            }
        }
        return true;
    }
}
