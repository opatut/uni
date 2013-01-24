
public class SpielfeldArray implements Spielfeld
{
    private int[][] _felder;
    
    public SpielfeldArray() {
        _felder = new int[HOEHE][BREITE];
    }

    public boolean istSpielfeldVoll() {
        for(int y = 0; y < HOEHE - 1; y++) {
            for(int x = 0; x < BREITE - 1; x++) {
                if(_felder[y][x] == 0) {
                    return false;
                }
            }
        }
        return true;
    }

    public boolean istSpalteVoll(int spalte) {
        // die spalte ist voll wenn das oberste feld belegt (!=0) ist
        return _felder[HOEHE - 1][spalte] != 0;
    }

    public int gibBesitzer(int zeile, int spalte) {
        return _felder[zeile][spalte];
    }

    public void legeSpielsteinAb(int spalte, int spieler) {
        for(int y = HOEHE - 1; ; --y) {
            if(y == 0 || gibBesitzer(y - 1, spalte) != 0) {
                _felder[y][spalte] = spieler;
                return;
            }
        }
    }
}
